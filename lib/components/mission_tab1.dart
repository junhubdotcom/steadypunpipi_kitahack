import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';
import 'package:flutter/material.dart';

class MissionTab1 extends StatelessWidget {
  const MissionTab1({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildDailyCheckIn(),
        SizedBox(height: 21),
        _buildFinancialGoals(),
        SizedBox(height: 21),
        _buildSustainableQuests(),
        SizedBox(height: 21),
        _buildLeaderboard()
      ],
    );
  }

  Widget _buildDailyCheckIn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Daily Check-in',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        Center(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              DashedCircularProgressBar.square(
                dimensions: 210,
                progress: (1 / 7) * 100,
                startAngle: 230,
                sweepAngle: 290,
                foregroundColor: Colors.green,
                backgroundColor: const Color(0xffeeeeee),
                foregroundStrokeWidth: 7,
                backgroundStrokeWidth: 7,
                foregroundGapSize: 15,
                foregroundDashSize: 24,
                backgroundGapSize: 15,
                backgroundDashSize: 24,
                animation: true,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 24),
                  Image.asset('assets/images/forest.png', width: 120),
                  SizedBox(height: 8),
                  Text('150',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          height: 0)),
                  Text('points',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          height: 0)),
                ],
              )
            ],
          ),
        ),
        Center(
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFDCE8D6),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
            ),
            child: Text('See you tomorrow!',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    height: 0)),
          ),
        ),
      ],
    );
  }

  Widget _buildFinancialGoals() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Financial Goals',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 9),
            GestureDetector(
              child: Icon(Icons.arrow_forward, size: 18),
            ),
          ],
        ),
        SizedBox(height: 12),
        Center(
          child: Card(
            color: Colors.amber[100],
            child: ListTile(
              leading:
                  Image.network('https://flagcdn.com/w40/th.png', width: 40),
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
          ),
        ),
      ],
    );
  }

  Widget _buildSustainableQuests() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Sustainable Quests',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 9),
            GestureDetector(
              child: Icon(Icons.arrow_forward, size: 18),
            ),
          ],
        ),
        SizedBox(height: 12),
        Center(
          child: Card(
            color: Colors.green[100],
            child: ListTile(
              leading: Icon(Icons.directions_bus, color: Colors.blue),
              title: Text('Public Transport Week'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LinearProgressIndicator(
                      value: 6 / 7, minHeight: 8, color: Colors.green),
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
          ),
        ),
      ],
    );
  }

  Widget _buildLeaderboard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle(),
        _buildProgressBar(),
        SizedBox(height: 16),
        _buildLeaderboardCard(),
      ],
    );
  }

  Widget _buildTitle() {
    return Text(
      "Rising Star",
      style: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
        height: 0
      ),
    );
  }

  Widget _buildProgressBar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("150 exp", style: TextStyle(fontWeight: FontWeight.bold)),
                  LinearProgressIndicator(
                    value: 150 / 450,
                    minHeight: 8,
                    backgroundColor: Colors.grey[300],
                    color: Colors.amber,
                  ),
                ],
              ),
            ),
            SizedBox(width: 8),
            Icon(Icons.stars_rounded, size: 24),
          ],
        ),
        SizedBox(height: 4),
        Text("Get 300 more exp to level up", style: TextStyle(fontSize: 12, color: Colors.black)),
      ],
    );
  }

  Widget _buildLeaderboardCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildToggleButtons(),
            SizedBox(height: 12),
            _buildTopPlayerProfile(),
            Divider(),
            _buildLeaderboardList(),
            SizedBox(height: 12),
            TextButton(
              onPressed: () {},
              child: Text("Show All",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleButtons() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildToggleButton("Regional", isSelected: true),
          _buildToggleButton("Global", isSelected: false),
        ],
      ),
    );
  }

  Widget _buildToggleButton(String text, {bool isSelected = false}) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.amber : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _buildTopPlayerProfile() {
    return Column(
      children: [
        CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=3')),
        SizedBox(height: 8),
        Text("Jun Wei",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text("Eco King", style: TextStyle(color: Colors.grey)),
        Text("150000 exp",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildLeaderboardList() {
    return Column(
      children: [
        _buildLeaderboardRow(
            1, "Jun Wei", "https://i.pravatar.cc/150?img=3", 150000,
            isTopRank: true),
        _buildLeaderboardRow(
            2, "Ci En", "https://i.pravatar.cc/150?img=5", 6210),
        _buildLeaderboardRow(
            3, "Joe Ying", "https://i.pravatar.cc/150?img=7", 3400),
        _buildLeaderboardRow(
            4, "Sze Kai", "https://i.pravatar.cc/150?img=9", 150,
            isCurrentUser: true),
      ],
    );
  }

  Widget _buildLeaderboardRow(int rank, String name, String avatarUrl, int exp,
      {bool isTopRank = false, bool isCurrentUser = false}) {
    return Container(
      decoration: BoxDecoration(
        color: isCurrentUser ? Colors.amber[100] : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text("$rank",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(width: 12),
          CircleAvatar(radius: 16, backgroundImage: NetworkImage(avatarUrl)),
          SizedBox(width: 8),
          Expanded(child: Text(name, style: TextStyle(fontSize: 16))),
          if (isTopRank)
            Icon(Icons.emoji_events, color: Colors.amber, size: 20),
          SizedBox(width: 8),
          Text("$exp exp", style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
