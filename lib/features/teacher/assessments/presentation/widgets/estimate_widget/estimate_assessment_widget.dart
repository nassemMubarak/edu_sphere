import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/routing/routes.dart';
import 'package:edu_sphere/core/widgets/image_and_text_empty_data.dart';
import 'package:edu_sphere/features/teacher/assessments/presentation/bloc/assessments_cubit.dart';
import 'package:edu_sphere/features/teacher/assessments/presentation/widgets/estimate_widget/shimmer_loading_estimate_assessment_widget.dart';
import 'package:edu_sphere/features/teacher/assessments/presentation/widgets/estimate_widget/show_estimate_person_assessment_widget.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/bloc/course_main_cubit.dart';
import 'package:flutter/material.dart';
import 'package:edu_sphere/features/teacher/teacher_main/presentation/widgets/section_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EstimateAssessmentWidget extends StatelessWidget {
  const EstimateAssessmentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var coursesModel = context
        .read<CourseMainCubit>()
        .coursesModel;
    var assessment = context
        .read<AssessmentsCubit>()
        .assessment;
    return BlocBuilder<AssessmentsCubit, AssessmentsState>(
      builder: (context, state) {
        if (state is GetAllEstimateAssessmentLoadingState) {
          return ShimmerLoadingEstimateAssessmentWidget();
        }
        if (state is GetAllEstimateAssessmentLoadedState) {
          return state.listEstimateAssessment.isNotEmpty?SectionCard(title: 'Assessment Estimates',
              icon: 'assets/svgs/assessment_estimates_icon.svg',
              widget:ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: state.listEstimateAssessment.length,
                itemBuilder: (context, index) {
                 return
                   ShowEstimatePersonAssessmentWidget(estimateAssessment: state.listEstimateAssessment[index],idCourse:coursesModel.id ,grade:assessment!.degree ,idAssessment:assessment.id ,indexEstimateAssessment: index,
                 onTapListTail: (){
                   if(state.listEstimateAssessment[index].assignmentAssessment.isNotEmpty){

                     context.pushNamed(Routes.showReviewAssessmentPage);
                   }
                   context
                       .read<AssessmentsCubit>()
                       .indexEstimateAssessmentSelected = index;
                   context
                       .read<AssessmentsCubit>()
                       .estimateAssessmentSelected = context.read<AssessmentsCubit>().listEstimateAssessment[index];

                 },
                 );
                },),
          ):SectionCard(
            title: 'Assessment Estimates',
            icon: 'assets/svgs/assessment_estimates_icon.svg',
            widget: ImageAndTextEmptyData(
              message: 'No assignment have been submitted yet.',
            ),
          );
        }else{
          return context.read<AssessmentsCubit>().listEstimateAssessment.isNotEmpty?SectionCard(title: 'Assessment Estimates',
            icon: 'assets/svgs/assessment_estimates_icon.svg',
            widget:ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: context.read<AssessmentsCubit>().listEstimateAssessment.length,
              itemBuilder: (context, index) {
                return  ShowEstimatePersonAssessmentWidget(estimateAssessment: context.read<AssessmentsCubit>().listEstimateAssessment[index],idCourse:coursesModel.id ,grade:assessment!.degree ,idAssessment:assessment.id ,indexEstimateAssessment: index,onTapListTail: (){
                  if(context.read<AssessmentsCubit>().listEstimateAssessment[index].assignmentAssessment.isNotEmpty){

                    context.pushNamed(Routes.showReviewAssessmentPage);
                  }
                  context
                      .read<AssessmentsCubit>()
                      .indexEstimateAssessmentSelected = index;
                  context
                      .read<AssessmentsCubit>()
                      .estimateAssessmentSelected = context.read<AssessmentsCubit>().listEstimateAssessment[index];
                },);
              },),
          ):SectionCard(
            title: 'Assessment Estimates',
            icon: 'assets/svgs/assessment_estimates_icon.svg',
            widget: ImageAndTextEmptyData(
              message: 'No assignment have been submitted yet.',
            ),
          );
        }
      },);
  }
}
/*
BlocBuilder<AssessmentsCubit, AssessmentsState>(
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
                ShowEstimatePersonAssessmentWidget(name: 'Nassem Ah Mubarak', grad: '10/10')
                // ShowEstimatePersonWidget(
                //     name: 'Nassem Ah Mubarak',
                //     grad: '10/10',
                //     email: '',
                //     onTapListTail: () {
                //       context.pushNamed(Routes.showReviewAssessmentPage);
                //     }),
                // ShowEstimatePersonWidget(
                //     name: 'Wessam Ah Mubarak',
                //     grad: '8/10',
                //     email: '',
                //     onTapListTail: () {
                //       context.pushNamed(Routes.showReviewAssessmentPage);
                //     }),
                // ShowEstimatePersonWidget(
                //     name: 'Fouad A Haboub',
                //     grad: '5/10',
                //     email: '',
                //     onTapListTail: () {
                //       context.pushNamed(Routes.showReviewAssessmentPage);
                //     }),
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
                // ShowEstimatePersonWidget(
                //     name: 'Nassem Ah Mubarak',
                //     grad: '10/10',
                //     email: '',
                //     onTapListTail: () {
                //       context.pushNamed(Routes.showReviewQuizPage);
                //     }),
                // ShowEstimatePersonWidget(
                //     name: 'Wessam Ah Mubarak',
                //     grad: '8/10',
                //     email: '',
                //     onTapListTail: () {
                //       context.pushNamed(Routes.showReviewQuizPage);
                //     }),
                // ShowEstimatePersonWidget(
                //     name: 'Fouad A Haboub',
                //     grad: '5/10',
                //     email: '',
                //     onTapListTail: () {
                //       context.pushNamed(Routes.showReviewQuizPage);
                //     }),
              ],
            ),
          );
        }
      },
    );
 */