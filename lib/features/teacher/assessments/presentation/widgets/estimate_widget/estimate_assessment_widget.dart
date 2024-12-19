import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/routing/routes.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/features/teacher/assessments/presentation/bloc/assessments_cubit.dart';
import 'package:edu_sphere/features/teacher/assessments/presentation/widgets/estimate_widget/show_or_hid_estimate_assessment_info_dialog.dart';
import 'package:edu_sphere/features/teacher/quiz/presentation/bloc/quiz_cubit.dart';
import 'package:edu_sphere/features/teacher/quiz/presentation/widgets/estimate_widget/edit_quiz_evaluation_dialog.dart';
import 'package:edu_sphere/features/teacher/quiz/presentation/widgets/estimate_widget/show_estimate_person_widget.dart';
import 'package:edu_sphere/features/teacher/quiz/presentation/widgets/estimate_widget/show_or_hid_estimate_info_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class EstimateAssessmentWidget extends StatelessWidget {
  const EstimateAssessmentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AssessmentsCubit, AssessmentsState>(
      builder: (context, state) {
        Logger().d(state is IsHideEstimationAssessment);
        if (state is IsHideEstimationAssessment) {
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
                    'Assessment Estimates',
                    style: TextStyles.font14Black500Weight,
                  ),
                  trailing: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) =>
                            ShowOrHidEstimateAssessmentInfoDialog(isHide: state.isHide),
                      );
                    },
                    // child: Icon(quiz.isHideQuiz?Icons.visibility_off_outlined:Icons.visibility_outlined,
                    child: Icon(
                        state.isHide
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: Colors.black),
                  ),
                ),
                verticalSpace(24),
                ShowEstimatePersonWidget(
                    name: 'Nassem Ah Mubarak',
                    grad: '10/10',
                    onTapListTail: () {
                      context.pushNamed(Routes.showReviewAssessmentPage);
                    }),
                ShowEstimatePersonWidget(
                    name: 'Wessam Ah Mubarak',
                    grad: '8/10',
                    onTapListTail: () {
                      context.pushNamed(Routes.showReviewAssessmentPage);
                    }),
                ShowEstimatePersonWidget(
                    name: 'Fouad A Haboub',
                    grad: '5/10',
                    onTapListTail: () {
                      context.pushNamed(Routes.showReviewAssessmentPage);
                    }),
              ],
            ),
          );
        } else {
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
                    'Assessment Estimates',
                    style: TextStyles.font14Black500Weight,
                  ),
                  trailing: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => ShowOrHidEstimateAssessmentInfoDialog(
                            isHide:
                                !context.read<AssessmentsCubit>().isHideEstimationAssessment),
                      );
                    },
                    // child: Icon(quiz.isHideQuiz?Icons.visibility_off_outlined:Icons.visibility_outlined,
                    child: Icon(
                        context.read<AssessmentsCubit>().isHideEstimationAssessment
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: Colors.black),
                  ),
                ),
                verticalSpace(24),
                ShowEstimatePersonWidget(
                    name: 'Nassem Ah Mubarak',
                    grad: '10/10',
                    onTapListTail: () {
                      context.pushNamed(Routes.showReviewQuizPage);
                    }),
                ShowEstimatePersonWidget(
                    name: 'Wessam Ah Mubarak',
                    grad: '8/10',
                    onTapListTail: () {
                      context.pushNamed(Routes.showReviewQuizPage);
                    }),
                ShowEstimatePersonWidget(
                    name: 'Fouad A Haboub',
                    grad: '5/10',
                    onTapListTail: () {
                      context.pushNamed(Routes.showReviewQuizPage);
                    }),
              ],
            ),
          );
        }
      },
    );
  }
}
