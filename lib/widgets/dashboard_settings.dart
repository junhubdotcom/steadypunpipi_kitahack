import 'package:flutter/material.dart';

class DashboardSettingsModal extends StatefulWidget {
  final List<String> initialSections;
  final Function(List<String>, Map<String, bool>) onSave;

  const DashboardSettingsModal({
    Key? key,
    required this.initialSections,
    required this.onSave,
  }) : super(key: key);

  @override
  _DashboardSettingsModalState createState() => _DashboardSettingsModalState();
}

class _DashboardSettingsModalState extends State<DashboardSettingsModal> {
  late List<String> sectionOrder;
  late Map<String, bool> sectionVisibility;

  @override
  void initState() {
    super.initState();
    sectionOrder =
        List.from(widget.initialSections); // Copy to avoid modifying original
    sectionVisibility = {
      "Summary": true,
      "Breakdown": true,
      "Trend": true,
      "Tips": true,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5), // Dimmed background
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Text("Customize Dashboard",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

              // Toggle Visibility
              Column(
                children: sectionOrder.map((section) {
                  return CheckboxListTile(
                    title: Text(section),
                    value: sectionVisibility[section] ?? true,
                    onChanged: (bool? value) {
                      setState(() {
                        sectionVisibility[section] = value ?? false;
                      });
                    },
                  );
                }).toList(),
              ),

              Divider(),

              // Drag and Drop Section Reordering
              Text("Arrange Your Dashboard",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              ReorderableListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                onReorder: (oldIndex, newIndex) {
                  setState(() {
                    final item = sectionOrder.removeAt(oldIndex);
                    sectionOrder.insert(
                        newIndex > oldIndex ? newIndex - 1 : newIndex, item);
                  });
                },
                children: sectionOrder.map((section) {
                  return ListTile(
                    key: ValueKey(section),
                    title: Text(section),
                    leading: Icon(Icons.drag_handle),
                  );
                }).toList(),
              ),

              SizedBox(height: 16),

              // Save Button
              ElevatedButton(
                onPressed: () {
                  widget.onSave(sectionOrder, sectionVisibility);
                  Navigator.pop(context);
                },
                child: Text("Save Changes"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
