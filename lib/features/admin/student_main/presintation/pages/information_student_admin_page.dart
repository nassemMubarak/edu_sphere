import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/widgets/bread_crumb_widget.dart';
import 'package:edu_sphere/core/widgets/sliver_widget.dart';
import 'package:edu_sphere/features/admin/admin_main/presentation/bloc/admin_main_cubit.dart';
import 'package:edu_sphere/features/admin/student_main/presintation/bloc/student_admin_cubit.dart';
import 'package:edu_sphere/features/admin/student_main/presintation/widgets/information_student_admin_widget.dart';
import 'package:edu_sphere/features/admin/student_main/presintation/widgets/show_communication_to_student_admin_widget.dart';
import 'package:edu_sphere/features/admin/student_main/presintation/widgets/show_courses_student_admin_widget.dart';
import 'package:edu_sphere/features/admin/student_main/presintation/widgets/show_quizzes_and_assessments_student_admin_widget_widget.dart';
import 'package:edu_sphere/features/admin/teacher_admin/presintation/bloc/teacher_admin_cubit.dart';
import 'package:edu_sphere/features/admin/teacher_admin/presintation/widgets/information_teacher_admin_widget.dart';
import 'package:edu_sphere/features/admin/teacher_admin/presintation/widgets/show_communication_to_teacher_admin_widget.dart';
import 'package:edu_sphere/features/admin/teacher_admin/presintation/widgets/show_course_teacher/show_quizzes_and_assessments_widget.dart';
import 'package:edu_sphere/features/admin/teacher_admin/presintation/widgets/show_student_to_teacher_admin_widget.dart';
import 'package:edu_sphere/features/auth/domain/entities/user.dart';
import 'package:edu_sphere/features/admin/teacher_admin/presintation/widgets/show_courses_teacher_admin_widget.dart';
import 'package:edu_sphere/features/teacher/teacher_main/presentation/widgets/section_card.dart';
import 'package:edu_sphere/l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';

class InformationStudentAdminPage extends StatelessWidget {
  const InformationStudentAdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    User student = context.read<AdminMainCubit>().selectedStudent!;
    return SliverWidget(
      leading: IconButton(
        onPressed: () {
          context.pop();
        },
        icon: Icon(Icons.arrow_back),
      ),
      widget: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            BreadCrumbWidget(
              items: ['Home', 'Student', student.name],
            ),
            verticalSpace(24),
            BlocBuilder<StudentAdminCubit,StudentAdminState>(builder: (context, state) {
              if(state is GetInformationStudentLoadingState){
                return Column(
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        height: 200,
                        color: Colors.white,
                      ),
                    ),
                    verticalSpace(24),
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        height: 200,
                        color: Colors.white,
                      ),
                    ),
                    verticalSpace(24),
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        height: 200,
                        color: Colors.white,
                      ),
                    ),
                    verticalSpace(24),
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        height: 200,
                        color: Colors.white,
                      ),
                    ),
                    verticalSpace(24),
                  ],
                );
              }else if(state is GetInformationStudentLoadedDataState){
                return Column(
                  children: [
                    InformationStudentAdminWidget(studentInformationModel: state.studentInformation),
                    verticalSpace(24),
                    ShowCoursesStudentAdminWidget(studentInformationModel: state.studentInformation),
                    verticalSpace(24),
                    // ShowCommunicationToStudentAdminWidget(teacherInformation: state.studentInformation),
                    verticalSpace(24),
                    ShowQuizzesAndAssessmentsStudentAdminWidgetWidget(studentInformationModel: state.studentInformation),
                  ],
                );
              }else{
                return Text('Else');
              }
            },),
          ],
        ),
      ),
    );
  }
}


