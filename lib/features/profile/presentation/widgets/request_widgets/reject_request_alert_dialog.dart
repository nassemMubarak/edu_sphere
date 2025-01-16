import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/widgets/alert_dialog_widget.dart';
import 'package:edu_sphere/core/widgets/app_text_form_field.dart';
import 'package:edu_sphere/core/widgets/label_and_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RejectRequestAlertDialog extends StatelessWidget {
  const RejectRequestAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialogWidget(
        title: 'Reject Request',
        textButton: 'Reject Request',
        widget: Column(
          children: [
            Text('Are you sure you want to Reject request?',style: TextStyles.font14Black400Weight,textAlign: TextAlign.center,),
            verticalSpace(16),
            LabelAndWidget(
              label: 'Reason for rejection',
              widget: AppTextFormField(
                textStyle: TextStyles.font12Black500Weight,
                maxLines: 5,
                hintText: 'Reason for rejection',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter reason for rejection';
                  }
                },
                prefixIcon: Container(
                  height: 105,
                  width: 50,
                  alignment: AlignmentDirectional.topCenter,
                  child: SvgPicture.asset(
                    'assets/svgs/reject_request_icon.svg',
                    color: Color(0xFF929597),
                  ),
                ),
              ),
            ),
          ],
        ),
        onTapButton: (){}
      ,);
  }
}
