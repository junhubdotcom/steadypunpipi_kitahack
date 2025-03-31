import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:steadypunpipi_vhack/screens/mission/more_fingoal.dart';
import 'package:steadypunpipi_vhack/screens/mission/more_susquest.dart';
import 'package:steadypunpipi_vhack/widgets/mission_widgets/goalsquests.dart';
import 'package:steadypunpipi_vhack/widgets/mission_widgets/toggle.dart';

class MissionTab1 extends StatefulWidget {
  const MissionTab1({super.key});

  @override
  State<MissionTab1> createState() => _MissionTab1State();
}

class _MissionTab1State extends State<MissionTab1> {

  int _toggleValue = 0;
  int _checkedIn = 0;
  int exp = 150;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildDailyCheckIn(),
        SizedBox(height: 21),
        _buildFinancialGoals(),
        SizedBox(height: 15),
        _buildSustainableQuests(),
        SizedBox(height: 15),
        _buildLeaderboard(),
        Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
          height: 24
        ),
      ],
    );
  }

  Widget _buildDailyCheckIn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Daily Check-in',
          style: GoogleFonts.quicksand(
            fontSize: 15,
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
                progress: (_checkedIn / 7) * 100,
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
                      style: GoogleFonts.quicksand(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          height: 0)),
                  Text('points',
                      style: GoogleFonts.quicksand(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          height: 0)),
                ],
              )
            ],
          ),
        ),
        Center(
          child: GestureDetector(
            onTap: () {
              setState(() {
                _checkedIn = _checkedIn + 1;
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Color(0xFFDCE8D6),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(_checkedIn == 0 ? 'Check In' : 'See you tomorrow!',
                style: GoogleFonts.quicksand(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  height: 0
                )
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFinancialGoals() {
    return GoalQuestsWidget(
      title: 'Financial Goals',
      onSeeAllPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MoreFingoal()),
        );
      },
      contents: [
        GoalQuestsCard(
          icon: Image.asset('assets/images/Flag_of_Thailand.png', width: 40,),
          title: 'Trip to Thailand',
          barColor: 0xFFFFCF10,
          bgColor: 0xFFFFEDCA,
          progress: '956 / 1200',
          unit: 'MYR',
          rewards: ['12 exp'],
        ),
      ],
    );
  }

  Widget _buildSustainableQuests() {
    return GoalQuestsWidget(
    title: 'Sustainable Quests',
      onSeeAllPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => MoreSusquest()));
      },
      contents: [
        GoalQuestsCard(
          icon: Icon(Icons.train_rounded, size: 40),
          title: 'Public Transport Week',
          barColor: 0xFF36BB6D,
          bgColor: 0xFFDCE8D6,
          progress: '2 / 7',
          unit: 'days',
          rewards: ['30 exp', '30 points'],
        ),
      ],
    );
  }

  Widget _buildLeaderboard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Leaderboard',
          style: GoogleFonts.quicksand(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
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
      style: GoogleFonts.caveat(
        fontSize: 45,
        fontWeight: FontWeight.bold,
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
                    Text("$exp exp", style: GoogleFonts.quicksand(fontWeight: FontWeight.bold)),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: exp / 450,
                      minHeight: 8,
                      backgroundColor: Colors.grey[300],
                      color: Colors.amber,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8),
            Icon(Icons.stars_rounded, size: 24),
          ],
        ),
        SizedBox(height: 4),
        Text("Get 300 more exp to level up", style: GoogleFonts.quicksand(fontSize: 12, color: Colors.black)),
      ],
    );
  }

  Widget _buildLeaderboardCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedToggle(
            values: ['Region', 'Global'],
            onToggleCallback: (value) {
              setState(() {
                _toggleValue = value;
              });
            },
            buttonColor: const Color(0xFFFFC044),
            backgroundColor: const Color(0xFFFFF4DF),
            textColor: const Color(0xFF000000),
          ),
          SizedBox(height: 12),
          Center(child: _buildTopPlayerProfile()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Divider(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 21.0),
            child: _buildLeaderboardList(),
          ),
          SizedBox(height: 12),
          Center(
            child: TextButton(
              onPressed: () {},
              child: Text("Show All",
                  style: GoogleFonts.quicksand(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
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
            style: GoogleFonts.quicksand(fontSize: 18, fontWeight: FontWeight.bold)),
        Text("Eco King", style: GoogleFonts.quicksand(color: Colors.black)),
        Text("150000 exp",
            style: GoogleFonts.quicksand(fontSize: 16, fontWeight: FontWeight.bold)),
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
              style: GoogleFonts.quicksand(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(width: 12),
          CircleAvatar(radius: 16, backgroundImage: NetworkImage(avatarUrl)),
          SizedBox(width: 15),
          Expanded(child: Text(name, style: GoogleFonts.quicksand(fontSize: 15, fontWeight: FontWeight.bold))),
          if (isTopRank)
            Icon(Icons.emoji_events, color: Colors.amber, size: 20),
          SizedBox(width: 8),
          Text("$exp exp", style: GoogleFonts.quicksand(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
