import 'package:flutter/material.dart';
import 'package:steadypunpipi_vhack/widgets/pet_widget/row_category.dart';

class WardrobePet extends StatefulWidget {
  const WardrobePet({super.key});

  @override
  State<WardrobePet> createState() => _WardrobePetState();
}

class _WardrobePetState extends State<WardrobePet>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> backgroundItems = [
    {
      'imageUrl': "assets/images/temppet.png",
      'isUnlock': true,
    },
    {
      'imageUrl': "assets/images/temppet.png",
      'isUnlock': false,
    },
    {
      'imageUrl': "assets/images/temppet.png",
      'isUnlock': true,
    },
  ];

  final List<Map<String, dynamic>> shirtItems = [
    {
      'imageUrl': "assets/images/shirts/9.png",
      'isUnlock': true,
    },
    {
      'imageUrl': "assets/images/shirts/7.png",
      'isUnlock': false,
    },
    {
      'imageUrl': "assets/images/shirts/8.png",
      'isUnlock': true,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    if (_tabController == null) {
      return const SizedBox(); // Return an empty widget if not initialized
    }

    return Column(
      children: [
        TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.home)),
            Tab(icon: Icon(Icons.shopping_cart)),
            Tab(icon: Icon(Icons.headset)),
            Tab(icon: Icon(Icons.settings)),
          ],
          onTap: (index) {
            setState(() {});
          },
        ),
        Expanded(
          child: TabBarView(controller: _tabController, children: [
            TabPage(title: "Home", row1Name: "Hots", row2Name: "New", row1: backgroundItems, row2: shirtItems),
            TabPage(title: "Shirts", row1Name: "Hots", row2Name: "New", row1: backgroundItems, row2: shirtItems),
            TabPage(title: "Hats", row1Name: "Hots", row2Name: "New", row1: backgroundItems, row2: shirtItems),
            TabPage(title: "Pets", row1Name: "Hots", row2Name: "New", row1: backgroundItems, row2: shirtItems),
          ]),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

class TabPage extends StatelessWidget {
  const TabPage({
    super.key,
    required this.title,
    required this.row1Name,
    required this.row2Name,
    required this.row1,
    required this.row2,
  });

  final String title;
  final String row1Name;
  final String row2Name;
  final List<Map<String, dynamic>> row1;
  final List<Map<String, dynamic>> row2;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(title,
                style:
                    TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ),
          RowCategory(rowTitle: row1Name, items: row1),
          RowCategory(rowTitle: row2Name, items: row2),
        ],
      ),
    );
  }
}
