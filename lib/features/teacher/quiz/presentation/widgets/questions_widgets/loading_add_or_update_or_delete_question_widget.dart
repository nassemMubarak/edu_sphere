import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/util/toast_notification_message.dart';
import 'package:edu_sphere/features/teacher/quiz/presentation/bloc/question/question_cubit.dart';
import 'package:edu_sphere/features/teacher/quiz/presentation/bloc/quiz_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class LoadingAddOrUpdateOrDeleteQuestionWidget extends StatelessWidget {
  String message;
  bool isDelete;
  LoadingAddOrUpdateOrDeleteQuestionWidget({super.key,required this.message,this.isDelete=false});

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<QuestionCubit, QuestionState>(
      builder: (context, state) => SizedBox.shrink(),
      listener: (context, state) {
        if (state is AddOrUpdateOrDeleteQuestionLoadingState) {
          context.loading();
        } else if (state is QuestionMessageErrorState) {
          ToastNotificationMessage().showToastNotificationError(
              message: state.message, context: context);
          context.pop();
        } else if (state is GetAllQuestionLoadedState) {
          ToastNotificationMessage().showNotificationSuccess(
              message: message,
              context: context);
          context.pop();
          context.pop();
          if(isDelete){
          context.pop();

          }
        }
      },
    );
  }
}
