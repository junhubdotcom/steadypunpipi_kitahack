import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:steadypunpipi_vhack/models/expense_itemalt.dart'; 

class Expense {
  final String? additionalImagePath;
  final Timestamp? dateTime;
  final List<DocumentReference<ExpenseItem>>? items;
  final String? location;
  final String? paymentMethod;
  final String? receiptImagePath;
  final String? transactionName;

  Expense({
    this.additionalImagePath,
    this.dateTime,
    this.items,
    this.location,
    this.paymentMethod,
    this.receiptImagePath,
    this.transactionName,
  });

  Expense copyWith({
    String? additionalImagePath,
    Timestamp? dateTime,
    List<DocumentReference<ExpenseItem>>? items,
    String? location,
    String? paymentMethod,
    String? receiptImagePath,
    String? transactionName,
  }) {
    return Expense(
      additionalImagePath: additionalImagePath ?? this.additionalImagePath,
      dateTime: dateTime ?? this.dateTime,
      items: items ?? this.items,
      location: location ?? this.location,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      receiptImagePath: receiptImagePath ?? this.receiptImagePath,
      transactionName: transactionName ?? this.transactionName,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'additionalImagePath': additionalImagePath,
      'dateTime': dateTime,
      'items': items,
      'location': location,
      'paymentMethod': paymentMethod,
      'receiptImagePath': receiptImagePath,
      'transactionName': transactionName,
    };
  }

  factory Expense.fromJson(Map<String, dynamic> json) {
    final rawItemRefs = json['items'];
    List<DocumentReference<ExpenseItem>>? typedItemRefs;

    if (rawItemRefs is List) {
      typedItemRefs = rawItemRefs.map((rawRef) {
        if (rawRef is DocumentReference) {
          return (rawRef as DocumentReference).withConverter<ExpenseItem>(
            fromFirestore: (snapshot, _) {
              if (!snapshot.exists || snapshot.data() == null) {
                print(
                    "Warning: Referenced ExpenseItem document ${snapshot.id} does not exist or has no data.");
                throw Exception(
                    "Referenced ExpenseItem document ${snapshot.id} not found or has null data.");
              }
              return ExpenseItem.fromJson(snapshot.data()!);
            },
            toFirestore: (item, _) => item.toJson(),
          );
        } else {
          print("Warning: Item in 'items' array is not a DocumentReference: $rawRef");
          return null; // Or handle this error as needed
        }
      }).whereType<DocumentReference<ExpenseItem>>().toList(); // Filter out nulls
    } else if (rawItemRefs != null) {
      print("Warning: 'items' field was not a List: $rawItemRefs");
      typedItemRefs = null;
    } else {
      typedItemRefs = null;
    }

    return Expense(
      additionalImagePath: json['additionalImagePath'],
      dateTime: json['dateTime'] as Timestamp?,
      items: typedItemRefs,
      location: json['location'],
      paymentMethod: json['paymentMethod'],
      receiptImagePath: json['receiptImagePath'],
      transactionName: json['transactionName'],
    );
  }
}