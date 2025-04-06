import 'package:flutter/material.dart';
import 'package:steadypunpipi_vhack/services/database_services.dart';
import 'package:steadypunpipi_vhack/widgets/dashboard_widgets/circularButton.dart';
import 'chatpet.dart';
import 'package:steadypunpipi_vhack/screens/pet/wardrobe.dart';
import 'package:steadypunpipi_vhack/screens/pet/calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:steadypunpipi_vhack/models/expense_itemalt.dart';

class PetPage extends StatefulWidget {
  @override
  _PetPageState createState() => _PetPageState();
}

class _PetPageState extends State<PetPage> {
  final DatabaseService _databaseService = DatabaseService();
  // State to track which widget to display
  int currentState = 1; // 1: WardrobePet, 2: ChatPet, 3: CalendarPet

  // State to track selected items
  String? _selectedHat;
  String? _selectedShirt;

  void _updateHatSelection(String imageUrl) {
    setState(() {
      _selectedHat = imageUrl;
      print("Selected Hat: $_selectedHat");
    });
  }

  void _updateShirtSelection(String imageUrl) {
    setState(() {
      _selectedShirt = imageUrl;
      print("Selected Shirt: $_selectedShirt");
    });
  }

  void _fetchAndPrintExpenses() async {
    print("Fetching expenses...");
    final expense = await _databaseService.getExpense("6PVARbRi0zXzKw4BmZvi");
    if (expense != null) {
      print(
          "Expense: ${expense.dateTime}, ${expense.items}, ${expense.transactionName}");
    } else {
      print("Expense not found.");
    }
    if (expense?.dateTime != null) {
      // Already typed!
      Timestamp timestamp = expense!.dateTime!;
      DateTime dateTime = timestamp.toDate();
      print("This is dateTime: ${dateTime}");
    }

    //***If Print all items ***/
    // if (expense?.items != null && expense!.items!.isNotEmpty) {
    //   print("Number of referenced ExpenseItems: ${expense.items!.length}");
    //   for (final itemRef in expense.items!) {
    //     try {
    //       DocumentSnapshot<ExpenseItem> snapshot = await itemRef.get();
    //       ExpenseItem? item = snapshot.data();
    //       if (item != null) {
    //         print(
    //             "ExpenseItem: Name=${item.name}, Price=${item.price}, Quantity=${item.quantity}");
    //       } else {
    //         print(
    //             "Warning: Referenced ExpenseItem document (${itemRef.id}) does not exist or has no data.");
    //       }
    //     } catch (e) {
    //       print("Error fetching ExpenseItem (${itemRef.id}): $e");
    //     }
    //   }
    // } else {
    //   print("Expense has no referenced items or is null.");
    // }

    //***If Print one items ***/
    // if (expense?.items != null) {
    //   // Already typed!
    //   DocumentSnapshot<ExpenseItem> snapshot = await expense!.items!.get();
    //   ExpenseItem? item = snapshot.data(); // Already returns ExpenseItem?
    //   print("This is expenseItem: ${item?.name},${item?.price},${item?.quantity}");
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Stack(
                        children: [
                          // Background image (most bottom)
                          Positioned.fill(
                            child: Image.asset(
                              'assets/images/backgrounds/background1.png', // Replace with your background image path
                              fit: BoxFit.cover,
                            ),
                          ),
                          // Floor image (middle layer)
                          Positioned.fill(
                            child: Image.asset(
                              'assets/images/backgrounds/floor1.png', // Replace with your floor image path
                              fit: BoxFit.cover,
                            ),
                          ),
                          // Foreground image (top layer)
                          Positioned.fill(
                            child: Image.asset(
                              'assets/images/cats/cat1.png', // Replace with your top image path
                              fit: BoxFit.cover,
                            ),
                          ),
                          // Enabled when selected
                          if (_selectedHat == 'assets/images/hats/hat1.png')
                            Positioned.fill(
                              child: Image.asset(
                                'assets/images/hats/hatwear1.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          // Enabled when selected
                          if (_selectedShirt ==
                              'assets/images/shirts/shirt1.png')
                            Positioned.fill(
                              child: Image.asset(
                                'assets/images/shirts/shirtwear1.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 40,
                      left: 10,
                      right: 10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircularButton(
                            icon: Icons.arrow_back,
                            onPressed: () {
                              _fetchAndPrintExpenses();
                            },
                          ),
                          Row(
                            children: [
                              CircularButton(
                                icon: Icons.chat_bubble_outline,
                                onPressed: () {
                                  setState(() {
                                    currentState = 1; // Show ChatPet
                                  });
                                },
                              ),
                              SizedBox(width: 10),
                              CircularButton(
                                icon: Icons.shopping_bag_outlined,
                                onPressed: () {
                                  setState(() {
                                    currentState = 2; // Show WardrobePet
                                  });
                                },
                              ),
                              SizedBox(width: 10),
                              CircularButton(
                                icon: Icons.event_note_outlined,
                                onPressed: () {
                                  setState(() {
                                    currentState = 3; // Show CalendarPet
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: _getCurrentWidget(), // Dynamically display the widget
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Method to return the current widget based on the state
  Widget _getCurrentWidget() {
    switch (currentState) {
      case 1:
        return ChatPet();
      case 2:
        return WardrobePet(
          onHatSelected: _updateHatSelection,
          onShirtSelected: _updateShirtSelection,
        );
      case 3:
        return CalendarPet();
      default:
        return ChatPet();
    }
  }
}
