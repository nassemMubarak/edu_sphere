import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/util/toast_notification_message.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/bloc/course_lecture/course_lecture_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddOrUpdateOrDeleteLectureLoading extends StatelessWidget {
  String message;
   AddOrUpdateOrDeleteLectureLoading({super.key,required this.message});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CourseLectureCubit, CourseLectureState>(
      builder: (context, state) {
        return SizedBox.shrink();
      },
      listener: (context, state) {
        if (state is AddOrUpdateOrDeleteLectureLoadingState) {
          context.loading();
        } else if (state is LectureMessageErrorState) {
          ToastNotificationMessage().showToastNotificationError(
              message: state.message, context: context);
          context.pop();
        } else if (state is GetAllLectureLoadedState) {
          ToastNotificationMessage().showNotificationSuccess(
              message: message,
              context: context);
          context.pop();
          context.pop();
        }
      },
    );
  }
}
