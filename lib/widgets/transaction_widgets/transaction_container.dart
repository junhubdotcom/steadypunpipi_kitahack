import 'package:cloud_firestore/cloud_firestore.dart' show DocumentSnapshot;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:steadypunpipi_vhack/models/expense.dart';
import 'package:steadypunpipi_vhack/models/expense_item.dart';
import 'package:steadypunpipi_vhack/screens/transaction/transaction_details.dart';
import 'package:steadypunpipi_vhack/services/database_services.dart';
import 'package:steadypunpipi_vhack/widgets/transaction_widgets/label.dart';

class TransactionContainer extends StatefulWidget {
  final String transactionId;
  final Expense transaction;

  const TransactionContainer({
    super.key,
    required this.transactionId,
    required this.transaction,
  });

  @override
  State<TransactionContainer> createState() => _TransactionContainerState();
}

class _TransactionContainerState extends State<TransactionContainer> {
  DatabaseService db = DatabaseService();
  bool isLoading = true;
  late dynamic transaction;
  List<ExpenseItem> expenseItems = [];

  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() async {
    await _fetchAndPrintExpenses(widget.transactionId);
    setState(() {
      isLoading = false;
    });
  }

  Future<void> _fetchAndPrintExpenses(String transactionId) async {
    print("Fetching expenses for transaction ID: $transactionId");
    if (isLoading = true) {
      transaction = await db.getExpense(transactionId);
      if (transaction?.items != null && transaction!.items!.isNotEmpty) {
        for (final itemRef in transaction.items!) {
          try {
            DocumentSnapshot<ExpenseItem> snapshot = await itemRef.get();
            ExpenseItem? item = snapshot.data();
            expenseItems.add(item!);
          } catch (e) {
            print("Error fetching ExpenseItem (${itemRef.id}): $e");
          }
        }
      } else {
        print("Expense has no referenced items or is null.");
      }
    }
    try {
      // Fetch the expense items from the database using the transaction ID
    } catch (e) {
      print("Error fetching expenses: $e");
    }
  }

  double calculateTotalCost() {
    double totalCost = 0;
    for (int i = 0; i < expenseItems.length; i++) {
      totalCost += expenseItems[i].price;
    }
    return totalCost;
  }

  double calculateTotalCarbonFootprint() {
    double totalCarbonFootprint = 0;
    for (int i = 0; i < expenseItems.length; i++) {
      totalCarbonFootprint += expenseItems[i].carbon_footprint;
    }
    return totalCarbonFootprint;
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : GestureDetector(
            onTap: () {
              print('Transaction ID: ${widget.transactionId}');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TransactionDetails(
                    transactionId: widget.transactionId,
                    isExpense: true,
                    fromForm: false,
                  ),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: Color(0xffe5ecdd),
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        (widget.transaction.transactionName == null ||
                                widget.transaction.transactionName!.isEmpty)
                            ? 'No transaction name'
                            : widget.transaction.transactionName!,
                        style: GoogleFonts.quicksand(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w900),
                      ),
                      Text(
                        widget.transaction.paymentMethod,
                        style: GoogleFonts.quicksand(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      ),
                      Label(),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '-RM${calculateTotalCost().toStringAsFixed(2)}',
                        style: GoogleFonts.quicksand(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w800),
                      ),
                      Text(
                        '+${calculateTotalCarbonFootprint().toStringAsFixed(2)}kg C02e',
                        style: GoogleFonts.quicksand(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w800),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
  }
}
