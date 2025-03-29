class TransactionItem {
  String name;
  String category;
  String quantity;
  double price;
  double carbon_footprint;

  TransactionItem(
      {this.name = '',
      this.category = 'Food',
      this.quantity = '',
      this.price = 0.00,
      this.carbon_footprint = 0.00});

  // From JSON
  factory TransactionItem.fromJson(Map<String, dynamic> json) {
    return TransactionItem(
      name: json['name'] ?? '',
      category: json['category'] ?? 'Food',
      quantity: json['quantity'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      carbon_footprint: (json['carbon_footprint'] ?? 0).toDouble(),
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'category': category,
      'quantity': quantity,
      'price': price,
      'carbon_footprint': carbon_footprint,
    };
  }
}
