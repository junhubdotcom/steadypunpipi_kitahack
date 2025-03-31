import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:steadypunpipi_vhack/widgets/transaction_widgets/label.dart';

class ItemContainer extends StatelessWidget {
  const ItemContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Color(0xffe5ecdd), borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Jacob Biskuit',
                style: GoogleFonts.quicksand(
                    fontWeight: FontWeight.w700, fontSize: 15),
              ),
              Label(),
            ],
          ),
          Text(
            '2 x RM 5.00',
            style: GoogleFonts.quicksand(
                fontWeight: FontWeight.w600, fontSize: 14),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                '-RM10.00',
                style: GoogleFonts.quicksand(
                    fontWeight: FontWeight.w600, fontSize: 14),
              ),
              Text(
                '+5CO2e',
                style: GoogleFonts.quicksand(
                    fontWeight: FontWeight.w600, fontSize: 13),
              ),
            ],
          ),
        ],
      ),
    );
    ;
  }
}
