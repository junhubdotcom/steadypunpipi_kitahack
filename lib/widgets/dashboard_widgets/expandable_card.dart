import 'package:flutter/material.dart';
import 'package:steadypunpipi_vhack/common/constants.dart';

class ExpandableCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final List<Tab> tabs;
  final List<Widget> tabViews;
  final IconData icon;

  const ExpandableCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.tabs,
    required this.tabViews,
    this.icon = Icons.question_mark, // Default icon
  });

  @override
  _ExpandableCardState createState() => _ExpandableCardState();
}

class _ExpandableCardState extends State<ExpandableCard>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isExpanded = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.tabs.length, vsync: this);
  }

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section (Toggles Expansion)
            GestureDetector(
              onTap: _toggleExpand, // Toggle on tap
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: AppConstants.infoColor,
                    radius: 16,
                    child: Icon(widget.icon, color: Colors.white),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.title,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        Text(widget.subtitle,
                            style: const TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),
                  Icon(_isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // Expandable Content
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: ClipRect(
                child: _isExpanded
                    ? Column(
                        children: [
                          TabBar(
                            controller: _tabController,
                            labelColor: Colors.black,
                            unselectedLabelColor: Colors.grey,
                            indicatorColor: Colors.black,
                            tabs: widget.tabs,
                          ),
                          const SizedBox(height: 12),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            constraints: _isExpanded
                                ? const BoxConstraints(maxHeight: 300)
                                : const BoxConstraints(maxHeight: 0),
                            child: TabBarView(
                              controller: _tabController,
                              children: widget.tabViews,
                            ),
                          ),
                        ],
                      )
                    : const SizedBox(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
