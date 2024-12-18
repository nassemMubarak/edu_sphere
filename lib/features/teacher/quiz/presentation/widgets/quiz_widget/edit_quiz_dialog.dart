import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/widgets/app_text_button.dart';
import 'package:edu_sphere/core/widgets/app_text_form_field.dart';
import 'package:edu_sphere/core/widgets/label_and_widget.dart';
import 'package:edu_sphere/features/teacher/quiz/domain/entities/quiz.dart';
import 'package:edu_sphere/features/teacher/quiz/presentation/bloc/quiz_cubit.dart';
import 'package:edu_sphere/features/teacher/quiz/presentation/widgets/quiz_widget/date_quiz_widget.dart';
import 'package:edu_sphere/features/teacher/quiz/presentation/widgets/quiz_widget/time_quiz_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditQuizDialog extends StatelessWidget {
  Quiz quiz;
  EditQuizDialog({super.key,required this.quiz});

  @override
  Widget build(BuildContext context) {
    context.read<QuizCubit>().quizTitleTextEditionController = TextEditingController(text: quiz.quizTitle);
    context.read<QuizCubit>().quizTimeLiftTextEditionController = TextEditingController(text: quiz.timeLift.toString());
    context.read<QuizCubit>().quizQuizScoreTextEditionController = TextEditingController(text: quiz.passingScore.toString());
    context.read<QuizCubit>().quizDescriptionTextEditionController = TextEditingController(text: quiz.description);
    context.read<QuizCubit>().selectedStartDateQuiz = quiz.startDateTime;
    context.read<QuizCubit>().selectedEndDateQuiz = quiz.endDateTime;
    context.read<QuizCubit>().startDateTimeQuiz = quiz.startDateTime;
    context.read<QuizCubit>().endDateTimeQuiz = quiz.endDateTime;
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
              key: context.read<QuizCubit>().globalQuizKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  LabelAndWidget(
                    label: 'Edit Title',
                    widget: AppTextFormField(
                      controller: context
                          .read<QuizCubit>()
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
                          .read<QuizCubit>()
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
                          .read<QuizCubit>()
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
                          .read<QuizCubit>()
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

            BlocBuilder<QuizCubit,QuizState>(
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
                              .read<QuizCubit>()
                              .globalQuizKey
                              .currentState!
                              .validate()&&context.read<QuizCubit>().validateDateTimeQuiz() &&
                          context
                                  .read<QuizCubit>()
                                  .isSuccessSelectDateTime ==
                              true) {
                              context.read<QuizCubit>().emitEditQuiz(context);
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
                      context.read<QuizCubit>().quizTitleTextEditionController = TextEditingController();
                      context.read<QuizCubit>().quizTimeLiftTextEditionController = TextEditingController();
                      context.read<QuizCubit>().quizQuizScoreTextEditionController = TextEditingController();
                      context.read<QuizCubit>().quizDescriptionTextEditionController = TextEditingController();
                      context.read<QuizCubit>().selectedStartDateQuiz = null;
                      context.read<QuizCubit>().selectedEndDateQuiz = null;
                      context.read<QuizCubit>().startDateTimeQuiz = null;
                      context.read<QuizCubit>().endDateTimeQuiz = null;
                      context.read<QuizCubit>().errorMessageQuiz = null;
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
