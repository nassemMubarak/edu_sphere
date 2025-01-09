import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/util/toast_notification_message.dart';
import 'package:edu_sphere/core/widgets/alert_dialog_widget.dart';
import 'package:edu_sphere/features/student/student_main/presentations/bloc/subscribe_student_courses/subscribe_student_courses_cubit.dart';
import 'package:edu_sphere/features/teacher/teacher_main/domain/entities/course.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class LeaveStudentCourseDialog extends StatelessWidget {
  Course course;
   LeaveStudentCourseDialog({super.key,required this.course});

  @override
  Widget build(BuildContext context) {
    return AlertDialogWidget(

        title: 'Warning message',
        styleTitle: TextStyles.font16Red600Weight,
        textButton: 'Leave Course', widget: Column(
      children: [
        BlocConsumer<SubscribeStudentCoursesCubit, SubscribeStudentCoursesState>(
          listener: (context, state) {
            if(state is LeaveStudentSubscribeCoursesLoadingState){
              context.loading();
            }else if(state is GetAllStudentSubscribeCoursesMessageErrorState){
              context.pop();
              ToastNotificationMessage().showToastNotificationError(message: state.message, context: context);
            }
            else if(state is GetAllStudentSubscribeCoursesLoadedState){
              context.pop();
              context.pop();
              ToastNotificationMessage().showNotificationSuccess(message: 'Leave Course Success', context: context);

            }
          },
          builder: (context, state) {
            return SizedBox.shrink();
          },
        ),
        Text('Do you really want to delete Course ?',textAlign: TextAlign.center,style: TextStyles.font14Black500Weight),
        verticalSpace(16),
        Text('This action will leave the request you sent to the teacher',textAlign: TextAlign.center,style: TextStyles.font14Black400Weight),
      ],
    ), onTapButton: (){
      context.read<SubscribeStudentCoursesCubit>().emitLeaveSubscribeStudentCourses(course: course);
    });
  }
}
