import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/routing/routes.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/widgets/image_and_text_empty_data.dart';
import 'package:edu_sphere/features/teacher/assessments/presentation/bloc/assessments_cubit.dart';
import 'package:edu_sphere/features/teacher/assessments/presentation/widgets/assessment_widget/add_assessment_dialog.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/widgets/section_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class AssessmentWidget extends StatelessWidget {
  const AssessmentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: 'Assessments',
      icon: 'assets/svgs/annual_assessment_icon.svg',
      infoDialog: const AddAssessmentDialog(),
      widget: BlocBuilder<AssessmentsCubit,AssessmentsState>(
        builder: (context, state) {
          if(state is GetAllAssessment){
            if(state.assessment.isNotEmpty){
              return ListView.builder(
                itemCount: state.assessment.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => ListTile(
                  onTap: (){
                    context.read<AssessmentsCubit>().emitSelectAssessments(assessment: state.assessment[index],indexAssessments: index);
                    context.read<AssessmentsCubit>().indexAssessmentSelected = index;
                    context.pushNamed(Routes.assessmentsPage);
                  },
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                  leading: SvgPicture.asset('assets/svgs/pdf_icon.svg'),
                  title: Text(state.assessment[index].title,style: TextStyles.font14Black500Weight),
                ),
              );
            }else{
             return  ImageAndTextEmptyData(
                message: 'You have not added any assessment yet.',
              );
            }
          }else{
            if(context.read<AssessmentsCubit>().listAssessment.isNotEmpty){
              return ListView.builder(
                itemCount: context.read<AssessmentsCubit>().listAssessment.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => ListTile(
                  onTap: (){
                    context.read<AssessmentsCubit>().emitSelectAssessments(assessment: context.read<AssessmentsCubit>().listAssessment[index],indexAssessments: index);
                    context.read<AssessmentsCubit>().indexAssessmentSelected = index;
                    context.pushNamed(Routes.assessmentsPage);
                  },
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                  leading: SvgPicture.asset('assets/svgs/pdf_icon.svg'),
                  title: Text(context.read<AssessmentsCubit>().listAssessment[index].title,style: TextStyles.font14Black500Weight),
                ),
              );
            }else{
              return  ImageAndTextEmptyData(
                message: 'You have not added any assessment yet.',
              );
            }
          }
        },
      )
    );
  }
}
