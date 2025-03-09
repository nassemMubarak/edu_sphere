import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/widgets/app_text_button.dart';
import 'package:edu_sphere/features/admin/requests_admin/data/model/request_model.dart';
import 'package:edu_sphere/features/admin/requests_admin/presentation/bloc/accept_or_reject_request/accept_or_reject_request_cubit.dart';
import 'package:edu_sphere/features/admin/requests_admin/presentation/widgets/loading_accept_or_reject_request_widget.dart';
import 'package:edu_sphere/features/teacher/quiz/domain/entities/quiz.dart';
import 'package:edu_sphere/features/teacher/quiz/presentation/bloc/quiz_cubit.dart';
import 'package:edu_sphere/features/teacher/quiz/presentation/widgets/quiz_widget/loading_add_or_update_or_delete_quiz_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:edu_sphere/l10n/app_localizations.dart';
import 'package:logger/logger.dart';

import '../../../../../core/theming/colors.dart';
import '../../../../../core/widgets/app_text_form_field.dart';
import '../../../../../core/widgets/label_and_widget.dart';

class RejectRequestInfoDialog extends StatelessWidget {
  RequestModel requestModel;
  RejectRequestInfoDialog({super.key,required this.requestModel});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      insetPadding: EdgeInsets.all(16),
      backgroundColor: Colors.white,
      scrollable: true,
      title: Text(
        'Reject Request',
        style: TextStyles.font16Black600Weight,
        textAlign: TextAlign.center,
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          verticalSpace(24),
          Text(
            'Are you sure you want to Reject request?',
            style: TextStyles.font14Black400Weight,
            textAlign: TextAlign.start,
          ),
          verticalSpace(16),
          LabelAndWidget(
            label: 'Reason for rejection',
            widget: AppTextFormField(
              maxLines: 5,
              hintText: 'Reason for rejection',
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Reason for rejection';
                }
              },
              prefixIcon: Container(
                height: 115,
                width: 50,
                alignment: AlignmentDirectional.topCenter,
                child: const Icon(
                  Icons.message_outlined,
                  size: 20,
                  color: ColorsManager.neutralGray,
                ),
              ),
            ),
          ),
          LoadingAcceptOrRejectRequestWidget(messageSuccess: 'Request Has Been Rejected Successfully'),

          verticalSpace(16),
          Row(
            children: [
              Expanded(
                child: AppTextButton(
                  onPressed: () {
                    context.read<AcceptOrRejectRequestCubit>().emitReplyRequest(idRequest: requestModel.id,acceptRequest: false);

                  },
                  buttonText: 'Reject Request',
                  textStyle: TextStyles.font12White400Weight,
                  buttonWidth: 160,
                ),
              ),
              horizontalSpace(16),
              Expanded(
                child: AppTextButton(
                  onPressed: () {
                    context.pop();
                  },
                  buttonText: AppLocalizations.of(context)!.cancel,
                  buttonWidth: 147,
                  backgroundColor: Colors.white,
                  textStyle: TextStyles.font12Black500Weight,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
