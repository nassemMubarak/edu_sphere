import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/util/toast_notification_message.dart';
import 'package:edu_sphere/features/student/assessment_student/presesntations/bloc/student_assessment_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class LoadingAddOrDeleteSubmitAssessmentWidget extends StatelessWidget {
  String message;
  bool isDelete;
  LoadingAddOrDeleteSubmitAssessmentWidget({super.key,required this.message,this.isDelete=false});

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<StudentAssessmentCubit, StudentAssessmentState>(
      builder: (context, state) => SizedBox.shrink(),
      listener: (context, state) {
        if (state is AddOrDeleteDocumentSubmitAssessmentLoadingState) {
          context.loading();
        } else if (state is ErrorMessageGetDocumentSubmitAssessmentState) {
          ToastNotificationMessage().showToastNotificationError(
              message: state.message, context: context);
              context.pop();
              context.pop();
        } else if (state is GetDocumentSubmitAssessmentLoadedState) {
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
