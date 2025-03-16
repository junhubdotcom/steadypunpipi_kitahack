import 'package:flutter/material.dart';
import 'package:steadypunpipi_vhack/models/breakdown_item.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BreakdownChart extends StatelessWidget {
  final String title;
  final List<BreakdownItem> data;

  const BreakdownChart({
    super.key,
    required this.title,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    double total = data.fold(0, (sum, item) => sum + item.value);

    return Column(
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        SizedBox(
          height: 250, 
          child: SfCircularChart(
            legend: Legend(
              isVisible: true,
              overflowMode: LegendItemOverflowMode.wrap,
              position: LegendPosition.bottom,
            ),
            series: <CircularSeries>[
              PieSeries<BreakdownItem, String>(
                dataSource: data,
                xValueMapper: (BreakdownItem item, _) => item.category,
                yValueMapper: (BreakdownItem item, _) => item.value,
                dataLabelMapper: (BreakdownItem item, _) =>
                    'RM ${item.value.toStringAsFixed(2)}\n${((item.value / total) * 100).toStringAsFixed(0)}%',
                dataLabelSettings: const DataLabelSettings(
                  isVisible: true,
                  labelPosition: ChartDataLabelPosition.outside,
                  connectorLineSettings: ConnectorLineSettings(width: 1),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
