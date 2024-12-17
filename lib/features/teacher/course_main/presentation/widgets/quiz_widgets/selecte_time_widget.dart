
import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/widgets/icon_and_label_and_select_item_widget.dart';
import 'package:flutter/material.dart';

class SelectTimeWidget extends StatefulWidget {
  final String title;
  final Function(DateTime?) onChanged;
  DateTime? dateTime;
   SelectTimeWidget({super.key, required this.title,required this.onChanged,this.dateTime});

  @override
  _SelectTimeWidgetState createState() => _SelectTimeWidgetState();
}

class _SelectTimeWidgetState extends State<SelectTimeWidget> {
  String? selectedHour;
  String? selectedMinute;
  String? selectedAmPm;

  final List<String> hours = List.generate(12, (index) => (index + 1).toString().padLeft(2, '0'));
  final List<String> minutes = List.generate(60, (index) => index.toString().padLeft(2, '0'));
  final List<String> amPmOptions = ['AM', 'PM'];
  DateTime? selectedTime;
@override
  void initState() {
  if (widget.dateTime != null) {
    selectedHour = (widget.dateTime!.hour > 12
        ? widget.dateTime!.hour - 12
        : widget.dateTime!.hour)
        .toString()
        .padLeft(2, '0');

    selectedMinute = widget.dateTime!.minute.toString().padLeft(2, '0');
    selectedAmPm = widget.dateTime!.hour < 12 ? 'AM' : 'PM';
  }
    super.initState();
  }
  void validateAndUpdateTime() {
    if (selectedHour != null && selectedMinute != null && selectedAmPm != null) {
      // Converting selected time to DateTime object
      selectedTime = DateTime(2000, 1, 1, int.parse(selectedHour!), int.parse(selectedMinute!));
      if (selectedAmPm == 'PM' && selectedTime!.hour < 12) {
        selectedTime = selectedTime!.add(Duration(hours: 12)); // Add 12 hours for PM
      } else if (selectedAmPm == 'AM' && selectedTime!.hour == 12) {
        selectedTime = selectedTime!.subtract(Duration(hours: 12)); // Convert 12 AM to 00:00
      }
      widget.onChanged(selectedTime); // Call the passed onChanged function
    }
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
            IconAndLabelAndSelectItemWidget(items: hours,value: selectedHour, urlIcon: 'assets/svgs/hour_icon.svg', label: 'Hour', hintText: 'Hour',onChanged: (hour) {
              setState(() {
                selectedHour = hour;
              });
              validateAndUpdateTime(); // Validate time after selection
            },),
            horizontalSpace(8),
            IconAndLabelAndSelectItemWidget(items: minutes,value: selectedMinute, urlIcon: 'assets/svgs/minute_icon.svg', label: 'Minute', hintText: 'Minute',onChanged: (minute) {
              setState(() {
                selectedMinute = minute;
              });
              validateAndUpdateTime(); // Validate time after selection
            },),
            horizontalSpace(8),
            IconAndLabelAndSelectItemWidget(items: amPmOptions,value: selectedAmPm, urlIcon: 'assets/svgs/am_icon.svg', label: 'AM/PM', hintText: 'AM/PM',onChanged: (selectAmPm) {
              setState(() {
                selectedAmPm = selectAmPm;
              });
              validateAndUpdateTime(); // Validate time after selection
            },),


          ],
        ),
      ],
    );
  }
}
