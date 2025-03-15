import 'package:flutter/material.dart';
import 'package:steadypunpipi_vhack/common/constants.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'route.dart';

void main() {
  Gemini.init(
    apiKey: AppConstants.GEMINI_API_KEY
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Tab Navigation',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = AppRoutes.pages;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      floatingActionButton: SizedBox(
        width: 70.0,
        height: 70.0,
        child: FloatingActionButton(
          onPressed: () {
            _onTabTapped(2); // Navigate to the PetPage
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
          child: Icon(Icons.pets, size: 30,),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 60,
        color: Colors.cyan.shade400,
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.attach_money,
                color: Colors.black,
              ),
              onPressed: () {
                _onTabTapped(0); // Navigate to the TransactionPage
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.dashboard,
                color: Colors.black,
              ),
              onPressed: () {
                _onTabTapped(1); // Navigate to the DashboardPage
              },
            ),
            SizedBox(width: 40), // Space for the FloatingActionButton
            IconButton(
              icon: const Icon(
                Icons.flag,
                color: Colors.black,
              ),
              onPressed: () {
                _onTabTapped(3); // Navigate to the MissionPage
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.person,
                color: Colors.black,
              ),
              onPressed: () {
                _onTabTapped(4); // Navigate to the ProfilePage
              },
            ),
          ],
        ),
      ),
    );
  }
}
