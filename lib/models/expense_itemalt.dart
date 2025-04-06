import 'package:cloud_firestore/cloud_firestore.dart';

class ExpenseItem {
  final num? carbonFootprint;
  final String? category;
  final String? name;
  final num? price;
  final num? quantity;

  ExpenseItem({
    this.carbonFootprint,
    this.category,
    this.name,
    this.price,
    this.quantity,
  });

  ExpenseItem copyWith({
    num? carbonFootprint,
    String? category,
    String? name,
    num? price,
    num? quantity,
  }) {
    return ExpenseItem(
      carbonFootprint: carbonFootprint ?? this.carbonFootprint,
      category: category ?? this.category,
      name: name ?? this.name,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'carbon_footprint': carbonFootprint,
      'category': category,
      'name': name,
      'price': price,
      'quantity': quantity,
    };
  }

  factory ExpenseItem.fromJson(Map<String, dynamic> json) {
    return ExpenseItem(
      carbonFootprint: json['carbon_footprint'],
      category: json['category'],
      name: json['name'],
      price: json['price'],
      quantity: json['quantity'],
    );
  }
}