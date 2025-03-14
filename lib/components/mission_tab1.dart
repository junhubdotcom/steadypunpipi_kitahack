import 'package:flutter/material.dart';

class MissionTab1 extends StatelessWidget {
  const MissionTab1({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildDailyCheckIn(),
        SizedBox(height: 16),
        _buildFinancialGoals(),
        SizedBox(height: 16),
        _buildSustainableQuests(),
      ],
    );
  }

  Widget _buildDailyCheckIn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.green[100],
          child: Icon(Icons.park, size: 50, color: Colors.green),
        ),
        SizedBox(height: 8),
        Text('150 points', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
          child: Text('See you tomorrow!', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  Widget _buildFinancialGoals() {
    return Card(
      color: Colors.amber[100],
      child: ListTile(
        leading: Image.network('https://flagcdn.com/w40/th.png', width: 40),
        title: Text('Trip to Thailand'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LinearProgressIndicator(value: 956 / 1200, minHeight: 8),
            SizedBox(height: 4),
            Text('RM 956 / 1200'),
          ],
        ),
        trailing: Text('12 exp'),
      ),
    );
  }

  Widget _buildSustainableQuests() {
    return Card(
      color: Colors.green[100],
      child: ListTile(
        leading: Icon(Icons.directions_bus, color: Colors.blue),
        title: Text('Public Transport Week'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LinearProgressIndicator(value: 6 / 7, minHeight: 8, color: Colors.green),
            SizedBox(height: 4),
            Text('6 / 7 days'),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('30 exp'),
            Text('30 points'),
          ],
        ),
      ),
    );
  }
}