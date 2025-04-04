import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:steadypunpipi_vhack/models/expensealt.dart';
import 'package:steadypunpipi_vhack/models/expense_itemalt.dart';

const String EXPENSE_COLLECTION_REF = "Expense";
const String EXPENSE_ITEM_COLLECTION_REF = "ExpenseItem";

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference<Expense> get expensesCollection =>
      _firestore.collection(EXPENSE_COLLECTION_REF).withConverter<Expense>(
          fromFirestore: (snapshots, _) => Expense.fromJson(
                snapshots.data()!,
              ),
          toFirestore: (expense, _) => (expense as Expense).toJson());

  CollectionReference<ExpenseItem> get expenseItemsCollection => _firestore
      .collection(EXPENSE_ITEM_COLLECTION_REF)
      .withConverter<ExpenseItem>(
          fromFirestore: (snapshots, _) => ExpenseItem.fromJson(
                snapshots.data()!,
              ),
          toFirestore: (expenseItem, _) =>
              (expenseItem as ExpenseItem).toJson());

  DatabaseService() {}

  Future<List<Expense>> getAllExpenses() async {
    try {
      QuerySnapshot<Expense> snapshot = await expensesCollection.get();
      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print("Error getting all expenses: $e");
      return []; // Or handle the error as needed
    }
  }

  Future<DocumentReference<Expense>> addExpense(Expense expense) async {
    return await expensesCollection.add(expense);
  }

  Future<void> updateExpense(String expenseId, Expense expense) async {
    await expensesCollection.doc(expenseId).update(expense.toJson());
  }

  Future<Expense?> getExpense(String expenseId) async {
    final snapshot = await expensesCollection.doc(expenseId).get();
    return snapshot.data();
  }

  Future<void> deleteExpense(String expenseId) async {
    await expensesCollection.doc(expenseId).delete();
  }

  Future<DocumentReference<ExpenseItem>> addExpenseItem(
      ExpenseItem expenseItem) async {
    return await expenseItemsCollection.add(expenseItem);
  }

  Future<ExpenseItem?> getExpenseItem(String expenseItemId) async {
    final snapshot = await expenseItemsCollection.doc(expenseItemId).get();
    return snapshot.data();
  }
}
