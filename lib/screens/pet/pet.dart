import 'package:flutter/material.dart';
import 'package:steadypunpipi_vhack/widgets/dashboard_widgets/circularButton.dart';
import 'chatpet.dart';
import 'package:steadypunpipi_vhack/screens/pet/wardrobe.dart';

class PetPage extends StatefulWidget {
  @override
  _PetPageState createState() => _PetPageState();
}

class _PetPageState extends State<PetPage> {
  // State to track which widget to display
  int currentState = 1; // 1: WardrobePet, 2: ChatPet, 3: CalendarPet

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
                      child: Image.asset(
                        'assets/images/temppet.png', // Ensure this path is correct
                        fit: BoxFit.cover,
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
                              // Handle back button press
                            },
                          ),
                          Row(
                            children: [
                              CircularButton(
                                icon: Icons.chat_bubble_outline,
                                onPressed: () {
                                  setState(() {
                                    currentState = 2; // Show ChatPet
                                  });
                                },
                              ),
                              SizedBox(width: 10),
                              CircularButton(
                                icon: Icons.shopping_bag_outlined,
                                onPressed: () {
                                  setState(() {
                                    currentState = 1; // Show WardrobePet
                                  });
                                },
                              ),
                              SizedBox(width: 10),
                              CircularButton(
                                icon: Icons.event_note_outlined,
                                onPressed: () {},
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
        return WardrobePet();
      case 2:
        return ChatPet();
      //case 3:
      //return CalendarPet(); // Replace with your CalendarPet widget
      default:
        return WardrobePet();
    }
  }
}
