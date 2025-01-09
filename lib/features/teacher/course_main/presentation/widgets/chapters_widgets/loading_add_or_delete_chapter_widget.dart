import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/util/toast_notification_message.dart';
import 'package:edu_sphere/features/teacher/assessments/presentation/bloc/assessments_cubit.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/bloc/document_course/document_course_cubit.dart';
import 'package:edu_sphere/features/teacher/quiz/presentation/bloc/quiz_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
class LoadingAddOrDeleteChapterWidget extends StatelessWidget {
  String message;
  LoadingAddOrDeleteChapterWidget({super.key,required this.message});

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<DocumentCourseCubit, DocumentCourseState>(
      builder: (context, state) => SizedBox.shrink(),
      listener: (context, state) {
        if (state is AddOrDeleteDocumentLoadingState) {
          context.loading();
        } else if (state is DocumentMessageErrorState) {
          ToastNotificationMessage().showToastNotificationError(
              message: state.message, context: context);
          context.pop();

        } else if (state is GetAllDocumentLoadedState) {
          ToastNotificationMessage().showNotificationSuccess(
              message: message,
              context: context,);
          context.pop();
          context.pop();
            Logger().e('--------------------1111--------------');

        }
      },
    );
  }
}
