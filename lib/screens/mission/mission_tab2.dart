import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MissionTab2 extends StatefulWidget {
  const MissionTab2({super.key});

  @override
  State<MissionTab2> createState() => _MissionTab2State();
}

class _MissionTab2State extends State<MissionTab2> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: _buildHeader(),
            ),
            SizedBox(height: 16),
            _buildSearchBar(),
            _buildFilterRow(),
            _buildRewardsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Rising Star",
              style: GoogleFonts.caveat(
                fontSize: 27,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 9),
            Text("Green points", style: GoogleFonts.quicksand(fontSize: 15, height: 0)),
            Text("150", style: GoogleFonts.quicksand(fontSize: 18, height: 0)),
          ],
        ),
        Image.asset("assets/images/girl_tree.png", width: 192, height: 172),
      ],
    );
  }

  Widget _buildSearchBar() {
    return SizedBox(
      height: 50,
      child: TextField(
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search),
        hintText: "Search",
        border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Colors.black),
        ),
        filled: true,
        fillColor: Colors.transparent,
        contentPadding: EdgeInsets.zero,
      ),
      ),
    );
  }

  Widget _buildFilterRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text("Bookmark only", style: GoogleFonts.quicksand(fontSize: 12)),
        Checkbox(value: false, onChanged: (value) {}),
      ],
    );
  }

  Widget _buildRewardsList() {
    List<RewardItem> rewards = [
      RewardItem(
        "10% Google Cloud", 
        "Discount voucher", 
        "1000 points",
        Image.asset("assets/images/google.png", width: 45, height: 45), 
        Colors.green[100]!
      ),
      RewardItem(
        "WWF", 
        "Donation", 
        "150 points",
        Image.asset("assets/images/wwf.png", width: 45, height: 45), 
        Colors.blueGrey[100]!
      ),
      RewardItem(
        "10% Google Cloud", 
        "Discount voucher", 
        "1000 points",
        Image.asset("assets/images/google.png", width: 45, height: 45), 
        Colors.green[100]!
      ),
      RewardItem(
        "WWF", 
        "Donation", 
        "150 points",
        Image.asset("assets/images/wwf.png", width: 45, height: 45), 
        Colors.blueGrey[100]!
      ),
    ];

    return Column(
      children: rewards.map((reward) => _buildRewardCard(reward)).toList(),
    );
  }

  Widget _buildRewardCard(RewardItem reward) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.5),
          child: Card(
            margin: EdgeInsets.only(bottom: 12),
            color: reward.backgroundColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 16.0, bottom: 16.0),
              child: Row(
                children: [
                  SizedBox(width: 18),
                  CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: reward.image,
                  ),
                  SizedBox(width: 15),
                  Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text(
                      reward.title,
                      style: GoogleFonts.quicksand(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      reward.subtitle, 
                      style: GoogleFonts.quicksand(fontSize: 12, fontWeight: FontWeight.normal)),
                    SizedBox(height: 6),
                    Text(
                      reward.points,
                      style: GoogleFonts.quicksand(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    ],
                  ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Handle tap event
                    },
                    child: Container(
                      width: 60,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(83),
                        topRight: Radius.circular(15),
                        bottomLeft: Radius.circular(82),
                        bottomRight: Radius.circular(15),
                        ),
                      ),
                      padding: EdgeInsets.all(8),
                      child: Icon(Icons.add, size: 24),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 9.0),
          child: Icon(Icons.bookmark_border_rounded, color: Colors.black, size: 30),
        ),
      ],
    );
  }
}

class RewardItem {
  final String title;
  final String subtitle;
  final String points;
  final Widget image;
  final Color backgroundColor;

  RewardItem(this.title, this.subtitle, this.points, this.image, this.backgroundColor);
}