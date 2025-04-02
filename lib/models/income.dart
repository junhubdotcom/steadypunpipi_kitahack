class Income {
  String name;
  String category;
  double amount;
  String paymentMethod;
  DateTime time;
  String? location; // Optional
  String? proofOfIncome; // Optional

  Income({
    this.name = '',
    this.category = 'Salary',
    this.amount = 0.00,
    this.paymentMethod = 'Bank Transfer', // Default method
    DateTime? time, // Allow null and set default
    this.location,
    this.proofOfIncome,
  }) : time = time ?? DateTime.now(); // Default to now

  // Convert Income object to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'category': category,
      'amount': amount,
      'paymentMethod': paymentMethod,
      'time': time.toIso8601String(), // Convert DateTime to string
      'location': location,
      'proofOfIncome': proofOfIncome,
    };
  }

  // Create Income object from JSON
  factory Income.fromJson(Map<String, dynamic> json) {
    return Income(
      name: json['name'] ?? '',
      category: json['category'] ?? 'Salary',
      amount: (json['amount'] ?? 0).toDouble(),
      paymentMethod: json['paymentMethod'] ?? 'Bank Transfer',
      time: DateTime.tryParse(json['time'] ?? '') ?? DateTime.now(),
      location: json['location'],
      proofOfIncome: json['proofOfIncome'],
    );
  }
}
