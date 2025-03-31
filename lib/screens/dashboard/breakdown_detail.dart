import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class BreakdownDetailPage extends StatelessWidget {
  final String category;
  final String type; // Expense, Income, CO₂

  const BreakdownDetailPage({
    Key? key,
    required this.category,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Dummy transactions
    final transactions = [
      {"date": "2024-03-01", "amount": 50.00, "desc": "Item A"},
      {"date": "2024-03-05", "amount": 100.00, "desc": "Item B"},
      {"date": "2024-03-10", "amount": 30.00, "desc": "Item C"},
    ];

    // Determine color based on transaction type
    Color amountColor = type == "Income"
        ? Colors.green[700]!
        : type == "Expense"
            ? Colors.red[700]!
            : Colors.blueGrey;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "$category Details",
          style: GoogleFonts.quicksand(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ListView.builder(
          itemCount: transactions.length,
          itemBuilder: (context, index) {
            final txn = transactions[index];

            // Format Date
            String formattedDate = DateFormat("dd MMM yyyy")
                .format(DateTime.parse(txn["date"].toString()));

            // Format Amount
            String amountPrefix = type == "Income" ? "+ RM" : "- RM";
            String formattedAmount = "$amountPrefix${txn["amount"]}";

            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
              margin: const EdgeInsets.symmetric(vertical: 6),
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                title: Text(
                  txn["desc"].toString(),
                  style: GoogleFonts.quicksand(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  formattedDate,
                  style: GoogleFonts.quicksand(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                trailing: Text(
                  formattedAmount,
                  style: GoogleFonts.quicksand(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: amountColor,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
