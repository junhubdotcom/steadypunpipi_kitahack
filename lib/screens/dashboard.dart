import 'package:flutter/material.dart';
import 'package:steadypunpipi_vhack/common/constants.dart';
import 'package:steadypunpipi_vhack/widgets/date_selector.dart';
import 'package:steadypunpipi_vhack/widgets/breakdown_section.dart';
import 'package:steadypunpipi_vhack/widgets/trend_section.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 1; // Default to "Weekly"

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.settings),
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
            SizedBox(height: AppConstants.paddingMedium),
            _buildSummary(),
            SizedBox(height: AppConstants.paddingMedium),
            _buildCard("Quick Statistics",
                "BLABLABLABLA\nasdhahkldsjaisdjkljsd\nashdajskdsdhasdjkah"),
            SizedBox(height: AppConstants.paddingMedium),
            BreakdownSection(),
            SizedBox(height: AppConstants.paddingMedium),
            TrendSection(),
            SizedBox(height: AppConstants.paddingMedium),
            _buildTipsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildSummary() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildCircularSummary("CO₂", "148kg"),
        _buildCircularSummary("Balance", "RM100"),
        _buildCircularSummary("Income", "RM100"),
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

  Widget _buildTipsSection() {
    return _buildExpandableCard("Tips", "Your action can make better life");
  }

  Widget _buildExpandableCard(String title, String subtitle) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ExpansionTile(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        children: [
          Padding(
            padding: const EdgeInsets.all(AppConstants.paddingMedium),
            child:
                const Placeholder(child: Text("Many Many Tips and Insights")),
          ),
          Padding(
            padding: const EdgeInsets.all(AppConstants.paddingMedium),
            child:
                const Placeholder(child: Text("Many Many Tips and Insights")),
          ),
          Padding(
            padding: const EdgeInsets.all(AppConstants.paddingMedium),
            child:
                const Placeholder(child: Text("Many Many Tips and Insights")),
          ),
        ],
      ),
    );
  }
}
