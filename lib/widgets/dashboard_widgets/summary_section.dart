import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:steadypunpipi_vhack/common/constants.dart';
import 'package:steadypunpipi_vhack/models/transaction.dart';
import 'package:steadypunpipi_vhack/widgets/dashboard_widgets/expandable_card.dart';

class SummarySection extends StatelessWidget {
  final List<String> insights;
  final List<Transaction> transactions;

  const SummarySection({required this.insights, required this.transactions});

  @override
  Widget build(BuildContext context) {
    return ExpandableCard(
      title: "Summary",
      subtitle: "A big picture",
      icon: Icons.tips_and_updates,
      tabs: const [
        Tab(text: "Overall"),
      ],
      tabViews: [
        SingleChildScrollView(
          child: Column(
            children: [
              // _buildSummary(),
              ListView(
                  children: insights
                      .map((insight) => ListTile(title: Text(insight)))
                      .toList()),
            ],
          ),
        ),
      ],
    );
  }

//   Widget _buildSummary() {
//     double totalIncome = transactions
//         .where((tx) => tx.amount > 0)
//         .fold(0.0, (sum, tx) => sum + tx.amount);

//     double totalExpense = transactions
//         .where((tx) => tx.amount < 0)
//         .fold(0.0, (sum, tx) => sum + tx.amount.abs());

//     double totalCO2 =
//         transactions.fold(0.0, (sum, tx) => sum + (tx.carbonFootprint ?? 0.0));

//     return Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             _buildCircularSummary("CO₂", "${totalCO2.toStringAsFixed(1)} kg"),
//             _buildCircularSummary("Balance",
//                 "RM ${(totalIncome - totalExpense).toStringAsFixed(2)}"),
//             _buildCircularSummary(
//                 "Income", "RM ${totalIncome.toStringAsFixed(2)}"),
//             _buildCircularSummary(
//                 "Expense", "RM ${totalExpense.toStringAsFixed(2)}"),
//           ],
//         ),
//         SizedBox(height: AppConstants.paddingMedium),
//       ],
//     );
//   }

//   Widget _buildCircularSummary(String title, String value) {
//     return Column(
//       children: [
//         Container(
//           width: 85,
//           height: 85,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             gradient: LinearGradient(
//               colors: [Colors.green.shade400, Colors.green.shade800],
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black26,
//                 blurRadius: 6,
//                 offset: Offset(2, 4),
//               ),
//             ],
//           ),
//           child: Center(
//             child: Text(
//               value,
//               style: GoogleFonts.quicksand(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//         ),
//         SizedBox(height: 8.0),
//         Text(
//           title,
//           style: GoogleFonts.quicksand(
//             fontWeight: FontWeight.w600,
//             fontSize: 14,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildGradientCard(
//       {required String title,
//       required String content,
//       required IconData icon}) {
//     return Container(
//       width: double.infinity,
//       margin: EdgeInsets.symmetric(vertical: 8),
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [Colors.blue.shade400, Colors.blue.shade800],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black26,
//             blurRadius: 8,
//             offset: Offset(3, 5),
//           ),
//         ],
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Icon(icon, color: Colors.white, size: 32),
//           SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: GoogleFonts.quicksand(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//                 SizedBox(height: 4),
//                 Text(
//                   content,
//                   style: GoogleFonts.quicksand(
//                     fontSize: 14,
//                     color: Colors.white.withOpacity(0.9),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
}