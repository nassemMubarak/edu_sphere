import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/widgets/icon_and_label_and_select_item_widget.dart';
import 'package:flutter/material.dart';

class SelecteDateWidget extends StatefulWidget {
  final String title;
  final Function(DateTime?) onChanged;
   SelecteDateWidget({super.key, required this.title,required this.onChanged});

  @override
  State<SelecteDateWidget> createState() => _SelecteDateWidgetState();
}

class _SelecteDateWidgetState extends State<SelecteDateWidget> {
  String? selectedDay;
  String? selectedMonth;
  String? selectedYear;
  List<String> days = [];
  final List<String> months = List.generate(12, (index) => (index + 1).toString());
  final List<String> years = List.generate(30, (index) => (DateTime.now().year + index).toString());
  @override
  void initState() {
    super.initState();
    // Initialize the days with 31 days as default
    days = List.generate(31, (index) => (index + 1).toString());
  }
  // Function to update days based on the selected month and year
  void updateDays(String? month, String? year) {
    if (month != null && int.tryParse(month) != null) {
      int monthInt = int.parse(month);
      int yearInt = year != null && int.tryParse(year) != null
          ? int.parse(year)
          : DateTime.now().year;

      // Calculate the number of days in the selected month
      int daysInMonth = DateTime(yearInt, monthInt + 1, 0).day;
      setState(() {
        days = List.generate(daysInMonth, (index) => (index + 1).toString());
        if (selectedDay != null && int.parse(selectedDay!) > daysInMonth) {
          selectedDay = null; // Reset day if it exceeds the valid range
        }
      });
    }
  }
  DateTime? getSelectedDate() {
    if (selectedDay != null && selectedMonth != null && selectedYear != null) {
      return DateTime(int.parse(selectedYear!), int.parse(selectedMonth!), int.parse(selectedDay!));
    }
    return null;
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            IconAndLabelAndSelectItemWidget(items: days,value: selectedDay, urlIcon: 'assets/svgs/day_icon.svg', label: 'Days', hintText: 'Days',onChanged: (day){
              setState(() {
                selectedDay = day;
              });
              widget.onChanged(getSelectedDate());
            },),
            horizontalSpace(8),
            IconAndLabelAndSelectItemWidget(items: months,value: selectedMonth, urlIcon: 'assets/svgs/month_icon.svg', label: 'Month', hintText: 'Month',onChanged: (month){
              setState(() {
                selectedMonth = month;
                updateDays(selectedMonth, selectedYear);
              });
              widget.onChanged(getSelectedDate());
            },),
            horizontalSpace(8),
            IconAndLabelAndSelectItemWidget(items: years,value: selectedYear, urlIcon: 'assets/svgs/year_icon.svg', label: 'Year', hintText: 'Year',onChanged: (year){
              setState(() {
                selectedYear = year;
                updateDays(selectedMonth, selectedYear);
              });
              widget.onChanged(getSelectedDate());
            },),

          ],
        ),

      ],
    );
  }
}
