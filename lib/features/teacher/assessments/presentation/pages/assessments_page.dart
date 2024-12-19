import 'package:edu_sphere/features/teacher/assessments/presentation/bloc/assessments_cubit.dart';
import 'package:edu_sphere/features/teacher/assessments/presentation/widgets/assessment_widget/build_sliver_assessment_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class AssessmentsPage extends StatelessWidget {
  const AssessmentsPage({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<AssessmentsCubit, AssessmentsState>(
      builder: (context, state) {
        if (state is SelectedAssessment) {
          return BuildSliverAssessmentWidget(assessment: state.assessment);
        } else {
          return context.read<AssessmentsCubit>().assessment!=null?BuildSliverAssessmentWidget(assessment:context.read<AssessmentsCubit>().assessment!):const SizedBox.shrink();
        }
      },
    );
  }


}

