import 'package:flutter/material.dart';
import 'package:steadypunpipi_vhack/common/constants.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';

class DateSelector extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onSelectionChanged;

  const DateSelector({super.key, required this.selectedIndex, required this.onSelectionChanged});

  @override
  _DateSelectorState createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  late int _selectedIndex;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  void _changeDate(int days) {
    setState(() {
      _selectedDate = _selectedDate.add(Duration(days: days));
    });
  }

  String _getFormattedDateRange() {
    DateTime startDate;
    DateTime endDate;
    String formattedDate;

    switch (_selectedIndex) {
      case 0: // Daily
        formattedDate = _formatDate(_selectedDate);
        break;
      case 1: // Weekly
        startDate =
            _selectedDate.subtract(Duration(days: _selectedDate.weekday - 1));
        endDate = startDate.add(Duration(days: 6));
        formattedDate = "${_formatDate(startDate)} - ${_formatDate(endDate)}";
        break;
      case 2: // Monthly
        startDate = DateTime(_selectedDate.year, _selectedDate.month, 1);
        endDate = DateTime(_selectedDate.year, _selectedDate.month + 1, 0);
        formattedDate = "${_formatDate(startDate)} - ${_formatDate(endDate)}";
        break;
      default:
        return '';
    }

    return formattedDate;
  }

  String _formatDate(DateTime date) {
    return "${_getMonthName(date.month)} ${date.day}";
  }

  String _getMonthName(int month) {
    List<String> months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
    ];
    return months[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSegmentedControl(),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _selectedIndex == 0
                        ? "Today"
                        : _selectedIndex == 1
                            ? "This week"
                            : "This month",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    _getFormattedDateRange(),
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),
              Row(
                children: [
                  _buildNavButton(
                      Icons.chevron_left,
                      () => _changeDate(-(_selectedIndex == 0
                          ? 1
                          : _selectedIndex == 1
                              ? 7
                              : 30))),
                  SizedBox(width: 8),
                  _buildNavButton(
                      Icons.chevron_right,
                      () => _changeDate((_selectedIndex == 0
                          ? 1
                          : _selectedIndex == 1
                              ? 7
                              : 30))),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNavButton(IconData icon, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            border: Border.all(color: Colors.grey.shade300, width: 1.5),
            borderRadius: BorderRadius.circular(10.0)),
        child: Icon(icon, size: 20, color: Colors.black87),
      ),
    );
  }

  Widget _buildSegmentedControl() {
    return Center(
      child: Container(
        width: 350, 
        padding: EdgeInsets.all(AppConstants.paddingExtraSmall),
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(30),
        ),
        child: CustomSlidingSegmentedControl<int>(
          isStretch: true,
          initialValue: _selectedIndex,
          children: {
            0: Text(
              'Daily',
              style: TextStyle(
                fontSize: AppConstants.fontSizeMedium,
                fontWeight: FontWeight.bold,
                color: _selectedIndex == 0
                    ? AppConstants.infoColor
                    : Colors.black54,
              ),
            ),
            1: Text(
              'Weekly',
              style: TextStyle(
                fontSize: AppConstants.fontSizeMedium,
                fontWeight: FontWeight.bold,
                color: _selectedIndex == 1
                    ? AppConstants.infoColor
                    : Colors.black54,
              ),
            ),
            2: Text(
              'Monthly',
              style: TextStyle(
                fontSize: AppConstants.fontSizeMedium,
                fontWeight: FontWeight.bold,
                color: _selectedIndex == 2
                    ? AppConstants.infoColor
                    : Colors.black54,
              ),
            ),
          },
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
          thumbDecoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 4.0,
                spreadRadius: 1.0,
                offset: Offset(0.0, 2.0),
              ),
            ],
          ),
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          onValueChanged: (value) {
            setState(() {
              _selectedIndex = value;
            });
          },
        ),
      ),
    );
  }
}
