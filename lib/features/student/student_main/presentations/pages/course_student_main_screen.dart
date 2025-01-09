import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/widgets/bread_crumb_widget.dart';
import 'package:edu_sphere/core/widgets/sliver_widget.dart';
import 'package:edu_sphere/features/student/student_main/presentations/bloc/subscribe_student_courses/subscribe_student_courses_cubit.dart';
import 'package:edu_sphere/features/student/student_main/presentations/widgets/student_advertisements_widget.dart';
import 'package:edu_sphere/features/student/student_main/presentations/widgets/student_document_to_course_widget.dart';
import 'package:edu_sphere/features/student/student_main/presentations/widgets/student_lecture_widget.dart';
import 'package:edu_sphere/features/student/student_main/presentations/widgets/student_quiz_widget.dart';
import 'package:edu_sphere/features/teacher/teacher_main/domain/entities/course.dart';
import 'package:edu_sphere/features/teacher/teacher_main/presentation/widgets/section_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class CourseStudentMainScreen extends StatelessWidget {
  const CourseStudentMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Course coursesModel = context
        .read<SubscribeStudentCoursesCubit>()
        .courseSelected!;
    return SliverWidget(
      leading: IconButton(onPressed: (){
        context.pop();
      }, icon: Icon(Icons.arrow_back_ios),),
      widget: Container(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            verticalSpace(15),

            BreadCrumbWidget(
              items: ['Home', coursesModel.title],
            ),
            verticalSpace(24),
            SectionCard(
              showAddButton: false,
              title: coursesModel.title,
              icon: 'assets/svgs/message_icon.svg',
              widget: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  coursesModel.description,
                ),
              ),
            ),
            verticalSpace(24),
            StudentAdvertisementsWidget(idCourse: coursesModel.id),
            // AdvertisementsWidget(idCourse: coursesModel.id),
            verticalSpace(24),
            StudentQuizWidget(idCourse: coursesModel.id),
            verticalSpace(24),
            StudentLectureWidget(idCourse: coursesModel.id),
            // LecturesWidget(idCourse: coursesModel.id),
            // verticalSpace(24),
            // QuizeWidget(idCourse: coursesModel.id,),
            // verticalSpace(24),
            // SectionCard(
            //   title: 'Assessment',
            //   icon: 'assets/svgs/annual_assessment_icon.svg',
            //   infoDialog: AddAdvertisementsInfoDialog(idCourse: coursesModel.id),
            //   widget:  ImageAndTextEmptyData(
            //     message: 'You have not added any Assessment yet.',
            //   ),
            // ),
            verticalSpace(24),
            StudentDocumentToCourseWidget(idCourse: coursesModel.id),
            verticalSpace(24),
          ],
        ),
      ),
    ),
    );
  }
}
