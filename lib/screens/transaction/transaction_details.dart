import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:steadypunpipi_vhack/widgets/transaction_widgets/description.dart';
import 'package:steadypunpipi_vhack/widgets/transaction_widgets/details_button.dart';
import 'package:steadypunpipi_vhack/widgets/transaction_widgets/image_row.dart';
import 'package:steadypunpipi_vhack/widgets/transaction_widgets/item_container.dart';
import 'package:steadypunpipi_vhack/widgets/transaction_widgets/small_title.dart';

class TransactionDetails extends StatelessWidget {
  const TransactionDetails({super.key});

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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 26),
                decoration: BoxDecoration(
                    color: Color(0XFFC8E9BE),
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Burger',
                          style: GoogleFonts.quicksand(
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.w900, fontSize: 24)),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('-RM20.00',
                                style: GoogleFonts.quicksand(
                                    textStyle: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 18))),
                            Text('+9C02e',
                                style: GoogleFonts.quicksand(
                                    textStyle: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 16)))
                          ],
                        )
                      ],
                    ),
                    Description(icon: Icons.wallet, text: "TnG"),
                    Description(
                        icon: Icons.watch_later, text: "2 March 2025 16:00"),
                    Description(icon: Icons.place, text: "KFC, Serdang"),
                  ],
                ),
              ),
              SmallTitle(title: "Item"),
              ListView.builder(
                itemCount: 2,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return ItemContainer();
                },
              ),
              SmallTitle(title: "Receipt"),
              ImageRow(imageList: [
                'assets/images/receipt.jpg',
              ]),
              SmallTitle(title: "Image"),
              ImageRow(imageList: [
                'assets/images/biscuit2.jpg',
                'assets/images/biscuit2.jpg'
              ]),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  DetailsButton(
                      textColor: 0xffe6e6e6,
                      buttonColor: 0xff999999,
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  DetailsButton(
                      textColor: 0xff000000,
                      buttonColor: 0xff999974c95c,
                      onPressed: () {
                        Navigator.pop(context);
                      })
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
