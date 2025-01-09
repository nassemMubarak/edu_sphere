import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/routing/routes.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/widgets/app_text_button.dart';
import 'package:edu_sphere/core/widgets/image_and_text_empty_data.dart';
import 'package:edu_sphere/core/widgets/sliver_widget.dart';
import 'package:edu_sphere/edu_sphere_app.dart';
import 'package:edu_sphere/features/student/student_main/presentations/bloc/subscribe_student_courses/subscribe_student_courses_cubit.dart';
import 'package:edu_sphere/features/student/student_main/presentations/widgets/student_course_widget.dart';
import 'package:edu_sphere/features/teacher/teacher_main/presentation/widgets/section_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class StudentMainPage extends StatelessWidget {
  const StudentMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<SubscribeStudentCoursesCubit>().emitGetAllSubscribeStudentCourses();
    return SliverWidget(widget: Padding(
      padding: EdgeInsets.only(top: 10.h, left: 16.w, right: 16.w),
      child: Column(
        children: [
          verticalSpace(20),
          SizedBox(
            width: 189.w,
            child: AppTextButton(buttonText:'Add New Course',onPressed:(){
              context.pushNamed(Routes.addCourseStudentSearch);
            },
            backgroundColor: ColorsManager.secondaryColor,
              borderSideColor: ColorsManager.secondaryColor,


            ),
          ),
          verticalSpace(24),
          SectionCard(
            title: AppLocalizations.of(context)!.yourQuizzes,
            icon: 'assets/svgs/quiz_on_computer_question_icon.svg',
            widget: ImageAndTextEmptyData(
              message: AppLocalizations.of(context)!.noQuizzesAdded,
            ),
          ),
          verticalSpace(24),
          StudentCourseWidget(),
          verticalSpace(50),
        ],
      ),
    ),);
  }
}
