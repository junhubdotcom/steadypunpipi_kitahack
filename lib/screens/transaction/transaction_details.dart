import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:steadypunpipi_vhack/models/expense.dart';
import 'package:steadypunpipi_vhack/models/income.dart';
import 'package:steadypunpipi_vhack/widgets/transaction_widgets/description.dart';
import 'package:steadypunpipi_vhack/widgets/transaction_widgets/details_button.dart';
import 'package:steadypunpipi_vhack/widgets/transaction_widgets/image_display_widget.dart';
import 'package:steadypunpipi_vhack/widgets/transaction_widgets/item_container.dart';
import 'package:steadypunpipi_vhack/widgets/transaction_widgets/small_title.dart';

class TransactionDetails extends StatefulWidget {
  dynamic transaction;
  bool isExpense;
  TransactionDetails(
      {required this.transaction, required this.isExpense, super.key});

  @override
  State<TransactionDetails> createState() => _TransactionDetailsState();
}

class _TransactionDetailsState extends State<TransactionDetails> {
  double calculateTotalCost() {
    double totalCost = 0;
    for (int i = 0; i < widget.transaction.items.length; i++) {
      totalCost += widget.transaction.items[i].price;
    }
    return totalCost;
  }

  double calculateTotalCarbonFootprint() {
    double totalCarbonFootprint = 0;
    for (int i = 0; i < widget.transaction.items.length; i++) {
      totalCarbonFootprint += widget.transaction.items[i].carbon_footprint;
    }
    return totalCarbonFootprint;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Transaction Details',
          style: GoogleFonts.quicksand(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 26),
                      decoration: BoxDecoration(
                          color: Color(0XFFE6E6E6),
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.isExpense
                                    ? widget.transaction.transactionName != ""
                                        ? widget.transaction.transactionName
                                            .toString()
                                        : widget.transaction.items.first.name
                                            .toString()
                                    : widget.transaction.name,
                                style: GoogleFonts.quicksand(
                                    textStyle: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 24)),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                      widget.isExpense
                                          ? '-RM${calculateTotalCost().toStringAsFixed(2)}'
                                          : '+RM${widget.transaction.amount.toStringAsFixed(2)}',
                                      style: GoogleFonts.quicksand(
                                          textStyle: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              fontSize: 18))),
                                  widget.isExpense
                                      ? Text(
                                          '+${calculateTotalCarbonFootprint().toStringAsFixed(2)}kg C02e',
                                          style: GoogleFonts.quicksand(
                                            textStyle: TextStyle(
                                                fontWeight: FontWeight.w800,
                                                fontSize: 16),
                                          ),
                                        )
                                      : SizedBox(),
                                ],
                              )
                            ],
                          ),
                          Description(
                              icon: Icons.wallet,
                              text: widget.transaction.paymentMethod),
                          Description(
                              icon: Icons.watch_later,
                              text: DateFormat('dd MMMM yyyy HH:mm').format(
                                  widget.transaction.dateTime.toDate())),
                          Description(
                              icon: Icons.place,
                              text: widget.transaction.location.toString()),
                        ],
                      ),
                    ),
                    SmallTitle(title: "Item"),
                    widget.isExpense
                        ? ListView.builder(
                            itemCount: widget.transaction.items.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return ItemContainer(
                                transactionItem:
                                    widget.transaction.items[index],
                                isExpense: widget.isExpense,
                              );
                            },
                          )
                        : ItemContainer(
                            transactionItem: widget.transaction,
                            isExpense: widget.isExpense,
                          ),
                    SmallTitle(
                        title:
                            widget.isExpense ? "Receipt" : "Proof Of Income"),
                    ImageDisplayWidget(
                        imgPath: widget.isExpense
                            ? widget.transaction.receiptImagePath ?? ""
                            : widget.transaction.proofOfIncome ?? ""),

                    // Remove this column when it is income
                    widget.isExpense
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SmallTitle(title: "Image"),
                              ImageDisplayWidget(
                                  imgPath:
                                      widget.transaction.additionalImagePath ??
                                          ""),
                            ],
                          )
                        : SizedBox(),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DetailsButton(
                    textColor: 0xffe6e6e6,
                    buttonColor: 0xff999999,
                    button_text: "Delete",
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                DetailsButton(
                    textColor: 0xff000000,
                    buttonColor: 0xff999974c95c,
                    button_text: "Edit",
                    onPressed: () {
                      Navigator.pop(context);
                    })
              ],
            ),
          )
        ],
      ),
    );
  }
}
