import 'package:flutter/material.dart';
import 'package:steadypunpipi_vhack/models/finance_data.dart';
import 'package:steadypunpipi_vhack/widgets/dashboard_widgets/expandable_card.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TrendSection extends StatelessWidget {
  final List<FinanceCO2Data> data;
  final String title;

  const TrendSection({super.key, required this.data, required this.title});

  @override
  Widget build(BuildContext context) {
    return ExpandableCard(
      title: "Trend",
      subtitle: "Spot patterns, stay ahead",
      icon: Icons.show_chart_outlined,
      tabs: const [
        Tab(text: "Income vs Expense"),
        Tab(text: "Expense & CO₂"),
      ],
      tabViews: [
        FinanceBarChart(data: data, title: title),
        ExpenseCO2Chart(data: data, title: title),
      ],
    );
  }
}

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

class ExpenseCO2Chart extends StatelessWidget {
  final List<FinanceCO2Data> data;
  final String title; // "Daily", "Weekly", or "Monthly"

  const ExpenseCO2Chart({required this.data, required this.title, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      title: ChartTitle(text: '$title Expense & CO₂ Emissions'),
      legend: Legend(isVisible: true, position: LegendPosition.bottom),
      primaryXAxis: CategoryAxis(title: AxisTitle(text: title)),

      // Primary Y-Axis for Expense
      primaryYAxis: NumericAxis(
        title: AxisTitle(text: 'Expense (RM)'),
        opposedPosition: false, // Left Side
      ),

      // Secondary Y-Axis for CO₂
      axes: [
        NumericAxis(
          name: 'co2Axis',
          title: AxisTitle(text: 'CO₂ (kg)'),
          opposedPosition: true, // Right Side
        ),
      ],

      series: <CartesianSeries>[
        // Stacked Bar for Expense
        StackedColumnSeries<FinanceCO2Data, String>(
          name: 'Expense (RM)',
          dataSource: data,
          xValueMapper: (FinanceCO2Data item, _) => item.label,
          yValueMapper: (FinanceCO2Data item, _) => item.expense,
          color: Colors.blue,
          dataLabelSettings: DataLabelSettings(isVisible: true),
        ),
        // Line Chart for CO₂ Trend (Secondary Axis)
        LineSeries<FinanceCO2Data, String>(
          name: 'CO₂ (kg)',
          dataSource: data,
          xValueMapper: (FinanceCO2Data item, _) => item.label,
          yValueMapper: (FinanceCO2Data item, _) => item.co2,
          color: Colors.red,
          markerSettings: MarkerSettings(isVisible: true),
          dataLabelSettings: DataLabelSettings(isVisible: true),
          yAxisName: 'co2Axis', // Bind to Secondary Y-Axis
        ),
      ],
    );
  }
}
