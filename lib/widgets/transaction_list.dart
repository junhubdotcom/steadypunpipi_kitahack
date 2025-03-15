import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:steadypunpipi_vhack/widgets/transaction_container.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '31',
                  style: GoogleFonts.quicksand(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  'March',
                  style: GoogleFonts.quicksand(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  '+RM 10.00',
                  style: GoogleFonts.quicksand(
                      color: Color(0xff58c849),
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  '-RM50.00',
                  style: GoogleFonts.quicksand(
                      color: Color(0xffcd5151),
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  '+26CO2e',
                  style: GoogleFonts.quicksand(
                      color: Color(0xff7e7e7e),
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
              ],
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.only(right: 25),
              width: 2,
              height: 200,
              color: Colors.grey.shade500,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 2,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return TransactionContainer();
                },
              ),
            ),
          ],
        ),
        SizedBox(
          height: 15,
        )
      ],
    );
  }
}
