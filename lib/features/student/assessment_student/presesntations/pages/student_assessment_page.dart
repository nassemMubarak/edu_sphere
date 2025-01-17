import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/widgets/sliver_widget.dart';
import 'package:edu_sphere/features/student/assessment_student/presesntations/bloc/student_assessment_cubit.dart';
import 'package:edu_sphere/features/student/assessment_student/presesntations/widgets/ShimmerShowStudentAssessmentWidget.dart';
import 'package:edu_sphere/features/student/assessment_student/presesntations/widgets/build_sliver_student_assessment_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentAssessmentPage extends StatelessWidget {
  const StudentAssessmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverWidget(
      leading:   IconButton(
        onPressed: () {
          context.pop();
        },
        icon: Icon(Icons.arrow_back),
      ),
      widget: BlocBuilder<StudentAssessmentCubit, StudentAssessmentState>(
        buildWhen: (previous, current) => current is ShowStudentAssessmentLoadedState,
        builder: (context, state) {
          if(state is ShowStudentAssessmentLoadingState){
              return Shimmershowstudentassessmentwidget();
          }
          if(state is ShowStudentAssessmentLoadedState){
            return BuildSliverStudentAssessmentWidget(assessment: state.assessment);
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
