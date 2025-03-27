import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:steadypunpipi_vhack/widgets/transaction_widgets/small_title.dart';

class RecordTransaction extends StatefulWidget {
  const RecordTransaction({super.key});

  @override
  State<RecordTransaction> createState() => _RecordTransactionState();
}

class _RecordTransactionState extends State<RecordTransaction> {
  bool _isMultiple = false;
  late TextEditingController transaction_name_controller;
  late TextEditingController item_name_controller;
  late TextEditingController single_price_controller;
  late TextEditingController location_controller;

  @override
  void initState() {
    // TODO: implement initState
    transaction_name_controller = TextEditingController();
    item_name_controller = TextEditingController();
    single_price_controller = TextEditingController();
    location_controller = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text(
          'Record Transaction',
          style: GoogleFonts.quicksand(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.50,
                    child: CheckboxListTile(
                        activeColor: Colors.black,
                        // contentPadding: EdgeInsets.zero,
                        value: _isMultiple,
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text('Multiple Item',
                            style: GoogleFonts.quicksand(
                                textStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600))),
                        onChanged: (bool? newValue) {
                          setState(() {
                            _isMultiple = newValue ?? false;
                          });
                        }),
                  ),
                ],
              ),
              SmallTitle(title: "Transaction Name"),
              TextField(
                  controller: transaction_name_controller,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      fontSize: 16),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Color(0xffd9d9d9),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
