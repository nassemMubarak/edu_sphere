import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/util/toast_notification_message.dart';
import 'package:edu_sphere/features/teacher/quiz/presentation/bloc/quiz_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class LoadingAddOrUpdateOrDeleteQuizWidget extends StatelessWidget {
  String message;
  bool isDelete;
   LoadingAddOrUpdateOrDeleteQuizWidget({super.key,required this.message,this.isDelete=false});

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<QuizCubit, QuizState>(
      builder: (context, state) => SizedBox.shrink(),
      listener: (context, state) {
        if (state is AddOrUpdateOrDeleteLoadingState) {
          context.loading();
        } else if (state is QuizMessageErrorState) {
          ToastNotificationMessage().showToastNotificationError(
              message: state.message, context: context);
          context.pop();
        } else if (state is GetAllQuizLoadedState) {
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
