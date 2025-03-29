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
}
