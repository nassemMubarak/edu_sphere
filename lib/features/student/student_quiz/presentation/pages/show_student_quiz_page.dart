import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/util/toast_notification_message.dart';
import 'package:edu_sphere/core/widgets/bread_crumb_widget.dart';
import 'package:edu_sphere/core/widgets/shimmer_loading_chapter_widget.dart';
import 'package:edu_sphere/core/widgets/sliver_widget.dart';
import 'package:edu_sphere/features/student/student_quiz/presentation/bloc/student_quiz_cubit.dart';
import 'package:edu_sphere/features/student/student_quiz/presentation/widgets/show_quiz_widgets/shimmer_loading_show_student_quiz_widget.dart';
import 'package:edu_sphere/features/student/student_quiz/presentation/widgets/show_quiz_widgets/show_student_quiz_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../../student_main/presentations/bloc/subscribe_student_courses/subscribe_student_courses_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class ShowStudentQuizPage extends StatelessWidget {
  const ShowStudentQuizPage({super.key});

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
            listener: (context, state) {
              if(state is StudentQuizMessageErrorState){
                ToastNotificationMessage().showToastNotificationError(message: state.message, context: context);
              }
            },
            builder: (context, state) {
              if(state is GetAttemptStudentQuizLoadingState){
                return const ShimmerLoadingShowStudentQuizWidget();
              }else if(state is GetAttemptStudentQuizUseCaseLoadedState){
                return ShowStudentQuizWidget();
              }else{
                return ShowStudentQuizWidget();
                // return Text("Not Found");
              }
            },
          )
        ],
      ),
    ));
  }
}
