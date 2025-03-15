import 'package:flutter/material.dart';
import 'package:steadypunpipi_vhack/common/constants.dart';
import 'package:steadypunpipi_vhack/widgets/dashboard_settings.dart';
import 'package:steadypunpipi_vhack/widgets/date_selector.dart';
import 'package:steadypunpipi_vhack/widgets/breakdown_section.dart';
import 'package:steadypunpipi_vhack/widgets/tips_section.dart';
import 'package:steadypunpipi_vhack/widgets/trend_section.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 1; // Default to "Weekly"

  List<String> sectionOrder = ["Summary", "Breakdown", "Trend", "Tips"];
  Map<String, bool> sectionVisibility = {
    "Summary": true,
    "Breakdown": true,
    "Trend": true,
    "Tips": true,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.settings),
          onPressed: _openSettingsModal,
        ),
        title: Text("Dashboard"),
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
              onSelectionChanged: (newIndex) {
                setState(() {
                  _selectedIndex = newIndex;
                });
              },
            ),
            for (String section in sectionOrder) ...[
              if (sectionVisibility[section] == true) _buildSection(section),
              SizedBox(height: AppConstants.paddingMedium),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String section) {
    switch (section) {
      case "Summary":
        return _buildSummary();
      case "Breakdown":
        return BreakdownSection();
      case "Trend":
        return TrendSection();
      case "Tips":
        return TipsSection();
      default:
        return SizedBox.shrink();
    }
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

  Widget _buildSummary() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildCircularSummary("CO₂", "148kg"),
            _buildCircularSummary("Balance", "RM100"),
            _buildCircularSummary("Income", "RM100"),
          ],
        ),
        SizedBox(height: AppConstants.paddingMedium),
        _buildCard("Quick Statistics",
            "BLABLABLABLA\nasdhahkldsjaisdjkljsd\nashdajskdsdhasdjkah"),
      ],
    );
  }

  Widget _buildCircularSummary(String title, String value) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.green, width: 4),
          ),
          child: Center(child: Text(value)),
        ),
        SizedBox(height: 8.0),
        Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildCard(String title, String content) {
    return Container(
      width: double.infinity,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: EdgeInsets.all(AppConstants.paddingMedium),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Icon
              Padding(
                  padding:
                      EdgeInsets.only(right: 12), // Spacing between icon & text
                  child: Icon(Icons
                      .insert_chart_outlined_outlined) // Replace with your actual icon asset
                  ), // Text Column
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    content,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
