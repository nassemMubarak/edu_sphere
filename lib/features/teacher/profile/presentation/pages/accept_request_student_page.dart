import 'package:edu_sphere/core/widgets/sliver_widget.dart';
import 'package:edu_sphere/features/teacher/teacher_main/ui/widgets/section_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class AcceptRequestStudentPage extends StatelessWidget {
  const AcceptRequestStudentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverWidget(
        widget: Padding(
          padding: EdgeInsets.only(top: 20.h, left: 16.w, right: 16.w),
          child: SectionCard(
              title: 'Student information',
              icon: 'assets/svgs/student_information_icon.svg',
              widget: Column(
                children: [

                ],
              ),),
        ),);
  }
}
