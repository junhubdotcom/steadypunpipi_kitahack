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
  return SingleChildScrollView(
    child: Column(
      children: [
        BreakdownChart(title: title, data: data),
        Align(
          alignment: Alignment.center,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.swipe_up, size: 16, color: Colors.grey),
              const SizedBox(width: 4),
              Text(
                "Scroll down to see detailed breakdown",
                style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppConstants.paddingSmall),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: data.length,
          itemBuilder: (context, index) {
            final item = data[index];
            return _buildBreakdownItem(
              category: item.category,
              value: item.value,
              unit: unit,
              valueColor: valueColor,
            );
          },
        ),
      ],
    ),
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
