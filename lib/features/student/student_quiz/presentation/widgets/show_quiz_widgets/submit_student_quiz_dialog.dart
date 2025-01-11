import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/util/toast_notification_message.dart';
import 'package:edu_sphere/features/student/student_quiz/presentation/bloc/student_quiz_cubit.dart';
import 'package:edu_sphere/features/teacher/quiz/domain/entities/quiz.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';

import '../../../../../../core/theming/styles.dart';
import '../../../../../../core/widgets/alert_dialog_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class SubmitStudentQuizDialog extends StatelessWidget {
  Map<int, String?> answerData;
  Quiz quiz;
   SubmitStudentQuizDialog({super.key,required this.answerData,required this.quiz });

  @override
  Widget build(BuildContext context) {
    return AlertDialogWidget(
      title: 'Finish Quiz',
      styleTitle: TextStyles.font16Red600Weight,
      textButton: 'Finish Quiz',
      widget: Column(
        children: [
          Text(
            'Do you really want to finish the quiz?',
            textAlign: TextAlign.center,
            style: TextStyles.font14Black400Weight,
          ),
          BlocConsumer<StudentQuizCubit, StudentQuizState>(
            listener: (context, state) {
              if(state is SubmitAnswerQuizLoadingState){
                return context.loading();
              }else if(state is SubmitAnswerQuizErrorState){
                ToastNotificationMessage().showToastNotificationError(
                    message: state.message, context: context);
                context.pop();
              }else if(state is SubmitAnswerQuizLoadedState){
                context.read<StudentQuizCubit>().emitIsShowStudentQuizUseCase(
                  idCourse: quiz.courseId,
                  idQuiz: quiz.id,
                );
                ToastNotificationMessage().showNotificationSuccess(
                    message: 'Successfully Submit Answer',
                    context: context);
                context.pop();
                context.pop();
                context.pop();
              }
            },
            builder: (context, state) =>  SizedBox.shrink(),
          )
        ],
      ),
      onTapButton: () {
        // Logic for final quiz submission can go here
        Logger().f('Quiz answers: $answerData');
        context.read<StudentQuizCubit>().emitSubmitAnswerQuizUseCaseUseCase(data: answerData);
        // context.pop(); // Close the dialog
      },
    );
  }
}
