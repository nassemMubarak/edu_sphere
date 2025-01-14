import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/routing/routes.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/widgets/image_and_text_empty_data.dart';
import 'package:edu_sphere/features/student/assessment_student/presesntations/bloc/student_assessment_cubit.dart';
import 'package:edu_sphere/features/teacher/assessments/presentation/bloc/assessments_cubit.dart';
import 'package:edu_sphere/features/teacher/assessments/presentation/widgets/assessment_widget/add_assessment_dialog.dart';
import 'package:edu_sphere/core/widgets/shimmer_loading_assessment_widget.dart';
import 'package:edu_sphere/features/teacher/teacher_main/presentation/widgets/section_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class StudentAssessmentWidget extends StatelessWidget {
  int idCourse;
  StudentAssessmentWidget({super.key,required this.idCourse});

  @override
  Widget build(BuildContext context) {
    context.read<StudentAssessmentCubit>().emitGetAllAssessment(idCourse: idCourse);
    return BlocBuilder<StudentAssessmentCubit,StudentAssessmentState>(
      buildWhen: (previous, current) =>current is GetAllStudentAssessmentLoadedState ,
      builder: (context, state) {
        if(state is GetAllStudentAssessmentLoadingState ){
          return ShimmerLoadingAssessmentWidget();
        }
        if(state is GetAllStudentAssessmentLoadedState){
          if(state.listAssessment.isNotEmpty){
            return SectionCard(
              title: 'Assessments',
              icon: 'assets/svgs/annual_assessment_icon.svg',
              widget: ListView.builder(
                itemCount: state.listAssessment.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => ListTile(
                  onTap: (){
                    context.read<StudentAssessmentCubit>().emitShowAssessment(idCourse: idCourse,idAssessment: state.listAssessment[index].id);
                    context.read<StudentAssessmentCubit>().indexAssessmentSelected = index;
                    context.pushNamed(Routes.studentAssessmentPage);
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
              widget: ImageAndTextEmptyData(
                message: 'You have not added any assessment yet.',
              ),
            );
          }
        }else{
          if(context.read<StudentAssessmentCubit>().listAssessment.isNotEmpty){
            return SectionCard(
              title: 'Assessments',
              icon: 'assets/svgs/annual_assessment_icon.svg',
              widget: ListView.builder(
                itemCount: context.read<StudentAssessmentCubit>().listAssessment.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => ListTile(
                  onTap: (){
                    context.read<StudentAssessmentCubit>().emitShowAssessment(idCourse: idCourse,idAssessment: context.read<StudentAssessmentCubit>().listAssessment[index].id);
                    context.read<StudentAssessmentCubit>().indexAssessmentSelected = index;
                    context.pushNamed(Routes.studentAssessmentPage);
                  },
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                  leading: SvgPicture.asset('assets/svgs/pdf_icon.svg'),
                  title: Text(context.read<StudentAssessmentCubit>().listAssessment[index].title,style: TextStyles.font14Black500Weight),
                ),
              ),
            );
          }else{
            return  SectionCard(
              title: 'Assessments',
              icon: 'assets/svgs/annual_assessment_icon.svg',
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
