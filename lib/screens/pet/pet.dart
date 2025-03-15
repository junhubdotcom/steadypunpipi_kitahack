import 'package:flutter/material.dart';
import 'package:steadypunpipi_vhack/widgets/dashboard_widgets/circularButton.dart';
import 'chatpet.dart';

class PetPage extends StatelessWidget {
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
                                onPressed: () {}),
                        Row(
                          children: [
                            CircularButton(
                                icon: Icons.chat_bubble_outline,
                                onPressed: () {}),
                            SizedBox(width: 10),
                            CircularButton(
                                icon: Icons.shopping_bag_outlined,
                                onPressed: () {}),
                            SizedBox(width: 10),
                            CircularButton(
                                icon: Icons.event_note_outlined,
                                onPressed: () {}),
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
                child: ChatPet(),
              ),
            ),
          ],
        ),
      ],
    ));
  }
}
