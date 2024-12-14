import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/bloc/course_main_cubit.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/widgets/quiz_widgets/selecte_date_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DateQuizWidget extends StatelessWidget {
  const DateQuizWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelecteDateWidget(
          title: 'Quiz start date',
          onChanged: (selectedDate) {
            context.read<CourseMainCubit>().selectedStartDateQuiz =
                selectedDate;
          },
        ),
        verticalSpace(16),
        SelecteDateWidget(
          title: 'Quiz end date',
          onChanged: (selectedDate) {
            context.read<CourseMainCubit>().selectedEndDateQuiz =
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
