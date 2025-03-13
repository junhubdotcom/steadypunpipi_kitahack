import 'package:flutter/material.dart';
import 'package:steadypunpipi_vhack/common/constants.dart';
import 'package:steadypunpipi_vhack/models/breakdown_item.dart';
import 'package:steadypunpipi_vhack/widgets/breakdown_chart.dart';

Widget buildBreakdownTab({
  required String title,
  required List<BreakdownItem> data,
  required String unit, 
  required Color valueColor,
}) {
  return Column(
    children: [
      BreakdownChart(title: title, data: data),
      const SizedBox(height: AppConstants.paddingSmall),
      SingleChildScrollView(
        child: Column(
          children: data.map((item) {
            return _buildBreakdownItem(
              category: item.category,
              value: item.value,
              unit: unit,
              valueColor: valueColor,
            );
          }).toList(),
        ),
      ),
    ],
  );
}

Widget _buildBreakdownItem({
  required String category,
  required double value,
  required String unit,
  required Color valueColor,
}) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: Padding(
      padding: const EdgeInsets.all(AppConstants.paddingSmall),
      child: Row(
        children: [
          Expanded(
            child: Text(category,
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          Text(
            "$unit ${value.toStringAsFixed(2)}",
            style: TextStyle(color: valueColor, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
  );
}
