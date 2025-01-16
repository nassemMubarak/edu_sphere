import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/widgets/alert_dialog_widget.dart';
import 'package:flutter/material.dart';

class AcceptRequestAlertDialog extends StatelessWidget {
  const AcceptRequestAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialogWidget(
        title: 'Accept Request',
        textButton: 'Accept Request',
        widget: Center(
          child: Text(
            'Are you sure you want to accept request?',
            style: TextStyles.font14Black400Weight,
            textAlign: TextAlign.center,
          ),
        ),
        onTapButton: () {
          context.pop();
          showDialog(context: context, builder: (context) => AlertDialogWidget(
            showCancel: false,
              title: 'Add contact information',
              textButton: 'Cancel',
              widget: Column(
                children: [
                  Text(
                    'Reach The Maximum',
                    style: TextStyles.font14Black400Weight,
                    textAlign: TextAlign.center,
                  ),
                  verticalSpace(16),
                  Text(
                    'The request cannot be accepted the camp has reached its maximum capacity. You need to contact the camp',
                    style: TextStyles.font14Black400Weight,
                    textAlign: TextAlign.center,
                  ),

                ],
              ),
              onTapButton: () {
            context.pop();
              }),);
        });
  }
}
