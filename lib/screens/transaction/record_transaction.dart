import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:steadypunpipi_vhack/models/transaction.dart';
import 'package:steadypunpipi_vhack/models/transaction_item.dart';
import 'package:steadypunpipi_vhack/widgets/transaction_widgets/Itembutton.dart';
import 'package:steadypunpipi_vhack/widgets/transaction_widgets/details_button.dart';
import 'package:steadypunpipi_vhack/widgets/transaction_widgets/image_upload.dart';
import 'package:steadypunpipi_vhack/widgets/transaction_widgets/item_list.dart';
import 'package:steadypunpipi_vhack/widgets/transaction_widgets/record_transaction_dropdown.dart';
import 'package:steadypunpipi_vhack/widgets/transaction_widgets/item_header.dart';
import 'package:steadypunpipi_vhack/widgets/transaction_widgets/small_title.dart';
import 'package:steadypunpipi_vhack/widgets/transaction_widgets/transaction_textfield.dart';

class RecordTransaction extends StatefulWidget {
  const RecordTransaction({super.key});

  @override
  State<RecordTransaction> createState() => _RecordTransactionState();
}

class _RecordTransactionState extends State<RecordTransaction> {
  String? receipt;
  String? thing_image;
  bool _isMultiple = false;
  String category_dropdown_value = "Food";
  Transaction transaction = new Transaction();
  // List<String?> uploadedImages = List.generate(2, (_) => null);

  void receiptOnTap() {
    pickImageFromGallery(ImageSource.gallery, true);
    Navigator.pop(context);
  }

  void thingImageOnTap() {
    pickImageFromGallery(ImageSource.gallery, false);
    Navigator.pop(context);
  }

  Future pickImageFromGallery(ImageSource source, bool isReceipt) async {
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
  }

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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Checkbox(
                      activeColor: Colors.black,
                      // contentPadding: EdgeInsets.all(0),
                      // materialTapTargetSize:
                      //     MaterialTapTargetSize.shrinkWrap, // shrink tap area
                      value: _isMultiple,
                      visualDensity: VisualDensity.compact,
                      onChanged: (bool? newValue) {
                        setState(() {
                          _isMultiple = newValue ?? false;
                        });
                      }),
                  Text('Multiple Item',
                      style: GoogleFonts.quicksand(
                          textStyle: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600))),
                ],
              ),
              _isMultiple
                  ? Column(
                      children: [
                        SmallTitle(title: "Transaction Name"),
                        TransactionTextfield(onChanged: (value) {}),
                        SmallTitle(title: "Item"),
                        ItemHeader(),
                        ...transaction.items.asMap().entries.map((entry) {
                          // int index = entry.key;
                          TransactionItem item = entry.value;
                          return ItemList(
                              item: item,
                              onNameChanged: (value) => item.name = value!,
                              onPriceChanged: (value) => item.price = value!,
                              onQuantityChanged: (value) =>
                                  item.quantity = value!,
                              onCategoryChanged: (value) =>
                                  item.category = value!);
                        }),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ItemButton(
                              onPressed: () {
                                setState(() {
                                  transaction.items.add(TransactionItem());
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
                                  transaction.items.removeLast();
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
                          item: transaction.items.first,
                          onNameChanged: (value) {
                            transaction.items.first.name = value!;
                          },
                          onPriceChanged: (value) {
                            transaction.items.first.price = value!;
                          },
                          onQuantityChanged: (value) {
                            transaction.items.first.quantity = value!;
                          },
                          onCategoryChanged: (value) {
                            transaction.items.first.category = value!;
                          },
                        )
                      ],
                    ),

              SizedBox(
                height: 10,
              ),
              SmallTitle(title: 'Payment Method'),
              RecordTransactionDropdown(
                  value: transaction.paymentMethod,
                  onChanged: (value) => transaction.paymentMethod = value!,
                  items: ['Cash', 'E-Wallet', 'Online Banking']),
              SmallTitle(title: 'Time'),
              Container(
                height: 43,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      shadowColor: Colors.transparent, // No shadow color
                      backgroundColor: Color(0xffe6e6e6)),
                  onPressed: () {},
                  child: Text(
                      DateFormat('dd MMMM yyyy HH:mm')
                          .format(transaction.dateTime),
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w400)),
                ),
              ),
              SmallTitle(title: 'Location'),
              TransactionTextfield(onChanged: (value) => transaction.location),
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
                    onTap: receiptOnTap,
                  ),
                  ListTile(
                      leading: Icon(
                        Icons.camera_alt,
                      ),
                      title: Text(
                        'Take Photo',
                      ),
                      onTap: receiptOnTap),
                  ListTile(
                    leading: Icon(Icons.document_scanner_sharp),
                    title: Text('Scan Receipt'),
                    onTap: () {},
                  ),
                ],
                imgPath: receipt,
              ),
              //Image
              SmallTitle(title: 'Image'),
              ImageUpload(listTiles: [
                ListTile(
                  leading: Icon(
                    Icons.add,
                  ),
                  title: Text(
                    'Add from Gallery',
                  ),
                  onTap: thingImageOnTap,
                ),
                ListTile(
                  leading: Icon(
                    Icons.camera_alt,
                  ),
                  title: Text(
                    'Take Photo',
                  ),
                  onTap: thingImageOnTap,
                ),
              ], imgPath: thing_image),
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
