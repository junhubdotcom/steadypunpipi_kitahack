import 'package:flutter/material.dart';
import 'package:steadypunpipi_vhack/widgets/expandable_card.dart';

class TrendSection extends StatelessWidget {
  const TrendSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ExpandableCard(
      title: "Trend",
      subtitle: "Know trend over time",
      icon: Icons.show_chart_outlined,
      tabs: const [
        Tab(text: "Income vs Expense"),
        Tab(text: "Expense & CO₂"),
      ],
      tabViews: [
        const Placeholder(child: Text("Grouped Bar Chart")),
        const Placeholder(child: Text("Dual-Axis Line Chart/Bar-Line Chart")),
      ],
    );
  }
}
