import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/util/toast_notification_message.dart';
import 'package:edu_sphere/features/communication/presentation/bloc/communication_cubit.dart';
import 'package:edu_sphere/features/profile/presentation/bloc/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class LoadingCommunicationWidget extends StatelessWidget {
  String message;
  LoadingCommunicationWidget({super.key,required this.message});

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<CommunicationCubit, CommunicationState>(
      builder: (context, state) => SizedBox.shrink(),
      listener: (context, state) {
        if (state is AddOrUpdateCommunicationLoadingState) {
          context.loading();
        } else if (state is ErrorMessageCommunicationUserState) {
          ToastNotificationMessage().showToastNotificationError(
              message: state.message, context: context);
          context.pop();
        } else if (state is GetAllCommunicationLoadedDataState) {
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
