import 'package:dartz/dartz_unsafe.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/features/teacher/quiz/domain/entities/estimate_quiz.dart';
import 'package:edu_sphere/features/teacher/quiz/domain/entities/question.dart';
import 'package:edu_sphere/features/teacher/quiz/domain/entities/quiz.dart';
import 'package:edu_sphere/features/teacher/quiz/presentation/bloc/question/question_cubit.dart';
import 'package:edu_sphere/features/teacher/quiz/presentation/bloc/quiz_cubit.dart';
import 'package:edu_sphere/features/teacher/quiz/presentation/widgets/estimate_widget/shimmer_loading_review_quiz_widget.dart';
import 'package:edu_sphere/features/teacher/quiz/presentation/widgets/estimate_widget/show_estimate_person_widget.dart';
import 'package:edu_sphere/features/teacher/quiz/presentation/widgets/questions_widgets/show_question_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';

class ShowReviewQuizWidget extends StatelessWidget {
  ShowReviewQuizWidget({super.key});

  Quiz? quiz;
  List<Question>? questions;
  EstimateQuiz? estimateQuiz;

  @override
  Widget build(BuildContext context) {
    quiz = context.read<QuizCubit>().quize!;
    questions = context.read<QuestionCubit>().listOfQuestion;
    estimateQuiz = context.read<QuizCubit>().listEstimateQuiz[context.read<QuizCubit>().selectedEstimateQuiz];

    Logger().t('idCourse: ${quiz!.courseId}, idQuiz: ${quiz!.id}, idEstimate: ${estimateQuiz!.id}');
    context.read<QuizCubit>().emitShowEstimateQuiz(
        idCourse: quiz!.courseId, idQuiz: quiz!.id, idEstimate: estimateQuiz!.id);

    return Column(
      children: [
        _buildHeader(context),
        BlocBuilder<QuizCubit, QuizState>(
          builder: (context, state) {
            if (state is ShowReviewQuizLoadingState) {
              return Container(
                  margin: EdgeInsets.only(top: 20),
                  child: ShimmerLoadingReviewQuizWidget());
            } else if (state is ShowReviewQuizLoadedState) {
              return _buildQuestionsList(state);
            } else {
              return SizedBox.shrink();
            }
          },
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
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
      child: Column(
        children: [
          ListTile(
            titleAlignment: ListTileTitleAlignment.center,
            contentPadding: EdgeInsetsDirectional.zero,
            leading: SvgPicture.asset(
              'assets/svgs/assessment_estimates_icon.svg',
              width: 24.w,
              height: 24.h,
              color: ColorsManager.mainBlue,
            ),
            title: Text(
              'Student Estimate',
              style: TextStyles.font14Black500Weight,
            ),
          ),
          ShowEstimatePersonWidget(
            estimateQuiz: estimateQuiz!,
            indexEstimateQuiz: context.read<QuizCubit>().selectedEstimateQuiz,
            email: estimateQuiz!.student.email,
            grad: '${estimateQuiz!.grade!.result}/${quiz!.degree}',
            name: estimateQuiz!.student.name,
            quize: quiz!,
            isHideUpdate: true,
            onTapListTail: () {
              Logger().e('Tapped on estimate details.');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionsList(ShowReviewQuizLoadedState state) {

    return ListView.builder(
      itemCount: questions!.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        String? answerStudent;
        int questionScore = 0;
        // state.reviewQuizModel.data.forEach((answer) {
        // Logger().e('--------------//////////////////////////////////////${answer.answer}');
        //   if (questions![index].id == int.parse(answer.questionId.toString())) {
        //     Logger().f('++++++++6666666666666---------------${answer.answer}');
        //     answerStudent = answer.answer;
        //     if (answer.answer == questions![index].correctAnswer) {
        //       questionScore = questions![index].mark;
        //     }
        //   }
        // });

        return Column(
          children: [
            ShowQuestionWidget(
              isHideEditAndDeleteIcon: false,
              idQuiz: quiz!.id,
              idCourse: quiz!.courseId,
              question: questions![index],
              index: index,
            ),
            Container(
              margin: EdgeInsetsDirectional.only(bottom: 20.h),
              padding: const EdgeInsets.all(16.0),
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
              child: Column(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: SvgPicture.asset('assets/svgs/choice_icon.svg'),
                    title: Text('Student Choice', style: TextStyles.font14Black500Weight),
                  ),
                  ListTile(
                    titleAlignment: ListTileTitleAlignment.top,
                    leading: Container(
                      margin: EdgeInsets.only(top: 15.h),
                      height: 4.h,
                      width: 4.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2.r),
                        color: Colors.black,
                      ),
                    ),
                    title: Text(state.reviewQuizModel.data[index].studentAnswer ?? '', style: TextStyles.font14Black400Weight),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: SvgPicture.asset('assets/svgs/quiz_score_icon.svg'),
                    title: Text('Your Score', style: TextStyles.font14Black500Weight),
                  ),
                  ListTile(
                    titleAlignment: ListTileTitleAlignment.top,
                    leading: Container(
                      margin: EdgeInsets.only(top: 15.h),
                      height: 4.h,
                      width: 4.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2.r),
                        color: Colors.black,
                      ),
                    ),
                    title: Text('${state.reviewQuizModel.data[index].isCorrect?state.reviewQuizModel.data[index].mark:0}', style: TextStyles.font14Black400Weight),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
