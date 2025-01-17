import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/widgets/app_text_button.dart';
import 'package:edu_sphere/core/widgets/bread_crumb_widget.dart';
import 'package:edu_sphere/core/widgets/full_screen_image_widget.dart';
import 'package:edu_sphere/core/widgets/sliver_widget.dart';
import 'package:edu_sphere/features/student/student_main/presentations/bloc/subscribe_student_courses/subscribe_student_courses_cubit.dart';
import 'package:edu_sphere/features/student/student_quiz/presentation/bloc/student_quiz_cubit.dart';
import 'package:edu_sphere/features/student/student_quiz/presentation/widgets/review_quiz_widget/build_shimmer_review_quiz_widget.dart';
import 'package:edu_sphere/features/student/student_quiz/presentation/widgets/review_quiz_widget/review_quiz_summary_widget.dart';
import 'package:edu_sphere/features/student/student_quiz/presentation/widgets/review_quiz_widget/show_question_to_review_student_quiz.dart';
import 'package:edu_sphere/features/teacher/teacher_main/presentation/widgets/section_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class ReviewStudentQuizPage extends StatelessWidget {

  const ReviewStudentQuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    var coursesModel = context
        .read<SubscribeStudentCoursesCubit>()
        .courseSelected;
    var quiz = context.read<StudentQuizCubit>().quizSelected!;
    context.read<StudentQuizCubit>().emitGetAttemptStudentQuizUseCase(
      idCourse: quiz.courseId,
      idQuiz: quiz.id,
    );
    var quizEstimate = context.read<StudentQuizCubit>().estimateStudentQuiz!;
    return SliverWidget(
        leading: IconButton(onPressed: (){
          context.pop();
        }, icon: Icon(Icons.arrow_back_ios)),
        widget: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              BreadCrumbWidget(
                items: ['Home', coursesModel!.title, quiz.title],
              ),
              verticalSpace(24),
              // ShowStudentQuizWidget(),
              BlocConsumer<StudentQuizCubit, StudentQuizState>(
                buildWhen: (previous, current) => current is ReviewStudentQuizLoadedState,
                listener: (context, state) {

                },
                builder: (context, state) {
                  if(state is ReviewStudentQuizLoadingState){
                   return BuildShimmerReviewQuizWidget();
                  }else if(state is ReviewStudentQuizLoadedState){
                    DateTime createdDateTime = DateTime.parse(state.reviewQuiz.createdAt);
                    DateTime updatedDateTime = DateTime.parse(state.reviewQuiz.updatedAt);
                    // Calculate the difference
                    Duration difference = updatedDateTime.difference(createdDateTime);
                    // Convert to minutes
                    int differenceInMinutes = difference.inMinutes;
                    int differenceInHours = difference.inHours;

                       return Column(
                         children: [
                           ReviewQuizSummaryWidget(createdDateTime: createdDateTime, updatedDateTime: updatedDateTime, difference: difference, differenceInMinutes: differenceInMinutes, differenceInHours: differenceInHours, quizMark: quiz.degree),
                           ListView.builder(
                             shrinkWrap: true,
                             physics: NeverScrollableScrollPhysics(),
                             itemBuilder: (context, index) {
                               return ShowquestiontoReviewstudentquiz(question: state.reviewQuiz.data[index], index: index);
                           },
                           itemCount: state.reviewQuiz.data.length,
                           ),
                           AppTextButton(buttonText: 'Back to quiz page',onPressed: (){
                             context.pop();
                           },),
                         ],
                       );
                  }
                  return  BuildShimmerReviewQuizWidget();
                },
              )
            ],
          ),
        ),

    );
  }
}
