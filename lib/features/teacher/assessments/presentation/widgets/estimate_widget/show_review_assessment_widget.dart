import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/features/teacher/assessments/domain/entities/assessment.dart';
import 'package:edu_sphere/features/teacher/assessments/presentation/bloc/assessments_cubit.dart';
import 'package:edu_sphere/features/teacher/assessments/presentation/widgets/estimate_widget/show_estimate_person_assessment_widget.dart';
import 'package:edu_sphere/features/teacher/quiz/domain/entities/quiz.dart';
import 'package:edu_sphere/features/teacher/quiz/presentation/bloc/quiz_cubit.dart';
import 'package:edu_sphere/features/teacher/quiz/presentation/widgets/estimate_widget/show_estimate_person_widget.dart';
import 'package:edu_sphere/features/teacher/quiz/presentation/widgets/questions_widgets/show_question_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../domain/entities/assessment1.dart';
import '../../../domain/entities/estimate_assessment.dart';
class ShowReviewAssessmentWidget extends StatelessWidget {
  EstimateAssessment estimateAssessmentSelected;
  int idCourse;
  ShowReviewAssessmentWidget({super.key,required this.estimateAssessmentSelected,required this.idCourse});
    Assessment? assessment;
    int? indexEstimateAssessmentSelected;

  @override
  Widget build(BuildContext context) {
    indexEstimateAssessmentSelected = context
        .read<AssessmentsCubit>().indexEstimateAssessmentSelected;
    assessment = context.read<AssessmentsCubit>().assessment!;
    return Column(
      children: [
        Container(
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
              // ShowEstimatePersonWidget(
              //     name: 'Nassem Ah Mubarak',
              //     grad: '10/10',
              //   email: '',
              //   onTapListTail: (){},
              //     ),
              verticalSpace(18),
    ShowEstimatePersonAssessmentWidget(estimateAssessment: estimateAssessmentSelected,idCourse:idCourse ,grade:assessment!.degree ,idAssessment:assessment!.id ,indexEstimateAssessment: indexEstimateAssessmentSelected!,
    onTapListTail: (){

    },
    ),
              ListTile(
                onTap: (){},
                leading: SvgPicture.asset('assets/svgs/pdf_icon.svg',width: 20,),
                title: Text(estimateAssessmentSelected.assignmentAssessment.first.title??'solution of Assessment',style: TextStyles.font10Black400Weight,),
              ),
            ],
          ),
        ),

      ],
    );
  }

}
