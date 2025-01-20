import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/widgets/sliver_widget.dart';
import 'package:edu_sphere/features/student/estimates_students/presentations/widgets/estimate_student_main_widget.dart';
import 'package:edu_sphere/features/student/show_studetn_course_teachers/presentations/widgets/show_student_teacher_main_widget.dart';
import 'package:edu_sphere/features/student/student_main/presentations/widgets/student_course_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class ShowStudentTeacherMainPage extends StatelessWidget {
  const ShowStudentTeacherMainPage({super.key});
  @override
  Widget build(BuildContext context) {
    return SliverWidget(
      widget: Padding(
        padding: EdgeInsets.only(top: 10.h, left: 16.w, right: 16.w),
        child: Column(
          children: [
            verticalSpace(24),
            ShowStudentTeacherMainWidget(),
            verticalSpace(50),
          ],
        ),
      ),
    );
  }
}
