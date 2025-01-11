import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/util/toast_notification_message.dart';
import 'package:edu_sphere/core/widgets/alert_dialog_widget.dart';
import 'package:edu_sphere/core/widgets/app_text_button.dart';
import 'package:edu_sphere/features/student/student_quiz/presentation/widgets/show_quiz_widgets/submit_student_quiz_dialog.dart';
import 'package:edu_sphere/features/teacher/quiz/domain/entities/quiz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/features/student/student_quiz/presentation/bloc/student_quiz_cubit.dart';
import 'package:edu_sphere/features/student/student_quiz/presentation/widgets/show_quiz_widgets/show_question_to_student_quiz.dart';
import 'package:logger/logger.dart';
import 'package:slide_countdown/slide_countdown.dart';

class ShowStudentQuizWidget extends StatelessWidget {
  const ShowStudentQuizWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Quiz quiz = context.read<StudentQuizCubit>().quizSelected!;
    return Column(
      children: [
        BlocBuilder<StudentQuizCubit, StudentQuizState>(
          builder: (context, state) {
            final listQuestions = state is SelectStudentChoiceQuestionToQuiz
                ? state.listQuestionStudentQuiz
                : state is GetAttemptStudentQuizUseCaseLoadedState
                    ? state.listQuestionStudentQuiz
                    : context.read<StudentQuizCubit>().listQuestionStudentQuiz;

            return Column(
              children: [
                _buildQuizList(context, listQuestions),
                _buildPaginationControls(context, listQuestions,quiz),
                verticalSpace(24),
                // _buildBottomSection(listQuestions, int.parse('50')),
                _buildBottomSection(listQuestions, int.parse(quiz.time)),
              ],
            );
          },
        ),
      ],
    );
  }

  /// Builds the paginated list of questions
  Widget _buildQuizList(BuildContext context, List<dynamic> questions) {
    return BlocBuilder<StudentQuizCubit, StudentQuizState>(
      builder: (context, state) {
        final currentPage = state is ChangCurrentPageQuestionState
            ? state.currentPage
            : context.read<StudentQuizCubit>().currentPage;

        final start = currentPage * 3;
        final end = (start + 3).clamp(0, questions.length);
        final paginatedQuestions = questions.sublist(start, end);

        return ListView.builder(
          itemCount: paginatedQuestions.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final questionIndex = start + index;
            return ShowQuestionToStudentQuiz(
              question: paginatedQuestions[index],
              indexQuestion: questionIndex,
            );
          },
        );
      },
    );
  }

  /// Builds pagination controls
  Widget _buildPaginationControls(
      BuildContext context, List<dynamic> questions,Quiz quiz) {
    final totalPages = (questions.length / 3).ceil();

    return BlocBuilder<StudentQuizCubit, StudentQuizState>(
      builder: (context, state) {
        final currentPage = state is ChangCurrentPageQuestionState
            ? state.currentPage
            : context.read<StudentQuizCubit>().currentPage;

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: currentPage != 0,
              child: SizedBox(
                width: 150.w,
                child: AppTextButton(
                  textStyle: TextStyles.font14Black400Weight,
                  backgroundColor: Colors.white,
                  onPressed: currentPage > 0
                      ? () => context
                          .read<StudentQuizCubit>()
                          .emitChangeCurrentPage(currentPage - 1)
                      : null,
                  buttonText: 'Previous page',
                ),
              ),
            ),

            horizontalSpace(16),
            SizedBox(
              width: 150.w,
              child: AppTextButton(
                textStyle: TextStyles.font14White400Weight,
                onPressed: currentPage < totalPages - 1
                    ? () => context
                        .read<StudentQuizCubit>()
                        .emitChangeCurrentPage(currentPage + 1)
                    : ()=>submitQuiz(context,quiz),
                buttonText: currentPage >= totalPages - 1
                    ? 'Finish quiz'
                    : 'Next page',
              ),
            ),
          ],
        );
      },
    );
  }

  /// Builds the bottom section with avatar and button grid
  Widget _buildBottomSection(List<dynamic> questions, int timeQuiz) {
    return Container(
      width: double.infinity,
      margin: EdgeInsetsDirectional.only(bottom: 25.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            spreadRadius: 2,
            blurRadius: 4,
            color: ColorsManager.shadowColor.withOpacity(0.3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildAvatar(),
            verticalSpace(24),
            _buildButtonGrid(questions, timeQuiz),
          ],
        ),
      ),
    );
  }

  /// Builds the circular avatar with icon
  Widget _buildAvatar() {
    return Container(
      height: 150.h,
      width: 150.w,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: ColorsManager.nearNeutral,
      ),
      child: Icon(
        Icons.person,
        size: 100,
        color: ColorsManager.darkGray,
      ),
    );
  }

  Widget _buildButtonGrid(List<dynamic> questions, int timeQuiz,{Quiz? quiz}) {
    return BlocBuilder<StudentQuizCubit, StudentQuizState>(
      builder: (context, state) {
        final totalPages = (questions.length / 3).ceil();
        final currentPage = state is ChangCurrentPageQuestionState
            ? state.currentPage
            : context.read<StudentQuizCubit>().currentPage;

        final start = currentPage * 3;
        final end = (start + 3).clamp(0, questions.length);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 10,
              runSpacing: 10,
              children: List.generate(questions.length, (index) {
                final isSelected = questions[index].isSelectedOption != null;
                // Set the background color based on the current page and index
                final backgroundColor = (index >= start && index < end)
                    ? Colors.blue // Blue if within the current page's range
                    : (isSelected ? ColorsManager.neutralGray : Colors.white);
                TextStyle styleText = (index >= start && index < end)
                    ? TextStyles
                        .font16White500Weight // Blue if within the current page's range
                    : (isSelected
                        ? TextStyles.font16White500Weight
                        : TextStyles.font16Black500Weight);
                return ElevatedButton(
                  onPressed: () {
                    context
                        .read<StudentQuizCubit>()
                        .emitChangeCurrentPage((index / 3).floor());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: backgroundColor,
                    foregroundColor: isSelected ? Colors.white : Colors.black,
                    side: const BorderSide(color: Colors.blue),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(50, 50),
                    maximumSize: const Size(50, 50),
                  ),
                  child: Text('${index + 1}', style: styleText),
                );
              }),
            ),
            verticalSpace(24),
            Row(
              children: [
                Text(
                  'Time left: ',
                  style: TextStyles.font16Black500Weight,
                ),
                horizontalSpace(5),
        SlideCountdownSeparated(
        decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        ),
        style: TextStyles.font12MainBlue500Weight,
        duration: Duration(minutes: timeQuiz), // Use the provided duration
        showZeroValue: true,
        shouldShowDays: (v) => Duration(minutes: 68).inDays > 0, // Only show days if there are any
        shouldShowHours: (v) => Duration(minutes: 68).inHours > 0, // Only show hours if there are any
          onDone: () {
            // Optional: Trigger an action when the countdown reaches zero
            print("Timer completed!");
          },
        ),
              ],
            ),

            verticalSpace(24),
            Text(
              'Finish & submit Quiz...',
              style: TextStyles.font16MainBlue400Weight,
            ),
          ],
        );
      },
    );
  }
  void submitQuiz(BuildContext context,Quiz quiz) {
    final quizCubit = context.read<StudentQuizCubit>();
    final questions = quizCubit.listQuestionStudentQuiz;
    final Map<int, String?> answerData = {}; // Map to store question ID and selected option

    for (var question in questions) {
      final selectedOptionIndex = question.isSelectedOption;
      final selectedOption =
      selectedOptionIndex != null ? question.options[selectedOptionIndex] : null;

      Logger().f('${question.id} -----> ${selectedOption ?? 'null'}');

      if (selectedOption == null) {
        showDialog(
          context: context,
          builder: (context) => AlertDialogWidget(
            title: 'Unanswered Question',
            styleTitle: TextStyles.font14Red500Weight,
            textButton: 'Go to Question',
            widget: Text(
              'Question "${questions.indexOf(question)}" has not been answered. Please review it.',
              textAlign: TextAlign.center,
            ),
            onTapButton: () {
              final pageIndex = (questions.indexOf(question) / 3).floor();
              quizCubit.emitChangeCurrentPage(pageIndex);
              context.pop();
            },
          ),
        );
        return; // Exit the loop and prevent further submissions until resolved
      } else {
        // Add question ID and selected option to the map
        answerData[question.id] = selectedOption;
        Logger().f(answerData);
      }
    }

    // Show confirmation dialog for quiz submission
    showDialog(
      context: context,
      builder: (context) => SubmitStudentQuizDialog(answerData: answerData, quiz: quiz),
    );

    Logger().f('All questions have been answered. Proceeding with submission...');
  }
}
