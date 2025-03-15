import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:steadypunpipi_vhack/screens/transaction_details.dart';
import 'package:steadypunpipi_vhack/widgets/label.dart';

class TransactionContainer extends StatelessWidget {
  const TransactionContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TransactionDetails(),
        ),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Color(0xffe5ecdd), borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Lotus',
                  style: GoogleFonts.quicksand(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w900),
                ),
                Text(
                  'Cash',
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
                  '-RM50.00',
                  style: GoogleFonts.quicksand(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w800),
                ),
                Text(
                  '+18 CO2e',
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
