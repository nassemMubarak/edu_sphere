import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class SelecteStudentOrTeacherWidget extends StatefulWidget {
  bool isSelectedStudent = true;
  bool isSelectedTeacher = false;
  SelecteStudentOrTeacherWidget({
    super.key,
  });

  @override
  State<SelecteStudentOrTeacherWidget> createState() =>
      _SelecteStudentOrTeacherWidgetState();
}

class _SelecteStudentOrTeacherWidgetState
    extends State<SelecteStudentOrTeacherWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: ColorsManager.secondaryColor,
        borderRadius: BorderRadius.circular(50.r),
      ),
      child: Row(
        children: [
          GestureDetector(
              onTap: () {
                setState(() {
                  widget.isSelectedStudent = true;
                  widget.isSelectedTeacher = false;
                });
              },
              child: containerRadiusWidget(
                  isSelected: widget.isSelectedStudent, text: 'student')),
          GestureDetector(
            onTap: () {
              setState(() {
                widget.isSelectedStudent = false;
                widget.isSelectedTeacher = true;
              });
            },
            child: containerRadiusWidget(
                isSelected: widget.isSelectedTeacher, text: 'teacher'),
          ),
        ],
      ),
    );
  }

  Container containerRadiusWidget({required isSelected, required String text}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: isSelected
          ? BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50.r),
            )
          : null,
      child: Text(
        text,
        style: isSelected
            ? TextStyles.font16SecondaryBlue600Weight
            : TextStyles.font16White600Weight,
      ),
    );
  }
}
