import 'package:flutter/material.dart';
import 'package:steadypunpipi_vhack/components/mission_tab1.dart';

class MissionPage extends StatelessWidget {
  const MissionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Mission and Rewards',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            bottom: TabBar(
              dividerColor: Colors.transparent,
              tabs: [
                Tab(child: Text('Missions', style: TextStyle(fontWeight: FontWeight.normal))),
                Tab(child: Text('Redeem', style: TextStyle(fontWeight: FontWeight.normal))),
                Tab(child: Text('Rewards', style: TextStyle(fontWeight: FontWeight.normal))),
              ]
            ),
          ),
          body: TabBarView(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MissionTab1(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
