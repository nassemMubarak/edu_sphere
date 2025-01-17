import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/features/teacher/assessments/presentation/bloc/assessments_cubit.dart';
import 'package:edu_sphere/features/teacher/quiz/presentation/bloc/quiz_cubit.dart';
import 'package:edu_sphere/features/teacher/quiz/presentation/widgets/quiz_widget/selecte_date_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class DateAssessmentWidget extends StatelessWidget {
  DateTime? startDate;
  DateTime? endDate;
  DateAssessmentWidget({super.key,this.startDate,this.endDate});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelecteDateWidget(
          date: startDate,
          title: 'Assessment Start Date',
          onChanged: (selectedDate) {
            context.read<AssessmentsCubit>().selectedStartDateAssessment =
                selectedDate;
          },
        ),
        verticalSpace(16),
        SelecteDateWidget(
          date: endDate,
          title: 'Assessment End Date',
          onChanged: (selectedDate) {
            context.read<AssessmentsCubit>().selectedEndDateAssessment =
                selectedDate;
            // context.read<CourseMainCubit>().validateEndDate();
          },
        ),
      ],
    );

  }
}
