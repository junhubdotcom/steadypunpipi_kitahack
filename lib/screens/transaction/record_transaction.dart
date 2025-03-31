import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:steadypunpipi_vhack/models/transaction.dart';
import 'package:steadypunpipi_vhack/models/transaction_item.dart';
import 'package:steadypunpipi_vhack/screens/transaction/scanner.dart';
import 'package:steadypunpipi_vhack/widgets/transaction_widgets/Itembutton.dart';
import 'package:steadypunpipi_vhack/widgets/transaction_widgets/details_button.dart';
import 'package:steadypunpipi_vhack/widgets/transaction_widgets/image_upload.dart';
import 'package:steadypunpipi_vhack/widgets/transaction_widgets/item_list.dart';
import 'package:steadypunpipi_vhack/widgets/transaction_widgets/record_transaction_dropdown.dart';
import 'package:steadypunpipi_vhack/widgets/transaction_widgets/item_header.dart';
import 'package:steadypunpipi_vhack/widgets/transaction_widgets/small_title.dart';
import 'package:steadypunpipi_vhack/widgets/transaction_widgets/transaction_button.dart';
import 'package:steadypunpipi_vhack/widgets/transaction_widgets/transaction_textfield.dart';

class RecordTransaction extends StatefulWidget {
  final Transaction transaction;

  RecordTransaction({Transaction? transaction, super.key})
      : transaction = transaction ?? Transaction();

  @override
  State<RecordTransaction> createState() => _RecordTransactionState();
}

class _RecordTransactionState extends State<RecordTransaction> {
  bool isExpense = false;

  String? receipt;
  String? thing_image;

  String category_dropdown_value = "Food";

  Future pickImage(ImageSource source, bool isReceipt) async {
    try {
      XFile? image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      setState(() {
        if (isReceipt) {
          receipt = image.path;
        } else {
          thing_image = image.path;
        }
      });
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
    Navigator.pop(context);
  }

  Future pickDateTime() async {
    DateTime? date = await pickDate();
    if (date == null) return;
    setState(() {
      widget.transaction.dateTime = date;
    });
    TimeOfDay? time = await pickTime();
    if (time == null) return;

    final newDateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
    setState(() {
      widget.transaction.dateTime = newDateTime;
    });
  }

  Future<DateTime?> pickDate() => showDatePicker(
        context: context,
        initialDate: widget.transaction.dateTime,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100),
      );

  Future<TimeOfDay?> pickTime() => showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: widget.transaction.dateTime.hour,
        minute: widget.transaction.dateTime.minute,
      ));

  @override
  void initState() {
    // TODO: implement initState
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 25.0, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TransactionButton(
                        textColor: isExpense ? Colors.white : Colors.black,
                        backgroundColor:
                            isExpense ? Colors.grey.shade700 : Colors.white,
                        borderColor:
                            isExpense ? Colors.transparent : Colors.black,
                        buttonText: "Expense",
                        onPressed: () {
                          setState(() {
                            isExpense = true;
                          });
                        }),
                    TransactionButton(
                        textColor:
                            isExpense == false ? Colors.white : Colors.black,
                        backgroundColor: isExpense == false
                            ? Colors.grey.shade700
                            : Colors.white,
                        borderColor: isExpense == false
                            ? Colors.transparent
                            : Colors.black,
                        buttonText: "Income",
                        onPressed: () {
                          setState(() {
                            isExpense = false;
                          });
                        }),
                  ],
                ),
              ),
              isExpense
                  ? Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Checkbox(
                                activeColor: Colors.black,
                                value: widget.transaction.isMultipleItem,
                                visualDensity: VisualDensity.compact,
                                onChanged: (bool? newValue) {
                                  setState(() {
                                    widget.transaction.isMultipleItem =
                                        newValue ?? false;
                                  });
                                }),
                            Text('Multiple Item',
                                style: GoogleFonts.quicksand(
                                    textStyle: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600))),
                          ],
                        ),
                        widget.transaction.isMultipleItem
                            ? Column(
                                children: [
                                  SmallTitle(title: "Transaction Name"),
                                  TransactionTextfield(
                                      value: widget.transaction.transactionName,
                                      onChanged: (value) {
                                        widget.transaction.transactionName =
                                            value!;
                                      }),
                                  SmallTitle(title: "Item"),
                                  ItemHeader(),
                                  ...widget.transaction.items
                                      .asMap()
                                      .entries
                                      .map((entry) {
                                    // int index = entry.key;
                                    TransactionItem item = entry.value;
                                    return ItemList(
                                      item: item,
                                      onNameChanged: (value) =>
                                          item.name = value!,
                                      onCategoryChanged: (value) =>
                                          item.category = value!,
                                      onQuantityChanged: (value) =>
                                          item.quantity = value! as int,
                                      onPriceChanged: (value) =>
                                          item.price = value! as double,
                                    );
                                  }),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      ItemButton(
                                        onPressed: () {
                                          setState(() {
                                            widget.transaction.items
                                                .add(TransactionItem());
                                          });
                                        },
                                        icon: Icons.add,
                                      ),
                                      // SizedBox(
                                      //   width: 2,
                                      // ),
                                      ItemButton(
                                        onPressed: () {
                                          setState(() {
                                            widget.transaction.items
                                                .removeLast();
                                          });
                                        },
                                        icon: Icons.remove,
                                      )
                                    ],
                                  ),
                                ],
                              )
                            : Column(
                                children: [
                                  SmallTitle(title: "Item"),
                                  ItemHeader(),
                                  ItemList(
                                    item: widget.transaction.items.first,
                                    onNameChanged: (value) {
                                      widget.transaction.items.first.name =
                                          value!;
                                    },
                                    onCategoryChanged: (value) {
                                      widget.transaction.items.first.category =
                                          value!;
                                    },
                                    onPriceChanged: (value) {
                                      widget.transaction.items.first.price =
                                          value! as double;
                                    },
                                    onQuantityChanged: (value) {
                                      widget.transaction.items.first.quantity =
                                          value! as int;
                                    },
                                  )
                                ],
                              ),
                      ],
                    )
                  : Column(
                      children: [
                        SmallTitle(title: "Income"),
                        Row(
                          children: [
                            Expanded(flex: 2, child: Text('Name')),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(flex: 2, child: Text('Category')),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(flex: 2, child: Text('Amount')),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 7),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: TransactionTextfield(
                                    onChanged: (value) {},
                                    value: "blaaa",
                                  )),
                              SizedBox(width: 5),
                              Expanded(
                                flex: 2,
                                child: RecordTransactionDropdown(
                                    value: "Salary",
                                    onChanged: (value) {},
                                    items: [
                                      "Salary",
                                      "Investmemt",
                                      "Freelance",
                                      "Scolarship"
                                    ]),
                              ),
                              SizedBox(width: 5),
                              Expanded(
                                  flex: 2,
                                  child: TransactionTextfield(
                                      onChanged: (value) {}, value: "")),
                            ],
                          ),
                        ),
                      ],
                    ),

              SizedBox(
                height: 10,
              ),
              SmallTitle(title: 'Payment Method'),
              RecordTransactionDropdown(
                  value: widget.transaction.paymentMethod,
                  onChanged: (value) =>
                      widget.transaction.paymentMethod = value!,
                  items: [
                    'Cash',
                    'E-Wallet',
                    'Online Banking',
                    'Credit',
                    'Debit'
                  ]),
              SmallTitle(title: 'Time'),
              Container(
                height: 43,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      padding: EdgeInsets.only(left: 10, right: 20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      shadowColor: Colors.transparent, // No shadow color
                      backgroundColor: Color(0xffe6e6e6)),
                  onPressed: () {
                    pickDateTime();
                  },
                  child: Text(
                      DateFormat('dd MMMM yyyy HH:mm')
                          .format(widget.transaction.dateTime),
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 16)),
                ),
              ),
              SmallTitle(title: 'Location'),
              TransactionTextfield(
                  value: widget.transaction.location,
                  onChanged: (value) => widget.transaction.location),
              SmallTitle(title: 'Receipt'),
              ImageUpload(
                listTiles: [
                  ListTile(
                    leading: Icon(
                      Icons.add,
                    ),
                    title: Text(
                      'Add from Gallery',
                    ),
                    onTap: () {
                      pickImage(ImageSource.gallery, true);
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.camera_alt,
                    ),
                    title: Text(
                      'Take Photo',
                    ),
                    onTap: () {
                      pickImage(ImageSource.camera, true);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.document_scanner_sharp),
                    title: Text('Scan Receipt'),
                    onTap: () {
                      Navigator.push(context,
                          (MaterialPageRoute(builder: (context) => Scanner())));
                    },
                  ),
                ],
                imgPath: widget.transaction.receiptImagePath != ""
                    ? widget.transaction.receiptImagePath
                    : receipt,
              ),
              //Image
              isExpense
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SmallTitle(title: 'Image'),
                        ImageUpload(listTiles: [
                          ListTile(
                            leading: Icon(
                              Icons.add,
                            ),
                            title: Text(
                              'Add from Gallery',
                            ),
                            onTap: () {
                              pickImage(ImageSource.gallery, false);
                            },
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.camera_alt,
                            ),
                            title: Text(
                              'Take Photo',
                            ),
                            onTap: () {
                              pickImage(ImageSource.camera, false);
                            },
                          ),
                        ], imgPath: thing_image),
                      ],
                    )
                  : SizedBox(),

              SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.center,
                child: DetailsButton(
                    textColor: 0xff000000,
                    buttonColor: 0xff74c95c,
                    button_text: "Done",
                    onPressed: () {}),
              )
            ],
          ),
        ),
      ),
    );
  }
}
