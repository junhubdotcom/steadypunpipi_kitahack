import 'package:steadypunpipi_vhack/models/expense_item.dart';

class Expense {
  String? transactionName;
 
  List<ExpenseItem> items;
  String paymentMethod;
  DateTime dateTime;
  String? location;
  String? receiptImagePath;
  String? additionalImagePath;

  Expense({
    String? transactionName,
    List<ExpenseItem>? items,
    String? paymentMethod,
    DateTime? dateTime,
    String? location,
    String? receiptImagePath,
    String? additionalImagePath,
  })  : transactionName = transactionName ?? "",
        
        items = items ?? [ExpenseItem()],
        paymentMethod = paymentMethod ?? "Cash",
        dateTime = dateTime ?? DateTime.now(),
        location = location ?? "",
        receiptImagePath = receiptImagePath ?? "",
        additionalImagePath = additionalImagePath ?? "";

  // From JSON
  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      transactionName: json['transactionName'] ?? "",
     
      paymentMethod: json['paymentMethod'] ?? "Cash",
      items: (json['items'] as List<dynamic>)
          .map((item) => ExpenseItem.fromJson(item))
          .toList(),
      // You can handle the following fields if Gemini returns them later or set defaults
      dateTime: DateTime.tryParse(json['dateTime'] ?? "") ?? DateTime.now(),
      location: json['location'] ?? "",
      receiptImagePath: json['receiptImagePath'] ?? "",
      additionalImagePath: "",
    );
  }

  // Optional: To JSON
  Map<String, dynamic> toJson() {
    return {
      'transactionName': transactionName,
  
      'paymentMethod': paymentMethod,
      'items': items.map((item) => item.toJson()).toList(),
      'dateTime': dateTime.toIso8601String(),
      'location': location,
      'receiptImagePath': receiptImagePath,
      'additionalImagePath': additionalImagePath,
    };
  }
}
