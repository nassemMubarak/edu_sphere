import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/features/teacher/quiz/domain/entities/quiz.dart';
import 'package:edu_sphere/features/teacher/quiz/presentation/bloc/quiz_cubit.dart';
import 'package:edu_sphere/features/teacher/quiz/presentation/widgets/estimate_widget/show_estimate_person_widget.dart';
import 'package:edu_sphere/features/teacher/quiz/presentation/widgets/questions_widgets/show_question_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class ShowReviewQuizWidget extends StatelessWidget {
   ShowReviewQuizWidget({super.key});
    Quiz? quiz;

  @override
  Widget build(BuildContext context) {
    quiz = context.read<QuizCubit>().quiz!;
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
              ShowEstimatePersonWidget(
                  name: 'Nassem Ah Mubarak',
                  grad: '10/10',
                onTapListTail: (){},
                  ),
            ],
          ),
        ),
        quiz!.questions!=null?ListView.builder(
          itemCount: quiz!.questions!.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index){
            return Column(
              children: [
                ShowQuestionWidget(isHideEditAndDeleteIcon: false,question: quiz!.questions![index], index: index),
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
                      // Correct choice
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: SvgPicture.asset('assets/svgs/choice_icon.svg'),
                        title:Text('Student Choice',style: TextStyles.font14Black500Weight,),
                      ),
                      ListTile(
                        // contentPadding: EdgeInsets.zero,
                        titleAlignment: ListTileTitleAlignment.top,
                        leading: Container(
                          margin: EdgeInsets.only(top: 15.h),
                          height: 4.h,
                          width: 4.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2.r),
                              color: Colors.black
                          ),
                        ),
                        title:Text(quiz!.questions![index].options[0],style: TextStyles.font14Black400Weight,) ,
                      ),
                      // Question Score
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: SvgPicture.asset('assets/svgs/quiz_score_icon.svg'),
                        title:Text('Your Score',style: TextStyles.font14Black500Weight,),
                      ),
                      ListTile(
                        // contentPadding: EdgeInsets.zero,
                        titleAlignment: ListTileTitleAlignment.top,
                        leading: Container(
                          margin: EdgeInsets.only(top: 15.h),
                          height: 4.h,
                          width: 4.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2.r),
                              color: Colors.black
                          ),
                        ),
                        title:Text('1',style: TextStyles.font14Black400Weight,) ,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ):SizedBox.shrink()
      ],
    );
  }

}
