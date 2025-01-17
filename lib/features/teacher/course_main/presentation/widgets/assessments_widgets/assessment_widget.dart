import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/routing/routes.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/widgets/image_and_text_empty_data.dart';
import 'package:edu_sphere/features/teacher/assessments/presentation/bloc/assessments_cubit.dart';
import 'package:edu_sphere/features/teacher/assessments/presentation/widgets/assessment_widget/add_assessment_dialog.dart';
import 'package:edu_sphere/core/widgets/shimmer_loading_assessment_widget.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/widgets/section_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class AssessmentWidget extends StatelessWidget {
  int idCourse;
   AssessmentWidget({super.key,required this.idCourse});

  @override
  Widget build(BuildContext context) {
    context.read<AssessmentsCubit>().emitGetAllAssessment(idCourse: idCourse);
    return      BlocBuilder<AssessmentsCubit,AssessmentsState>(
      buildWhen: (previous, current) =>current is GetAllAssessmentLoadedState ,
      builder: (context, state) {
        if(state is GetAllAssessmentLoadingState ){
          return ShimmerLoadingAssessmentWidget();
        }
        if(state is GetAllAssessmentLoadedState){
          if(state.listAssessment.isNotEmpty){
            return SectionCard(
              title: 'Assessments',
              icon: 'assets/svgs/annual_assessment_icon.svg',
              infoDialog:  AddAssessmentDialog(idCourse: idCourse,),
              widget: ListView.builder(
                itemCount: state.listAssessment.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => ListTile(
                  onTap: (){
                    context.read<AssessmentsCubit>().emitSelectAssessments(assessment: state.listAssessment[index],indexAssessments: index);
                    context.read<AssessmentsCubit>().indexAssessmentSelected = index;
                    context.pushNamed(Routes.assessmentsPage);
                  },
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                  leading: SvgPicture.asset('assets/svgs/pdf_icon.svg'),
                  title: Text(state.listAssessment[index].title,style: TextStyles.font14Black500Weight),
                ),
              ),
            );
          }else{
            return  SectionCard(
              title: 'Assessments',
              icon: 'assets/svgs/annual_assessment_icon.svg',
              infoDialog:  AddAssessmentDialog(idCourse: idCourse,),
              widget: ImageAndTextEmptyData(
                message: 'You have not added any assessment yet.',
              ),
            );
          }
        }else{
          if(context.read<AssessmentsCubit>().listAssessment.isNotEmpty){
            return SectionCard(
              title: 'Assessments',
              icon: 'assets/svgs/annual_assessment_icon.svg',
              infoDialog:  AddAssessmentDialog(idCourse: idCourse),
              widget: ListView.builder(
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
              ),
            );
          }else{
            return  SectionCard(
              title: 'Assessments',
              icon: 'assets/svgs/annual_assessment_icon.svg',
              infoDialog:  AddAssessmentDialog(idCourse: idCourse),
              widget: ImageAndTextEmptyData(
                message: 'You have not added any assessment yet.',
              ),
            );
          }
        }
      },
    );
  }
}
