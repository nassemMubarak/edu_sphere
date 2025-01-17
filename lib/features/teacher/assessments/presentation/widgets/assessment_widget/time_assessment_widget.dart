import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/features/teacher/assessments/presentation/bloc/assessments_cubit.dart';
import 'package:edu_sphere/features/teacher/quiz/presentation/bloc/quiz_cubit.dart';
import 'package:edu_sphere/features/teacher/quiz/presentation/widgets/quiz_widget/selecte_time_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class TimeAssessmentWidget extends StatelessWidget {
  DateTime? startDateTime;
  DateTime? endDateTime;
  TimeAssessmentWidget({super.key,this.startDateTime,this.endDateTime});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SelectTimeWidget(title: 'Assessment start time',dateTime: startDateTime,onChanged: (time){
            context.read<AssessmentsCubit>().startTime = time;
        },),
        verticalSpace(16),
        SelectTimeWidget(title: 'Assessment end time',dateTime: endDateTime,onChanged: (time){
            context.read<AssessmentsCubit>().endTime = time;

        },
        )
      ],
    );
  }
}
