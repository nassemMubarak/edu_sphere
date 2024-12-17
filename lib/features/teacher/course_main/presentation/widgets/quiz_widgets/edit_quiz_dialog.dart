import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/util/snackbar_message.dart';
import 'package:edu_sphere/core/widgets/app_text_button.dart';
import 'package:edu_sphere/core/widgets/app_text_form_field.dart';
import 'package:edu_sphere/core/widgets/dropdown_widget.dart';
import 'package:edu_sphere/core/widgets/label_and_widget.dart';
import 'package:edu_sphere/features/auth/presentation/bloc/auth/auth_cubit.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/bloc/course_main_cubit.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/widgets/quiz_widgets/date_quiz_widget.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/widgets/quiz_widgets/time_quiz_widget.dart';
import 'package:edu_sphere/features/teacher/quiz/domain/entities/quiz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditQuizDialog extends StatelessWidget {
  Quiz quiz;
  EditQuizDialog({super.key,required this.quiz});

  @override
  Widget build(BuildContext context) {
    context.read<CourseMainCubit>().quizTitleTextEditionController = TextEditingController(text: quiz.quizTitle);
    context.read<CourseMainCubit>().quizTimeLiftTextEditionController = TextEditingController(text: quiz.timeLift.toString());
    context.read<CourseMainCubit>().quizQuizScoreTextEditionController = TextEditingController(text: quiz.passingScore.toString());
    context.read<CourseMainCubit>().quizDescriptionTextEditionController = TextEditingController(text: quiz.description);
    context.read<CourseMainCubit>().selectedStartDateQuiz = quiz.startDateTime;
    context.read<CourseMainCubit>().selectedEndDateQuiz = quiz.endDateTime;
    context.read<CourseMainCubit>().startDateTimeQuiz = quiz.startDateTime;
    context.read<CourseMainCubit>().endDateTimeQuiz = quiz.endDateTime;
    return AlertDialog(
      contentPadding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 24.w),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      insetPadding: EdgeInsets.all(5),
      backgroundColor: Colors.white,
      scrollable: true,
      title: Text(
        'Edit Quiz',
        style: TextStyles.font16Black600Weight,
        textAlign: TextAlign.center,
      ),
      content: Container(
        width: 0.85.sw,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Form(
              key: context.read<CourseMainCubit>().globalQuizeKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  LabelAndWidget(
                    label: 'Edit Title',
                    widget: AppTextFormField(
                      controller: context
                          .read<CourseMainCubit>()
                          .quizTitleTextEditionController,
                      hintText: 'Quiz title',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Quiz Title';
                        }
                      },
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(15),
                        child: SvgPicture.asset(
                          'assets/svgs/icon_quize_title.svg',
                          color: ColorsManager.neutralGray,
                          width: 15,
                          height: 15,
                        ),
                      ),
                    ),
                  ),
                  LabelAndWidget(
                    label: 'Quiz Description',
                    widget: AppTextFormField(
                      controller: context
                          .read<CourseMainCubit>()
                          .quizDescriptionTextEditionController,
                      maxLines: 5,
                      hintText: 'Quiz Description',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Quiz Description';
                        }
                      },
                      prefixIcon: Container(
                        height: 115,
                        width: 50,
                        alignment: AlignmentDirectional.topCenter,
                        child: const Icon(
                          Icons.message_outlined,
                          size: 20,
                          color: ColorsManager.neutralGray,
                        ),
                      ),
                    ),
                  ),
                  // Select Start And End Date Quiz Widget
                   DateQuizWidget(
                     startDate: quiz.startDateTime,
                     endDate: quiz.endDateTime,
                   ),
                  verticalSpace(16),
                  // Select Start And End Time Quiz Widget
                   TimeQuizWidget(endDateTime: quiz.endDateTime,startDateTime: quiz.startDateTime,),
                  verticalSpace(16),
                  LabelAndWidget(
                    label: 'Time Lift(minute)',
                    widget: AppTextFormField(
                      textInputType: TextInputType.number,
                      controller: context
                          .read<CourseMainCubit>()
                          .quizTimeLiftTextEditionController,
                      hintText: 'time lift',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter time lif';
                        }
                      },
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(15),
                        child: SvgPicture.asset(
                          'assets/svgs/time_icon.svg',
                          color: ColorsManager.neutralGray,
                          width: 15,
                          height: 15,
                        ),
                      ),
                    ),
                  ),
                  LabelAndWidget(
                    label: 'Quiz Score',
                    widget: AppTextFormField(
                      textInputType: TextInputType.number,
                      controller: context
                          .read<CourseMainCubit>()
                          .quizQuizScoreTextEditionController,
                      hintText: 'quiz score',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter quiz score';
                        }
                      },
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(15),
                        child: SvgPicture.asset(
                          'assets/svgs/quiz_score_icon.svg',
                          color: ColorsManager.neutralGray,
                          width: 15,
                          height: 15,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),

            BlocBuilder<CourseMainCubit,CourseMainState>(
              builder: (context, state) {
                if(state is ErrorMessageAddQuiz){
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSpace(10),
                      Text(state.message,style: TextStyles.font12Red400Weight),
                      verticalSpace(10),
                    ],
                  );
                }else{
                  return SizedBox.shrink();
                }
              },
            ),
            verticalSpace(10),
            Row(
              children: [
                Expanded(
                  child: AppTextButton(
                    onPressed: () {
                      if (context
                              .read<CourseMainCubit>()
                              .globalQuizeKey
                              .currentState!
                              .validate()&&context.read<CourseMainCubit>().validateDateTimeQuiz() &&
                          context
                                  .read<CourseMainCubit>()
                                  .isSuccessSelectDateTime ==
                              true) {
                              context.read<CourseMainCubit>().emitEditQuiz(context);
                              context.pop();
                      }
                    },
                    buttonText: 'Edit Quiz',
                    buttonWidth: 147,
                  ),
                ),
                horizontalSpace(16),
                Expanded(
                  child: AppTextButton(
                    onPressed: () {
                      context.read<CourseMainCubit>().quizTitleTextEditionController = TextEditingController();
                      context.read<CourseMainCubit>().quizTimeLiftTextEditionController = TextEditingController();
                      context.read<CourseMainCubit>().quizQuizScoreTextEditionController = TextEditingController();
                      context.read<CourseMainCubit>().quizDescriptionTextEditionController = TextEditingController();
                      context.read<CourseMainCubit>().selectedStartDateQuiz = null;
                      context.read<CourseMainCubit>().selectedEndDateQuiz = null;
                      context.read<CourseMainCubit>().startDateTimeQuiz = null;
                      context.read<CourseMainCubit>().endDateTimeQuiz = null;
                      context.read<CourseMainCubit>().errorMessageQuiz = null;
                      context.pop();
                    },
                    buttonText: 'Cancel',
                    buttonWidth: 147,
                    backgroundColor: Colors.white,
                    textStyle: TextStyles.font14Black600Weight,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
