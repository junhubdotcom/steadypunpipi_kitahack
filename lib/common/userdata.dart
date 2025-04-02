import 'package:flutter/material.dart';

class UserData {
  // User Profile Data
  String name = 'Sze Kai';      // User's name
  Widget avatarUrl = Image.network('https://i.pravatar.cc/150?img=9'); // User's avatar URL

  // Daily Check-in Data
  int checkedInDays = 0;       // Tracks how many consecutive days user checked in
  
  // Gameplay Data
  int experience = 150;        // Current experience points
  int level = 1;               // Current level
  int totalPoints = 150;       // Current points balance
  String title = 'Rising Star';// User's title
  int rank = 4;                // User's rank in the leaderboard
  
  // Financial Goals
  List<FinancialGoal> financialGoals = [
    FinancialGoal(
      icon: Image.asset('assets/images/Flag_of_Malaysia.png'),
      name: 'Trip to Thailand',
      targetAmount: 1200,
      savedAmount: 956,
      unit: 'MYR',
      rewards: ['12 exp'],
    ),
    // Add more goals as needed
  ];
  
  // Sustainable Quests
  List<SustainableQuest> sustainableQuests = [
    SustainableQuest(
      icon: Icon(Icons.train_rounded),
      name: 'Public Transport Week',
      currentProgress: 2,
      targetProgress: 7,
      unit: 'days',
      rewards: ['30 exp', '30 points'],
    ),
    // Add more quests as needed
  ];
  
  // Add methods for updating data as needed
  void checkIn() {
    checkedInDays++;
    // Add other check-in logic
  }
  
  void addExperience(int amount) {
    experience += amount;
    // Add level-up logic if needed
  }

  void addPoints(int amount) {
    totalPoints += amount;
    // Add level-up logic if needed
  }

  void addFinancialGoal(FinancialGoal goal) {
    financialGoals.add(goal);
  }
  
  void addSustainableQuest(SustainableQuest quest) {
    sustainableQuests.add(quest);
  }
  
  void updateLeaderboardPosition(position) {
    rank = position;
  }
}

class FinancialGoal {
  final Widget icon;
  final String name;
  final double targetAmount;
  final double savedAmount;
  final String unit;
  final List<String> rewards;
  
  FinancialGoal({
    required this.icon,
    required this.name,
    required this.targetAmount,
    required this.savedAmount,
    required this.unit,
    required this.rewards,
  });
  
  String get progressText => '$savedAmount / $targetAmount $unit';
}

class SustainableQuest {
  final Widget icon;
  final String name;
  final int currentProgress;
  final int targetProgress;
  final String unit;
  final List<String> rewards;
  
  SustainableQuest({
    required this.icon,
    required this.name,
    required this.currentProgress,
    required this.targetProgress,
    required this.unit,
    required this.rewards,
  });
  
  String get progressText => '$currentProgress / $targetProgress $unit';
}