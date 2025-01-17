import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/routing/routes.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/widgets/image_and_text_empty_data.dart';
import 'package:edu_sphere/features/teacher/quiz/domain/entities/quiz.dart';
import 'package:edu_sphere/features/teacher/quiz/presentation/bloc/quiz_cubit.dart';
import 'package:edu_sphere/features/teacher/quiz/presentation/widgets/estimate_widget/shimmer_loading_estimate_quiz_widget.dart';
import 'package:edu_sphere/features/teacher/quiz/presentation/widgets/estimate_widget/show_estimate_person_widget.dart';
import 'package:edu_sphere/features/teacher/quiz/presentation/widgets/estimate_widget/show_or_hid_estimate_info_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:edu_sphere/features/teacher/teacher_main/presentation/widgets/section_card.dart';


class EstimateQuizWidget extends StatelessWidget {
  Quiz quiz;
   EstimateQuizWidget({super.key,required this.quiz});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizCubit, QuizState>(
      builder: (context, state) {
        if(state is GetAllEstimateQuizLoadingState){
         return ShimmerLoadingEstimateQuizWidget();
        }
        if (state is GetAllEstimateQuizLoadedState) {
          return state.listEstimateQuiz.isNotEmpty? Container(
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
                    'Quiz Grade',
                    style: TextStyles.font14Black500Weight,
                  ),
                  trailing: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) =>
                            ShowOrHidEstimateInfoDialog(isHide: quiz.resultVisible==0?true:false,quiz: quiz,),
                      );
                    },
                    // child: Icon(quiz.isHideQuiz?Icons.visibility_off_outlined:Icons.visibility_outlined,
                    child: Icon(
                        quiz.resultVisible==0?Icons.visibility_off_outlined:
                        Icons.visibility_outlined,
                        color: Colors.black,),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: state.listEstimateQuiz.length,
                  itemBuilder: (context, index) {
                  return ShowEstimatePersonWidget(
                    indexEstimateQuiz: index,
                      quize:quiz ,
                      estimateQuiz: state.listEstimateQuiz[index],
                      name: state.listEstimateQuiz[index].student.name,
                      grad: '${state.listEstimateQuiz[index].grade.result}/${quiz.degree}',
                      email: state.listEstimateQuiz[index].student.email,
                      onTapListTail: () {
                      context.read<QuizCubit>().selectedEstimateQuiz = index;
                        context.pushNamed(Routes.showReviewQuizPage);
                      });
                },)
              ],
            ),
          ): SectionCard(
            title: 'Quiz Grade',
            icon: 'assets/svgs/assessment_estimates_icon.svg',
            widget: ImageAndTextEmptyData(
              message: 'No quizzes have been submitted yet.',
            ),
          );
        } else if(state is QuizeSelected){
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
                    'Quiz Grade',
                    style: TextStyles.font14Black500Weight,
                  ),
                  trailing: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => ShowOrHidEstimateInfoDialog(
                            isHide:
                            state.quiz.resultVisible==0?true:false,quiz: state.quiz,),
                      );
                    },
                    // child: Icon(quiz.isHideQuiz?Icons.visibility_off_outlined:Icons.visibility_outlined,
                    child: Icon(
                        state.quiz.resultVisible==0?
                            Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: Colors.black),
                  ),
                ),
                // verticalSpace(24),
                ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: context.read<QuizCubit>().listEstimateQuiz.length,
                  itemBuilder: (context, index) {
                    return ShowEstimatePersonWidget(
                        indexEstimateQuiz: index,
                        quize:quiz ,
                        estimateQuiz: context.read<QuizCubit>().listEstimateQuiz[index],
                        name: context.read<QuizCubit>().listEstimateQuiz[index].student.name,
                        grad: '${context.read<QuizCubit>().listEstimateQuiz[index].grade.result}/10',
                        email: context.read<QuizCubit>().listEstimateQuiz[index].student.email,
                        onTapListTail: () {
                          context.read<QuizCubit>().selectedEstimateQuiz = index;
                          context.pushNamed(Routes.showReviewQuizPage);
                        });
                  },)
              ],
            ),
          );
        }else{
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
                    'Quiz Grade',
                    style: TextStyles.font14Black500Weight,
                  ),
                  trailing: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => ShowOrHidEstimateInfoDialog(
                          isHide:
                          quiz.resultVisible==0?true:false,quiz: quiz,),
                      );
                    },
                    // child: Icon(quiz.isHideQuiz?Icons.visibility_off_outlined:Icons.visibility_outlined,
                    child: Icon(
                        quiz.resultVisible==0?
                        Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: Colors.black),
                  ),
                ),
                // verticalSpace(24),
                ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: context.read<QuizCubit>().listEstimateQuiz.length,
                  itemBuilder: (context, index) {
                    return ShowEstimatePersonWidget(
                        indexEstimateQuiz: index,
                        quize:quiz ,
                        estimateQuiz: context.read<QuizCubit>().listEstimateQuiz[index],
                        name: context.read<QuizCubit>().listEstimateQuiz[index].student.name,
                        grad: '${context.read<QuizCubit>().listEstimateQuiz[index].grade.result}/10',
                        email: context.read<QuizCubit>().listEstimateQuiz[index].student.email,
                        onTapListTail: () {
                          context.read<QuizCubit>().selectedEstimateQuiz = index;
                          context.pushNamed(Routes.showReviewQuizPage);
                        });
                  },)
              ],
            ),
          );
        }
      },
    );
  }
}
