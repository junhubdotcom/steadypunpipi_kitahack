import 'package:flutter/material.dart';
import 'package:steadypunpipi_vhack/models/finance_data.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class FinanceBarChart extends StatelessWidget {
  final List<FinanceCO2Data> data;
  final String title; // Title can be "Daily", "Weekly", or "Monthly"

  FinanceBarChart({required this.data, required this.title});

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      title: ChartTitle(text: '$title Income vs Expense'),
      legend: Legend(isVisible: true, position: LegendPosition.bottom),
      primaryXAxis: CategoryAxis(title: AxisTitle(text: title)),
      primaryYAxis: NumericAxis(title: AxisTitle(text: 'Amount (RM)')),
      series: <CartesianSeries>[
        // Income Bars
        ColumnSeries<FinanceCO2Data, String>(
          name: 'Income',
          dataSource: data,
          xValueMapper: (FinanceCO2Data finance, _) => finance.label,
          yValueMapper: (FinanceCO2Data finance, _) => finance.income,
          color: Colors.green,
          dataLabelSettings: DataLabelSettings(isVisible: true),
        ),
        // Expense Bars
        ColumnSeries<FinanceCO2Data, String>(
          name: 'Expense',
          dataSource: data,
          xValueMapper: (FinanceCO2Data finance, _) => finance.label,
          yValueMapper: (FinanceCO2Data finance, _) => finance.expense,
          color: Colors.red,
          dataLabelSettings: DataLabelSettings(isVisible: true),
        ),
      ],
    );
  }
}
