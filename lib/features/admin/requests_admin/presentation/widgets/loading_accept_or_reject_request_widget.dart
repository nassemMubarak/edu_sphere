import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/features/admin/requests_admin/presentation/bloc/request_admin_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/util/toast_notification_message.dart';
import '../bloc/accept_or_reject_request/accept_or_reject_request_cubit.dart';

class LoadingAcceptOrRejectRequestWidget extends StatelessWidget {
  String messageSuccess;
   LoadingAcceptOrRejectRequestWidget({super.key,required this.messageSuccess});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AcceptOrRejectRequestCubit, AcceptOrRejectRequestState>(
      listener: (context, state) {
        if (state is ReplayRequestLoadingState) {
          context.loading();
        } else if (state is ErrorMessageReplayRequestState) {
          ToastNotificationMessage().showToastNotificationError(
              message: state.message, context: context);
          context.pop();
        } else if (state is ReplayRequestLoadedDataState) {
          ToastNotificationMessage()
              .showNotificationSuccess(message: messageSuccess, context: context);
          context.read<RequestAdminCubit>().emitGetAllRequestAdmin();
          context.pop();
          context.pop();
          context.pop();
        }
      },
      builder: (context, state) => SizedBox.shrink(),
    );
  }
}
