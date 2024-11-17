import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/widgets/wave_top_widget.dart';
import 'package:edu_sphere/features/teacher/teacher_main/ui/widgets/drawer_widget_teacher.dart';
import 'package:edu_sphere/features/teacher/teacher_main/ui/widgets/image_and_text_empty_data.dart';
import 'package:edu_sphere/features/teacher/teacher_main/ui/widgets/section_card.dart';
import 'package:edu_sphere/features/teacher/teacher_main/ui/widgets/section_card_courses.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TeacherMainScreen extends StatelessWidget {
  const TeacherMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        // elevation: 0,
        forceMaterialTransparency: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: const DrawerWidgetTeacher(),
      body: Stack(
        children: [
          const WaveTopWidget(),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 200.h, left: 16.w, right: 16.w),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SectionCard(
                      title: 'Your Quizzes & Assessment',
                      message: 'You have not added any quizzes yet.',
                      icon: 'assets/svgs/quiz_on_computer_question_icon.svg',
                      widget: ImageAndTextEmptyData(
                          message: 'You have not added any courses yet.'),
                    ),
                    verticalSpace(24),
                    SectionCardCourses(),
                    verticalSpace(50),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
