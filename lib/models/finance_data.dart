class FinanceCO2Data {
  String label; // Day, Week, or Month
  double income;
  double expense;
  double co2; // Carbon footprint in kg

  FinanceCO2Data({
    required this.label,
    required this.income,
    required this.expense,
    required this.co2,
  });
}

List<FinanceCO2Data> mockData = [
  FinanceCO2Data(label: 'Mon', income: 300, expense: 150, co2: 2.5),
  FinanceCO2Data(label: 'Tue', income: 250, expense: 100, co2: 1.8),
  FinanceCO2Data(label: 'Wed', income: 400, expense: 200, co2: 3.2),
  FinanceCO2Data(label: 'Thu', income: 320, expense: 180, co2: 2.7),
  FinanceCO2Data(label: 'Fri', income: 280, expense: 150, co2: 2.0),
  FinanceCO2Data(label: 'Sat', income: 500, expense: 300, co2: 4.5),
  FinanceCO2Data(label: 'Sun', income: 450, expense: 250, co2: 3.8),
];
