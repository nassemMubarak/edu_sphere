import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/widgets/bread_crumb_widget.dart';
import 'package:edu_sphere/core/widgets/sliver_widget.dart';
import 'package:edu_sphere/features/teacher/assessments/domain/entities/estimate_assessment.dart';
import 'package:edu_sphere/features/teacher/assessments/presentation/bloc/assessments_cubit.dart';
import 'package:edu_sphere/features/teacher/assessments/presentation/widgets/estimate_widget/show_review_assessment_widget.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/bloc/course_main_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class ShowReviewAssessmentPage extends StatelessWidget {
  const ShowReviewAssessmentPage({super.key});

  @override
  Widget build(BuildContext context) {
   EstimateAssessment estimateAssessmentSelected = context.read<AssessmentsCubit>().estimateAssessmentSelected!;
    var coursesModel = context.read<CourseMainCubit>().coursesModel;
    var assessment = context.read<AssessmentsCubit>().assessment;
    return Scaffold(
      body: SliverWidget(
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
                items: [
                  'Home',
                  coursesModel.title,
                  assessment!.title,
                  'Estimate',
                  estimateAssessmentSelected.name
                ],
              ),
              verticalSpace(24),
              ShowReviewAssessmentWidget(estimateAssessmentSelected: estimateAssessmentSelected,idCourse:coursesModel.id ),
            ],
          ),
        ),
      ),
    );
  }
}
