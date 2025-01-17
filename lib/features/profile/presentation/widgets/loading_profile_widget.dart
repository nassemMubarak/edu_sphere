import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/util/toast_notification_message.dart';
import 'package:edu_sphere/features/profile/presentation/bloc/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class LoadingProfileWidget extends StatelessWidget {
  String message;
  LoadingProfileWidget({super.key,required this.message});

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ProfileCubit, ProfileState>(
      builder: (context, state) => SizedBox.shrink(),
      listener: (context, state) {
        if (state is UpdateUserLoadingState) {
          context.loading();
        } else if (state is ErrorMessageGetInfoUserState) {
          ToastNotificationMessage().showToastNotificationError(
              message: state.message, context: context);
          context.pop();
        } else if (state is GetInfoUserLoadedDataState) {
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
