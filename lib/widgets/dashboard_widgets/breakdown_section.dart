import 'package:flutter/material.dart';
import 'package:steadypunpipi_vhack/models/breakdown_item.dart';
import 'package:steadypunpipi_vhack/widgets/dashboard_widgets/breakdown_tab.dart';
import 'package:steadypunpipi_vhack/widgets/dashboard_widgets/expandable_card.dart';

class BreakdownSection extends StatelessWidget {
  const BreakdownSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ExpandableCard(
      title: "Breakdown",
      subtitle: "Know category bla caption",
      icon: Icons.pie_chart,
      tabs: const [
        Tab(text: "Expense"),
        Tab(text: "Income"),
        Tab(text: "CO₂"),
      ],
      tabViews: [
        expenseTab(),
        incomeTab(),
        carbonTab(),
      ],
    );
  }
}

Widget expenseTab() {
  return buildBreakdownTab(
    title: "Expense",
    data: fetchExpenses(),
    unit: "RM",
    valueColor: Colors.red, 
  );
}

Widget incomeTab() {
  return buildBreakdownTab(
    title: "Income",
    data: fetchIncome(),
    unit: "RM",
    valueColor: Colors.green, 
  );
}

Widget carbonTab() {
  return buildBreakdownTab(
    title: "CO₂ Emissions",
    data: fetchCO2(),
    unit: "kg CO₂",
    valueColor: Colors.blueGrey, 
  );
}

