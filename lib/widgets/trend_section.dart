import 'package:flutter/material.dart';
import 'package:steadypunpipi_vhack/models/finance_data.dart';
import 'package:steadypunpipi_vhack/widgets/expandable_card.dart';
import 'package:steadypunpipi_vhack/widgets/expenseco2_chart.dart';
import 'package:steadypunpipi_vhack/widgets/finance_bar_chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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
        FinanceBarChart(data: mockData, title: "Day"),
        ExpenseCO2Chart(data: mockData, title: "Day")
      ],
    );
  }
}



// Widget expenseTab() {
//   return buildBreakdownTab(
//     title: "Expense",
//     data: fetchExpenses(),
//     unit: "RM",
//     valueColor: Colors.red, 
//   );
// }

// Widget incomeTab() {
//   return buildBreakdownTab(
//     title: "Income",
//     data: fetchIncome(),
//     unit: "RM",
//     valueColor: Colors.green, 
//   );
// }