import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:steadypunpipi_vhack/models/breakdown_item.dart';
import 'package:steadypunpipi_vhack/models/finance_data.dart';
import 'package:steadypunpipi_vhack/models/transaction_model.dart';

class TransactionService {
  List<TransactionModel> _transactions = [];

  // Load transactions from JSON file
  Future<void> loadTransactions() async {
    if (_transactions.isNotEmpty) return; // Prevent reloading if already loaded

    try {
      final String response =
          await rootBundle.loadString('assets/transactions.json');
      final data = json.decode(response);

      _transactions = (data['transactions'] as List)
          .map((tx) => TransactionModel.fromJSON(tx))
          .toList();

      print("✅ Transactions loaded successfully: ${_transactions.length}");
    } catch (e) {
      print("🚨 Error loading transactions: $e");
    }
  }

  // Ensure transactions are loaded before filtering
  Future<void> ensureTransactionsLoaded() async {
    if (_transactions.isEmpty) {
      print("📥 Loading transactions...");
      await loadTransactions();
    }
  }

  // Debugging: Print loaded transactions
  void debugTransactions() {
    print("📊 Transactions Loaded: ${_transactions.length}");
    for (var tx in _transactions) {
      print("🔹 ${tx.date} - ${tx.category} - ${tx.amount}");
    }
  }

  // Filter transactions based on time range
  List<TransactionModel> filterTransactions(
      DateTime startDate, DateTime endDate) {
    print("📅 Filtering Transactions from $startDate to $endDate");
    print(
        "📜 All Transactions Dates: ${_transactions.map((tx) => tx.date).toList()}");

    List<TransactionModel> filtered = _transactions.where((tx) {
      bool isWithinRange =
          tx.date.isAfter(startDate.subtract(Duration(days: 1))) &&
              tx.date.isBefore(endDate.add(Duration(days: 1)));

      if (isWithinRange) print("✅ Matched Transaction: ${tx.toJSON()}");

      return isWithinRange;
    }).toList();

    print("🔍 Filtered Transactions (${filtered.length}): $filtered");
    return filtered;
  }

  // Filter transactions by type
  Future<List<BreakdownItem>> fetchExpenses() async {
    await ensureTransactionsLoaded();

    Map<String, double> expenseMap = {};

    for (var tx in _transactions) {
      if (tx.type == 'expense') {
        expenseMap.update(tx.category, (value) => value + tx.amount,
            ifAbsent: () => tx.amount);
      }
    }

    return expenseMap.entries
        .map((e) => BreakdownItem(category: e.key, value: e.value))
        .toList();
  }

  Future<List<BreakdownItem>> fetchIncome() async {
    await ensureTransactionsLoaded();

    Map<String, double> incomeMap = {};

    for (var tx in _transactions) {
      if (tx.type == 'income') {
        incomeMap.update(tx.category, (value) => value + tx.amount,
            ifAbsent: () => tx.amount);
      }
    }

    return incomeMap.entries
        .map((e) => BreakdownItem(category: e.key, value: e.value))
        .toList();
  }

  Future<List<BreakdownItem>> fetchCO2() async {
    await ensureTransactionsLoaded();

    Map<String, double> co2Map = {};

    for (var tx in _transactions) {
      if (tx.carbonFootprint != null) {
        co2Map.update(tx.category, (value) => value + tx.carbonFootprint!,
            ifAbsent: () => tx.carbonFootprint!);
      }
    }

    return co2Map.entries
        .map((e) => BreakdownItem(category: e.key, value: e.value))
        .toList();
  }

  Future<List<FinanceCO2Data>> processFCO2(
      List<TransactionModel> transactions, String period) async {
    await ensureTransactionsLoaded();

    Map<String, FinanceCO2Data> groupedData = {};

    for (var transaction in transactions) {
      String key = getGroupingKey(transaction.date, period);

      if (!groupedData.containsKey(key)) {
        groupedData[key] =
            FinanceCO2Data(label: key, income: 0, expense: 0, co2: 0);
      }

      if (transaction.type == 'income') {
        groupedData[key]!.income += transaction.amount;
      } else {
        groupedData[key]!.expense += transaction.amount;
        groupedData[key]!.co2 += transaction.carbonFootprint ?? 0;
      }
    }

    return groupedData.values.toList();
  }

  String getGroupingKey(DateTime date, String period) {
    if (period == "Daily") {
      String timeSlot = getTimeSlot(date);
      return "$timeSlot";
    } else if (period == "Weekly") {
      DateTime startOfWeek = getStartOfWeek(date);
      return "${startOfWeek.day}/${startOfWeek.month}";
    } else if (period == "Monthly") {
      int weekInMonth = getWeekInMonth(date);
      return "Week $weekInMonth";
    } else {
      return "${date.year}-${date.month}";
    }
  }

  /// **Returns the time slot (6-hour interval)**
  String getTimeSlot(DateTime date) {
    int hour = date.hour;

    if (hour < 6) {
      return "12AM";
    } else if (hour < 12) {
      return "6AM";
    } else if (hour < 18) {
      return "12PM";
    } else {
      return "6PM";
    }
  }

  /// Get the Sunday of the current week
  DateTime getStartOfWeek(DateTime date) {
    int daysSinceSunday =
        date.weekday % 7; // Convert Monday-Sunday (1-7) to (0-6)
    return date.subtract(Duration(days: daysSinceSunday));
  }

  /// Get the week number in a month (1-5)
  int getWeekInMonth(DateTime date) {
    DateTime firstDayOfMonth = DateTime(date.year, date.month, 1);
    int firstDayWeekday =
        firstDayOfMonth.weekday % 7; // Convert Mon-Sun (1-7) to (0-6)
    return ((date.day + firstDayWeekday - 1) ~/ 7) + 1;
  }
}
