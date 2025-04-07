import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:steadypunpipi_vhack/models/expense_item.dart';

class Expense {
  String? transactionName;

  List<String> items;
  String paymentMethod;
  Timestamp dateTime;
  String? location;
  String? receiptImagePath;
  String? additionalImagePath;

  Expense({
    String? transactionName,
    List<String>? items,
    String? paymentMethod,
    Timestamp? dateTime,
    String? location,
    String? receiptImagePath,
    String? additionalImagePath,
  })  : transactionName = transactionName ?? "",
        items = items ?? [""],
        paymentMethod = paymentMethod ?? "Cash",
        dateTime = dateTime ?? Timestamp.now(),
        location = location ?? "None",
        receiptImagePath = receiptImagePath ?? "",
        additionalImagePath = additionalImagePath ?? "";

  // From JSON
  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      transactionName: json['transactionName'] ?? "",

      paymentMethod: json['paymentMethod'] ?? "Cash",
      items: json['items'] ?? [""],
      // You can handle the following fields if Gemini returns them later or set defaults
      dateTime: json['dateTime'] is Timestamp
          ? json['dateTime'] as Timestamp
          : Timestamp.now(),
      location: json['location'] ?? "",
      receiptImagePath: json['receiptImagePath'] ?? "",
      additionalImagePath: "",
    );
  }

  // Optional: To JSON
  Map<String, dynamic> toJson() {
    final data = {
      'transactionName': transactionName,
      'paymentMethod': paymentMethod,
      'items': items,
      'dateTime': dateTime,
      'location': location,
      'receiptImagePath': receiptImagePath,
      'additionalImagePath': additionalImagePath,
    };

    if (items != null && items.toString().isNotEmpty) {
      data['items'] = items;
    }

    return data;
  }
}
