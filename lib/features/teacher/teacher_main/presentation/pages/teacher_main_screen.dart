import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/widgets/sliver_widget.dart';
import 'package:edu_sphere/core/widgets/image_and_text_empty_data.dart';
import 'package:edu_sphere/features/teacher/teacher_main/presentation/logic/teacher_main_cubit.dart';
import 'package:edu_sphere/features/teacher/teacher_main/presentation/widgets/section_card.dart';
import 'package:edu_sphere/features/teacher/teacher_main/presentation/widgets/section_card_courses.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:edu_sphere/l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class TeacherMainScreen extends StatelessWidget {
  const TeacherMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<TeacherMainCubit>().emitGetAllCourses();
    return SliverWidget(
      widget:  Padding(
        padding: EdgeInsets.only(top: 10.h, left: 16.w, right: 16.w),
        child: Column(
          children: [
            verticalSpace(20),
            SectionCard(
              title: AppLocalizations.of(context)!.yourQuizzes,
              icon: 'assets/svgs/quiz_on_computer_question_icon.svg',
              widget: ImageAndTextEmptyData(
                message: AppLocalizations.of(context)!.noQuizzesAdded,
              ),
            ),
            verticalSpace(24),
            SectionCardCourses(),
            verticalSpace(50),
          ],
        ),
      ),
    );
  }
}

