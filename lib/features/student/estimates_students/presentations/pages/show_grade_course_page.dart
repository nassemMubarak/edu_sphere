import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/widgets/courses_shimmer_widget.dart';
import 'package:edu_sphere/core/widgets/image_and_text_empty_data.dart';
import 'package:edu_sphere/core/widgets/sliver_widget.dart';
import 'package:edu_sphere/features/student/estimates_students/presentations/bloc/estimate_student_cubit.dart';
import 'package:edu_sphere/features/teacher/teacher_main/presentation/widgets/section_card.dart';
import 'package:edu_sphere/l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';

class ShowGradeCoursePage extends StatelessWidget {
  const ShowGradeCoursePage({super.key});

  @override
  Widget build(BuildContext context) {

    context.read<EstimateStudentCubit>().emitShowEstimateStudentToCourse(idCourse: 35);
    return SliverWidget(
        leading: IconButton(onPressed: (){
          context.pop();
        }, icon: Icon(Icons.arrow_back),),
        widget: Padding(
          padding: EdgeInsets.only(top: 10.h, left: 16.w, right: 16.w),
          child: BlocBuilder<EstimateStudentCubit,EstimateStudentState>(builder: (context, state) {
            if(state is ShowEstimateStudentLoadingState){
              return const CoursesShimmerWidget();
            }else if(state is ShowEstimateStudentLoadedState){
              return SectionCard(
                title: 'Estimates',
                icon: 'assets/svgs/assessment_estimates_icon.svg',
                widget: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: state.estimatesStudent.quizAttempts.length,
                      itemBuilder: (context, index) {
                              return ListTile(
                                leading: SvgPicture.asset('assets/svgs/quiz_leading_icon.svg'),
                                title: Text('Quiz $index'),
                                trailing: Text(state.estimatesStudent.quizAttempts[index].grade==null?'NotRated':state.estimatesStudent.quizAttempts[index].grade!.result.toString(),style: TextStyles.font10NeutralGray400Weight),
                              );
                    },),
                    ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: state.estimatesStudent.assignments.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: SvgPicture.asset('assets/svgs/annual_assessment_icon.svg'),
                          title: Text(state.estimatesStudent.assignments[index].title??'Assessment $index'),
                          trailing: Text(state.estimatesStudent.assignments[index].grade==null?'NotRated':state.estimatesStudent.assignments[index].grade!.result.toString(),style: TextStyles.font10NeutralGray400Weight),
                        );
                      },),
                    verticalSpace(24),
                    Divider(),
                    verticalSpace(24),
                    Row(
                      children: [
                        Text('Total mark'),
                        Spacer(),
                        Text('Not Rated',style: TextStyles.font10NeutralGray400Weight),
                      ],
                    ),
                  ],
                ),
              );
            }else if(state is ShowEstimateStudentErrorState){
return SizedBox.shrink();
            }else if(context.read<EstimateStudentCubit>().estimatesStudent!=null){
              return SizedBox.shrink();
            }else{
             return SectionCard(
                    title: 'Estimates',
                    icon: 'assets/svgs/assessment_estimates_icon.svg',
                    widget: ImageAndTextEmptyData(
                        message: AppLocalizations.of(context)!.noCoursesAdded),
                  );
            }
          },),
          // child: SectionCard(
          //   title: 'Estimates',
          //   icon: 'assets/svgs/assessment_estimates_icon.svg',
          //   widget: ImageAndTextEmptyData(
          //       message: AppLocalizations.of(context)!.noCoursesAdded),
          // ),
        ),);
  }
}
