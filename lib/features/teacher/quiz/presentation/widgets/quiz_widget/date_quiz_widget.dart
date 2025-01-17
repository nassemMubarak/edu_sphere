import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/bloc/course_main_cubit.dart';
import 'package:edu_sphere/features/teacher/quiz/presentation/bloc/quiz_cubit.dart';
import 'package:edu_sphere/features/teacher/quiz/presentation/widgets/quiz_widget/selecte_date_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DateQuizWidget extends StatelessWidget {
  DateTime? startDate;
  DateTime? endDate;
   DateQuizWidget({super.key,this.startDate,this.endDate});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelecteDateWidget(
          date: startDate,
          title: 'Quiz start date',
          onChanged: (selectedDate) {
            context.read<QuizCubit>().selectedStartDateQuiz =
                selectedDate;
          },
        ),
        verticalSpace(16),
        SelecteDateWidget(
          date: endDate,
          title: 'Quiz end date',
          onChanged: (selectedDate) {
            context.read<QuizCubit>().selectedEndDateQuiz =
                selectedDate;
            // context.read<CourseMainCubit>().validateEndDate();
          },
        ),
      ],
    );
    // return BlocBuilder<CourseMainCubit, CourseMainState>(
    //   builder: (context, state) {
    //     if (state is ErrorMessageValidateEndDateQuiz) {
    //       if (state.message.isNotEmpty) {
    //         return Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             SelecteDateWidget(
    //               title: 'Quiz start date',
    //               onChanged: (selectedDate) {
    //                 context.read<CourseMainCubit>().selectedStartDateQuiz =
    //                     selectedDate;
    //               },
    //             ),
    //             verticalSpace(16),
    //             SelecteDateWidget(
    //               title: 'Quiz end date',
    //               onChanged: (selectedDate) {
    //                 context.read<CourseMainCubit>().selectedEndDateQuiz =
    //                     selectedDate;
    //                 // context.read<CourseMainCubit>().validateEndDate();
    //               },
    //             ),
    //             verticalSpace(8),
    //             Text(state.message, style: TextStyles.font12Red400Weight),
    //           ],
    //         );
    //       }
    //       else {
    //         return Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             SelecteDateWidget(
    //               title: 'Quiz start date',
    //               onChanged: (selectedDate) {
    //                 context.read<CourseMainCubit>().selectedStartDateQuiz =
    //                     selectedDate;
    //               },
    //             ),
    //             verticalSpace(16),
    //             SelecteDateWidget(
    //               title: 'Quiz end date',
    //               onChanged: (selectedDate) {
    //                 context.read<CourseMainCubit>().selectedEndDateQuiz =
    //                     selectedDate;
    //                 // context.read<CourseMainCubit>().validateEndDate();
    //               },
    //             ),
    //
    //           ],
    //         );
    //       }
    //     } else if(state is ErrorMessageValidateStartDateQuiz) {
    //      return Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           SelecteDateWidget(
    //             title: 'Quiz start date',
    //             onChanged: (selectedDate) {
    //               context
    //                   .read<CourseMainCubit>()
    //                   .selectedStartDateQuiz =
    //                   selectedDate;
    //             },
    //           ),
    //           verticalSpace(8),
    //           Text(state.message, style: TextStyles.font12Red400Weight),
    //           verticalSpace(16),
    //           SelecteDateWidget(
    //             title: 'Quiz end date',
    //             onChanged: (selectedDate) {
    //               context
    //                   .read<CourseMainCubit>()
    //                   .selectedEndDateQuiz =
    //                   selectedDate;
    //               // context.read<CourseMainCubit>().validateEndDate();
    //             },
    //           ),
    //
    //         ],
    //       );
    //     }
    //       else{
    //         return Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             SelecteDateWidget(
    //               title: 'Quiz start date',
    //               onChanged: (selectedDate) {
    //                 context.read<CourseMainCubit>().selectedStartDateQuiz =
    //                     selectedDate;
    //               },
    //             ),
    //             verticalSpace(16),
    //             SelecteDateWidget(
    //               title: 'Quiz end date',
    //               onChanged: (selectedDate) {
    //                 context.read<CourseMainCubit>().selectedEndDateQuiz =
    //                     selectedDate;
    //                 // context.read<CourseMainCubit>().validateEndDate();
    //               },
    //             ),
    //
    //           ],
    //         );
    //       }
    //
    //   },
    // );
  }
}
