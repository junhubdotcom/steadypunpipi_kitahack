import 'package:flutter/material.dart';
import 'package:steadypunpipi_vhack/widgets/dashboard_widgets/expandable_card.dart';

class TipsSection extends StatelessWidget {
  const TipsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ExpandableCard(
      title: "Tips",
      subtitle: "Every action can make life better",
      icon: Icons.tips_and_updates,
      tabs: const [
        Tab(text: "Finance"), 
        Tab(text: "Environment"),
      ],
      tabViews: [
        const Placeholder(child: Text("Tips")),
        const Placeholder(child: Text("Tips")),
      ],
    );
  }
}
