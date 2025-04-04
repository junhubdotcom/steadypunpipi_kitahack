import 'dart:core';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:steadypunpipi_vhack/common/constants.dart';
import 'package:steadypunpipi_vhack/models/finance_data.dart';
import 'package:steadypunpipi_vhack/models/transaction_model.dart';
import 'package:steadypunpipi_vhack/services/gemini_service.dart';
import 'package:steadypunpipi_vhack/services/transaction_service.dart';
import 'package:steadypunpipi_vhack/widgets/dashboard_widgets/dashboard_settings.dart';
import 'package:steadypunpipi_vhack/widgets/dashboard_widgets/date_selector.dart';
import 'package:steadypunpipi_vhack/widgets/dashboard_widgets/breakdown_section.dart';
import 'package:steadypunpipi_vhack/widgets/dashboard_widgets/loading.dart';
import 'package:steadypunpipi_vhack/widgets/dashboard_widgets/summary_section.dart';
import 'package:steadypunpipi_vhack/widgets/dashboard_widgets/tips_section.dart';
import 'package:steadypunpipi_vhack/widgets/dashboard_widgets/trend_section.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 1; // Default to "Weekly"
  final TransactionService _transactionService = TransactionService();
  final GeminiService _geminiService = GeminiService();

  List<TransactionModel> transactions = [];
  List<FinanceCO2Data> trendData = [];
  Map<String, dynamic> geminiData = {
    "insights": "",
    "financeTips": [],
    "environmentTips": [],
  };

  bool isLoadingAI = false;

  List<String> sectionOrder = ["Summary", "Breakdown", "Trend", "Tips"];
  Map<String, bool> sectionVisibility = {
    "Summary": true,
    "Breakdown": true,
    "Trend": true,
    "Tips": true,
  };

  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _loadData(_selectedDate);
  }

  Future<void> _loadData(DateTime selectedDate) async {
    await _transactionService.loadTransactions();

    DateTime startDate;
    DateTime endDate = selectedDate; // Use the passed date instead of now

    if (_selectedIndex == 0) {
      startDate = selectedDate; // Daily (use selected date as start)
    } else if (_selectedIndex == 1) {
      startDate = selectedDate
          .subtract(Duration(days: selectedDate.weekday - 1)); // Weekly
      endDate = startDate.add(Duration(days: 6)); // Full week range
    } else {
      startDate = DateTime(selectedDate.year, selectedDate.month, 1); // Monthly
      endDate = DateTime(
          selectedDate.year, selectedDate.month + 1, 0); // End of month
    }

    // Fetch transactions based on the selected date range
    var filteredTransactions =
        await _transactionService.filterTransactions(startDate, endDate);

    // Process trend data
    var newTrendData = await _transactionService.processFCO2(
        filteredTransactions, getSelectedPeriod());

    setState(() {
      _selectedDate = selectedDate;
      transactions = filteredTransactions.toList();
      trendData = newTrendData;
    });

    _fetchAIInsights(startDate, endDate);
  }

  Future<void> _fetchAIInsights(DateTime startDate, DateTime endDate) async {
    setState(() {
      isLoadingAI = true;
    });

    String dateRange = "${startDate.toLocal()} - ${endDate.toLocal()}";

    try {
      Map<String, dynamic> aiResponse =
          await _geminiService.generateInsightsAndTips(
              transactions.map((tx) => tx.toJSON()).toList(), dateRange);
      setState(() {
        geminiData = {
          "insights": List<String>.from(aiResponse["insights"] ?? []),
          "financeTips": List<String>.from(aiResponse["financeTips"] ?? []),
          "environmentTips":
              List<String>.from(aiResponse["environmentTips"] ?? []),
        };
      });
    } catch (e) {
      print("🚨 Failed to fetch AI insights: $e");
    } finally {
      setState(() {
        isLoadingAI = false;
      });
    }
  }

  /// Returns "Daily", "Weekly", or "Monthly" based on `_selectedIndex`
  String getSelectedPeriod() {
    return _selectedIndex == 0
        ? "Daily"
        : _selectedIndex == 1
            ? "Weekly"
            : "Monthly";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.settings),
          onPressed: _openSettingsModal,
        ),
        title: Text(
          "Dashboard",
          style: GoogleFonts.quicksand(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.share),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppConstants.paddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DateSelector(
              selectedIndex: _selectedIndex,
              onSelectionChanged: (newIndex, selectedDate) {
                setState(() {
                  _selectedIndex = newIndex;
                  _selectedDate = selectedDate;
                });
                _loadData(selectedDate);
              },
            ),
            if (sectionVisibility["Summary"] ?? false)
              SummarySection(insights: geminiData["insights"], transactions: transactions),
            if (sectionVisibility["Breakdown"] ?? false)
              BreakdownSection(transactions: transactions),
            if (sectionVisibility["Trend"] ?? false)
              TrendSection(data: trendData, title: getSelectedPeriod()),
            if (sectionVisibility["Tips"] ?? false)
              isLoadingAI
                  ? loadingTips()
                  : TipsSection(
                      financeTips: geminiData["financeTips"],
                      environmentTips: geminiData["environmentTips"])
            // InsightsSection(insights: isLoadingAI ? ["Fetching AI insights..."] : geminiData["insights"]),
          ],
        ),
      ),
    );
  }

  void _openSettingsModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return DashboardSettingsModal(
          initialSections: sectionOrder,
          onSave: (newOrder, newVisibility) {
            setState(() {
              sectionOrder = newOrder;
              sectionVisibility = newVisibility;
            });
          },
        );
      },
    );
  }

  
}