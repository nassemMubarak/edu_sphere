import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/edu_sphere_app.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/bloc/course_main_cubit.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/widgets/quiz_widgets/selecte_time_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class TimeQuizWidget extends StatelessWidget {
  DateTime? startDateTime;
  DateTime? endDateTime;
   TimeQuizWidget({super.key,this.startDateTime,this.endDateTime});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SelectTimeWidget(title: 'Quiz start time',dateTime: startDateTime,onChanged: (time){
            context.read<CourseMainCubit>().startTime = time;


        },),
        verticalSpace(16),
        SelectTimeWidget(title: 'Quiz end time',dateTime: endDateTime,onChanged: (time){
            context.read<CourseMainCubit>().endTime = time;

        },
        )
      ],
    );
  }
}
