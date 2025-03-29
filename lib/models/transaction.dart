import 'package:steadypunpipi_vhack/models/transaction_item.dart';

class Transaction {
  String transactionName;
  bool isMultipleItem;
  List<TransactionItem> items;
  String paymentMethod;
  DateTime dateTime;
  String location;
  String? receiptImagePath;
  List<String?> additionalImagePath;

  Transaction({
    String? transactionName,
    bool? isMultipleItem,
    List<TransactionItem>? items,
    String? paymentMethod,
    DateTime? dateTime,
    String? location,
    String? receiptImagePath,
    List<String?>? additionalImagePath,
  })  : transactionName = transactionName ?? "",
        isMultipleItem = isMultipleItem ?? false,
        items = items ?? [TransactionItem()],
        paymentMethod = paymentMethod ?? "Cash",
        dateTime = dateTime ?? DateTime.now(),
        location = location ?? "",
        receiptImagePath = receiptImagePath ?? "",
        additionalImagePath = additionalImagePath ?? [""];

        // From JSON
  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      transactionName: json['transactionName'] ?? "",
      isMultipleItem: json['isMultipleItem'] ?? false,
      paymentMethod: json['paymentMethod'] ?? "Cash",
      items: (json['items'] as List<dynamic>)
          .map((item) => TransactionItem.fromJson(item))
          .toList(),
      // You can handle the following fields if Gemini returns them later or set defaults
      dateTime: DateTime.now(),
      location: "",
      receiptImagePath: "",
      additionalImagePath: [""],
    );
  }

  // Optional: To JSON
  Map<String, dynamic> toJson() {
    return {
      'transactionName': transactionName,
      'isMultipleItem': isMultipleItem,
      'paymentMethod': paymentMethod,
      'items': items.map((item) => item.toJson()).toList(),
      'dateTime': dateTime.toIso8601String(),
      'location': location,
      'receiptImagePath': receiptImagePath,
      'additionalImagePath': additionalImagePath,
    };
  }

}


