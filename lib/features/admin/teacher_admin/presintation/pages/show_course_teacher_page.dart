import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/routing/routes.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/widgets/bread_crumb_widget.dart';
import 'package:edu_sphere/core/widgets/image_and_text_empty_data.dart';
import 'package:edu_sphere/core/widgets/sliver_widget.dart';
import 'package:edu_sphere/features/admin/admin_main/presentation/bloc/admin_main_cubit.dart';
import 'package:edu_sphere/features/admin/teacher_admin/presintation/bloc/show_courrse_teacher/show_course_teacher_cubit.dart';
import 'package:edu_sphere/features/admin/teacher_admin/presintation/bloc/teacher_admin_cubit.dart';
import 'package:edu_sphere/features/admin/teacher_admin/presintation/widgets/shimmer_information_teacher_admin_widget.dart';
import 'package:edu_sphere/features/admin/teacher_admin/presintation/widgets/show_course_teacher/show_advertisement_widget.dart';
import 'package:edu_sphere/features/admin/teacher_admin/presintation/widgets/show_course_teacher/show_lecture_widget.dart';
import 'package:edu_sphere/features/admin/teacher_admin/presintation/widgets/show_course_teacher/show_quizzes_and_assessments_widget.dart';
import 'package:edu_sphere/features/auth/domain/entities/user.dart';
import 'package:edu_sphere/features/teacher/assessments/domain/entities/document_assessment.dart';
import 'package:edu_sphere/features/teacher/course_main/domain/entities/advertisement.dart';
import 'package:edu_sphere/features/teacher/course_main/domain/entities/lecture.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/bloc/course_lecture/course_lecture_cubit.dart';
import 'package:edu_sphere/features/teacher/teacher_main/domain/entities/course.dart';
import 'package:edu_sphere/features/teacher/teacher_main/presentation/widgets/section_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ShowCourseTeacherPage extends StatelessWidget {
  const ShowCourseTeacherPage({super.key});

  @override
  Widget build(BuildContext context) {
    User teacher = context.read<AdminMainCubit>().selectedTeacher!;
    Course course = context.read<TeacherAdminCubit>().courseSelected!;
    return SliverWidget(
      leading: IconButton(onPressed: (){
        context.pop();
      }, icon: Icon(Icons.arrow_back)),
      widget: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            BreadCrumbWidget(
              items: ['Home', 'teacher', teacher.name, 'Course', course.title],
            ),
            verticalSpace(24),
            SectionCard(
              showAddButton: false,
              title: course.title,
              icon: 'assets/svgs/message_icon.svg',
              widget: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  course.description,
                ),
              ),
            ),
            verticalSpace(24),
            BlocBuilder<ShowCourseTeacherCubit, ShowCourseTeacherState>(
              builder: (context, state) {
                if (state is ShowCourseTeacherLoadingState) {
                  return ShimmerInformationTeacherAdminWidget();
                } else if (state is ShowCourseTeacherLoadedDataState) {
                  return Column(
                    children: [
                      /// show advertisements
                      ShowAdvertisementWidget(showCourseTeacher: state
                          .showCourseTeacher),
                      verticalSpace(20),
                      /// show lecture widget
                      ShowLectureWidget(showCourseTeacher: state.showCourseTeacher),
                      verticalSpace(20),
                      ShowQuizzesAndAssessmentsWidget(showCourseTeacher: state.showCourseTeacher),
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      /// show advertisements
                      ShowAdvertisementWidget(showCourseTeacher: context
                          .read<ShowCourseTeacherCubit>()
                          .showCourseTeacher),
                      verticalSpace(20),
                      /// show lecture widget
                      ShowLectureWidget(showCourseTeacher:context
                    .read<ShowCourseTeacherCubit>()
                    .showCourseTeacher ),
                      verticalSpace(20),


                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }


  ListTile buildListTile(
      {required DocumentAssessment chapter, required BuildContext context, required int index,required int idCourse}) {
    return ListTile(
      contentPadding: EdgeInsetsDirectional.zero,
      leading: GestureDetector(
          onTap: () {}, child: SvgPicture.asset('assets/svgs/pdf_icon.svg')),
      title: Text(
        chapter.title ?? 'Document $index',
        style: TextStyles.font14Black400Weight,
      ),
    );
  }

}
