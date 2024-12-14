import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/edu_sphere_app.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/bloc/course_main_cubit.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/widgets/quiz_widgets/selecte_time_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class TimeQuizWidget extends StatefulWidget {
  const TimeQuizWidget({super.key});

  @override
  State<TimeQuizWidget> createState() => _TimeQuizWidgetState();
}

class _TimeQuizWidgetState extends State<TimeQuizWidget> {
  DateTime? startTime;
  DateTime? endTime;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SelectTimeWidget(title: 'Quiz start time',onChanged: (time){
          setState(() {
            startTime = time;
          });

        },),
        verticalSpace(16),
        BlocBuilder<CourseMainCubit,CourseMainState>(
          builder: (context, state) {
            if(state is ErrorMessageValidateEndTimeQuiz){
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SelectTimeWidget(title: 'Quiz end time',onChanged: (time){
                    setState(() {
                      endTime = time;
                    });
                    context.read<CourseMainCubit>().validateStartDate();
                    context.read<CourseMainCubit>().validateEndDate();
                    TimeOfDay timeOfDayEnd = TimeOfDay.fromDateTime(endTime!);
                    TimeOfDay timeOfDayStart = TimeOfDay.fromDateTime(startTime!);
                    if (startTime != null && endTime != null && startTime!.isBefore(endTime!)) {
                      // Add error message or handle invalid time
                      context.read<CourseMainCubit>().validateEndTime(context.read<CourseMainCubit>().selectedStartDateQuiz!, timeOfDayStart, context.read<CourseMainCubit>().selectedEndDateQuiz!, timeOfDayEnd );
                    }else if(startTime != null && endTime != null && startTime!.isAtSameMomentAs(endTime!)){
                      context.read<CourseMainCubit>().validateEndTime(context.read<CourseMainCubit>().selectedStartDateQuiz!, timeOfDayStart, context.read<CourseMainCubit>().selectedEndDateQuiz!, timeOfDayEnd );
                    }
                  },),
                  verticalSpace(8),
                  Text(state.message,style: TextStyles.font12Red400Weight),
                ],
              );
            }
            else{
             return SelectTimeWidget(title: 'Quiz end time',onChanged: (time){
                setState(() {
                  endTime = time;
                });
                context.read<CourseMainCubit>().validateStartDate();
                context.read<CourseMainCubit>().validateEndDate();
                TimeOfDay timeOfDayEnd = TimeOfDay.fromDateTime(endTime!);
                TimeOfDay timeOfDayStart = TimeOfDay.fromDateTime(startTime!);
                if (startTime != null && endTime != null && startTime!.isBefore(endTime!)) {
                  // Add error message or handle invalid time

                  context.read<CourseMainCubit>().validateEndTime(context.read<CourseMainCubit>().selectedStartDateQuiz!, timeOfDayStart, context.read<CourseMainCubit>().selectedEndDateQuiz!, timeOfDayEnd );
                }else if(startTime != null && endTime != null && startTime!.isAtSameMomentAs(endTime!)){
                  context.read<CourseMainCubit>().validateEndTime(context.read<CourseMainCubit>().selectedStartDateQuiz!, timeOfDayStart, context.read<CourseMainCubit>().selectedEndDateQuiz!, timeOfDayEnd);
                }
              },);
            }
          },
        ),
      ],
    );
  }
}
