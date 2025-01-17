import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/util/toast_notification_message.dart';
import 'package:edu_sphere/features/teacher/assessments/presentation/bloc/assessments_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class LoadingAddEstimateWidgte extends StatelessWidget {
  const LoadingAddEstimateWidgte({super.key});

  @override
  Widget build(BuildContext context) {
    return           BlocBuilder<AssessmentsCubit, AssessmentsState>(
      builder: (context, state) {
        if (state is AddEstimateAssessmentLoadingState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.loading();
          });
        } else if (state is ErrorMessageEstimateAssessment) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ToastNotificationMessage().showToastNotificationError(
              message: state.message,
              context: context,
            );
            context.pop();
          });
        } else if (state is AddSucssessEstimateAssessmentLoadingState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ToastNotificationMessage().showNotificationSuccess(
              message: 'Add rated has been added successfully.',
              context: context,
            );
            context.pop();
            context.pop();
          });
        }
        return SizedBox.shrink();
      },
    );
  }
}
