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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SelectTimeWidget(title: 'Quiz start time',onChanged: (time){
            context.read<CourseMainCubit>().startTime = time;
          setState(() {
          });

        },),
        verticalSpace(16),
        SelectTimeWidget(title: 'Quiz end time',onChanged: (time){
            context.read<CourseMainCubit>().endTime = time;
          setState(() {
            print('--------------------------------------');
          });
        },
        )
        // BlocBuilder<CourseMainCubit,CourseMainState>(
        //   builder: (context, state) {
        //     if(state is ErrorMessageValidateEndTimeQuiz){
        //       return Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           SelectTimeWidget(title: 'Quiz end time',onChanged: (time){
        //             setState(() {
        //               context.read<CourseMainCubit>().endTime = time;
        //             });
        //             // context.read<CourseMainCubit>().validateStartDate();
        //             // context.read<CourseMainCubit>().validateEndDate();
        //             // TimeOfDay timeOfDayEnd = TimeOfDay.fromDateTime(context.read<CourseMainCubit>().endTime!);
        //             // TimeOfDay timeOfDayStart = TimeOfDay.fromDateTime(context.read<CourseMainCubit>().startTime!);
        //             // if (context.read<CourseMainCubit>().startTime != null && context.read<CourseMainCubit>().endTime != null && context.read<CourseMainCubit>().startTime!.isBefore(context.read<CourseMainCubit>().endTime!)) {
        //             //   // Add error message or handle invalid time
        //             //   context.read<CourseMainCubit>().validateEndTime(context.read<CourseMainCubit>().selectedStartDateQuiz!, timeOfDayStart, context.read<CourseMainCubit>().selectedEndDateQuiz!, timeOfDayEnd );
        //             // }else if(context.read<CourseMainCubit>().startTime != null && context.read<CourseMainCubit>().endTime != null && context.read<CourseMainCubit>().startTime!.isAtSameMomentAs(context.read<CourseMainCubit>().endTime!)){
        //             //   context.read<CourseMainCubit>().validateEndTime(context.read<CourseMainCubit>().selectedStartDateQuiz!, timeOfDayStart, context.read<CourseMainCubit>().selectedEndDateQuiz!, timeOfDayEnd );
        //             // }
        //           },
        //           ),
        //           verticalSpace(8),
        //           Text(state.message,style: TextStyles.font12Red400Weight),
        //         ],
        //       );
        //     }
        //     else{
        //      return SelectTimeWidget(title: 'Quiz end time',onChanged: (time){
        //         setState(() {
        //           context.read<CourseMainCubit>().endTime = time;
        //         });
        //         context.read<CourseMainCubit>().validateStartDate();
        //         context.read<CourseMainCubit>().validateEndDate();
        //         TimeOfDay timeOfDayEnd = TimeOfDay.fromDateTime(context.read<CourseMainCubit>().endTime!);
        //         TimeOfDay timeOfDayStart = TimeOfDay.fromDateTime(context.read<CourseMainCubit>().startTime!);
        //         if (context.read<CourseMainCubit>().startTime != null && context.read<CourseMainCubit>().endTime != null && context.read<CourseMainCubit>().startTime!.isBefore(context.read<CourseMainCubit>().endTime!)) {
        //           // Add error message or handle invalid time
        //
        //           context.read<CourseMainCubit>().validateEndTime(context.read<CourseMainCubit>().selectedStartDateQuiz!, timeOfDayStart, context.read<CourseMainCubit>().selectedEndDateQuiz!, timeOfDayEnd );
        //         }else if(context.read<CourseMainCubit>().startTime != null && context.read<CourseMainCubit>().endTime != null && context.read<CourseMainCubit>().startTime!.isAtSameMomentAs(context.read<CourseMainCubit>().endTime!)){
        //           context.read<CourseMainCubit>().validateEndTime(context.read<CourseMainCubit>().selectedStartDateQuiz!, timeOfDayStart, context.read<CourseMainCubit>().selectedEndDateQuiz!, timeOfDayEnd);
        //         }
        //       },);
        //     }
        //   },
        // ),
      ],
    );
  }
}
