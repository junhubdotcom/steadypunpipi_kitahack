import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:steadypunpipi_vhack/models/finance_data.dart';

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
