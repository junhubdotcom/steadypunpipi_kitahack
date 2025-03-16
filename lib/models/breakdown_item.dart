class BreakdownItem {
  final String category;
  final double value;

  BreakdownItem({required this.category, required this.value});
}
 
List<BreakdownItem> fetchExpenses() {
  return [
    BreakdownItem(category: "Shopping", value: 200),
    BreakdownItem(category: "Food", value: 150),
    BreakdownItem(category: "Transport", value: 80),
    BreakdownItem(category: "Bills", value: 100),
  ];
}

List<BreakdownItem> fetchIncome() {
  return [
    BreakdownItem(category: "Salary", value: 3000),
    BreakdownItem(category: "Freelance", value: 1200),
    BreakdownItem(category: "Investments", value: 800),
  ];
}

List<BreakdownItem> fetchCO2() {
  return [
    BreakdownItem(category: "Transport", value: 0.5),
    BreakdownItem(category: "Shopping", value: 0.1),
  ];
}