
import { onDocumentCreated } from 'firebase-functions/v2/firestore';
import { onSchedule } from 'firebase-functions/v2/scheduler';
import { initializeApp } from 'firebase-admin/app';
import { getFirestore, Timestamp } from 'firebase-admin/firestore';
import axios from 'axios';

initializeApp();
const db = getFirestore();

const GEMINI_API_KEY = 'AIzaSyCIWb3At_0Q-QyZccNX0zlujY8KVCYc2ns';
const GEMINI_URL = `https://generativelanguage.googleapis.com/v1/models/gemini-1.5-pro:generateContent?key=${GEMINI_API_KEY}`;

// ==================== Utility Functions ====================

function getToday() {
  const now = new Date();
  now.setHours(now.getHours() + 8); // GMT+8
  return now;
}

function getDayRange(date) {
  const start = new Date(date.getFullYear(), date.getMonth(), date.getDate());
  const end = new Date(start);
  end.setDate(start.getDate() + 1);
  return { start, end };
}

function getWeekRange(date) {
  const day = date.getDay(); // Sunday = 0
  const start = new Date(date);
  start.setDate(start.getDate() - (day === 0 ? 6 : day - 1)); // Monday is the first day of the week!
  start.setHours(0, 0, 0, 0);
  const end = new Date(start);
  end.setDate(start.getDate() + 7);
  return { start, end };
}

function getMonthRange(date) {
  const start = new Date(date.getFullYear(), date.getMonth(), 1);
  const end = new Date(date.getFullYear(), date.getMonth() + 1, 1);
  return { start, end };
}

function getWeekNumber(date) {
  const d = new Date(Date.UTC(date.getFullYear(), date.getMonth(), date.getDate()));
  const dayNum = d.getUTCDay() || 7;
  d.setUTCDate(d.getUTCDate() + 4 - dayNum);
  const yearStart = new Date(Date.UTC(d.getUTCFullYear(), 0, 1));
  return Math.ceil((((d - yearStart) / 86400000) + 1) / 7);
}

function getDateId(prefix, date) {
  const y = date.getFullYear();
  const m = String(date.getMonth() + 1).padStart(2, '0');
  const d = String(date.getDate()).padStart(2, '0');
  return `${prefix}_${y}-${m}${prefix === 'monthly' ? '' : `-${d}`}`;
}

// Get and parse transactions from income/expense in Firestore 
async function collectTransactions(start, end) {
  const transactions = [];

  const incomeSnap = await db.collection('Income')
    .where('time', '>=', start)
    .where('time', '<', end)
    .get();

  incomeSnap.forEach(doc => {
    const d = doc.data();
    transactions.push({
      id: doc.id,
      date: d.dateTime.toDate().toISOString(),
      category: d.category || 'Unknown',
      amount: d.amount,
      type: 'income',
      description: d.name || '',
      carbon_footprint: 0
    });
  });

  const expenseSnap = await db.collection('Expense')
    .where('dateTime', '>=', start)
    .where('dateTime', '<', end)
    .get();

  for (const expenseDoc of expenseSnap.docs) {
    const expense = expenseDoc.data();
    const itemsRef = expense.items || [];

    for (const itemRef of itemsRef) {
      if (!itemRef) continue;
      const itemSnap = await itemRef.get();
      if (!itemSnap.exists) continue;
      const item = itemSnap.data();

      transactions.push({
        id: expenseDoc.id,
        date: expense.dateTime.toDate().toISOString(),
        category: item.category || 'General',
        amount: item.price * (item.quantity || 1),
        type: 'expense',
        description: item.name || expense.transactionName || '',
        carbon_footprint: item.carbon_footprint || 0
      });
    }
  }

  return transactions;
}

// Call Gemini 
async function getAIInsights(transactions, dateRange) {
  const prompt = ` Analyze the transactions within the provided date range. Identify spending trends, and provide insights into the user's financial behaviors and habits and the carbon footprint produced. Additionally, based on the transaction data, provide at least two concise financial tips and two environmental tips aimed at reducing the user's carbon footprint. If applicable, you may provide more than two tips.
        
  The transaction currency is in RM. The unit for carbon footprint is kg.

  Ensure the insights is a short narrative paragraph that user can quickly know what is happening in summary section of the dashboard

  Ensure the financial tips are based on spending behavior, and the environmental tips should be informed by the carbon footprint data tied to each transaction.

  Each tip should be concise (max 20 words) and easily actionable.

  If no transactions are provided, return default suggestions or insights indicating the lack of data.

  Return in this format:
  {
    "insights": [""],
    "financeTips": ["", ""],
    "environmentTips": ["", ""]
  }

  Date Range: ${dateRange}
  Transactions: ${JSON.stringify(transactions)}
  `;

  const res = await axios.post(GEMINI_URL, {
    contents: [{ parts: [{ text: prompt }] }]
  });

  let text = res.data?.candidates?.[0]?.content?.parts?.[0]?.text || '{}';
  text = text.replace(/```json|```/g, '').trim();
  return JSON.parse(text);
}

// Write insights to Firestore
async function writeInsights(id, insights) {
  await db.collection('InsightsSummary').doc(id).set({
    ...insights,
    generatedAt: Timestamp.now(),
  });
}

// Generate insights on transaction created
export const onIncomeCreated = onDocumentCreated('Income/{id}', async (event) => {
  await handleTransactionEvent(event);
});

export const onExpenseCreated = onDocumentCreated('Expense/{id}', async (event) => {
  await handleTransactionEvent(event);
});

async function handleTransactionEvent(event) {
  const snapshot = event.data;

  if (!snapshot?.data) {
    console.log("⚠️ No event data found.");
    return;
  }

  const doc = snapshot.data();

  if (!doc?.dateTime) {
    console.log("⚠️ No dateTime field in document.");
    return;
  }

  const txnDate = doc.dateTime.toDate();

  const now = getToday();
  const txnWeek = getWeekNumber(txnDate);
  const currentWeek = getWeekNumber(now);

  const updateDaily = true;
  const updateWeekly = txnWeek !== currentWeek;
  const updateMonthly =
    txnDate.getMonth() !== now.getMonth() ||
    txnDate.getFullYear() !== now.getFullYear();

  if (updateDaily) {
    const { start, end } = getDayRange(txnDate);
    const transactions = await collectTransactions(start, end);
    const insights = await getAIInsights(transactions, `${start.toISOString()} - ${end.toISOString()}`);
    const id = getDateId('daily', start);
    await writeInsights(id, insights);
  }

  if (updateWeekly) {
    const { start, end } = getWeekRange(txnDate);
    const transactions = await collectTransactions(start, end);
    const insights = await getAIInsights(transactions, `${start.toISOString()} - ${end.toISOString()}`);
    const id = getDateId('weekly', start);
    await writeInsights(id, insights);
  }

  if (updateMonthly) {
    const { start, end } = getMonthRange(txnDate);
    const transactions = await collectTransactions(start, end);
    const insights = await getAIInsights(transactions, `${start.toISOString()} - ${end.toISOString()}`);
    const id = getDateId('monthly', start);
    await writeInsights(id, insights);
  }
}

// Generate insights on schedule
export const generateWeeklyInsights = onSchedule('0 16 * * *', async () => {
  const today = getToday();
  const { start, end } = getWeekRange(today);
  const transactions = await collectTransactions(start, end);
  const insights = await getAIInsights(transactions, `${start.toISOString()} - ${end.toISOString()}`);
  const id = getDateId('weekly', start);
  await writeInsights(id, insights);
});

export const generateMonthlyInsights = onSchedule('0 16 * * *', async () => {
  const today = getToday();
  const { start, end } = getMonthRange(today);
  const transactions = await collectTransactions(start, end);
  const insights = await getAIInsights(transactions, `${start.toISOString()} - ${end.toISOString()}`);
  const id = getDateId('monthly', start);
  await writeInsights(id, insights);
});

// Update daily insights for every income recorded
// export const generateDailyInsightsFromIncome = onDocumentCreated('incomes/{id}', async (event) => {
//   const data = event.data?.data();
//   if (!data?.dateTime) {
//     console.log("⚠️ No dateTime found in income document.");
//     return;
//   }

//   const date = data.dateTime.toDate(); // 👈 using dateTime field
//   const { start, end } = getDayRange(date);
//   const transactions = await collectTransactions(start, end);
//   const insights = await getAIInsights(transactions, ${start.toISOString()} - ${end.toISOString()});
//   const dailyId = getDailyId(start);

//   await db.collection('insights_summary').doc(dailyId).set({
//     ...insights,
//     generatedAt: Timestamp.now(),
//   });

//   console.log(✅ Insight saved to insights_summary/${dailyId});
// });
// 
// // Update daily insights for every expense recorded
// export const generateDailyInsightsFromExpense = onDocumentCreated('expenses/{id}', async (event) => {
//   const data = event.data?.data();
//   if (!data?.dateTime) {
//     console.log("⚠️ No dateTime found in expense document.");
//     return;
//   }

//   const date = data.dateTime.toDate();
//   const { start, end } = getDayRange(date);
//   const transactions = await collectTransactions(start, end);
//   const insights = await getAIInsights(transactions, ${start.toISOString()} - ${end.toISOString()});
//   const dailyId = getDailyId(start);

//   await db.collection('insights_summary').doc(dailyId).set({
//     ...insights,
//     generatedAt: Timestamp.now(),
//   });

//   console.log(✅ Insight saved to insights_summary/${dailyId});
// });

