import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/widgets/app_text_button.dart';
import 'package:flutter/material.dart';
import 'package:edu_sphere/l10n/app_localizations.dart';

class ShowMessagePindingOrRejectedCourseInfoDialog extends StatelessWidget {
  bool isPending;

  ShowMessagePindingOrRejectedCourseInfoDialog(
      {super.key, required this.isPending});

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
        isPending ? 'Pending' : 'Rejected',
        style: TextStyles.font16Black600Weight,
        textAlign: TextAlign.center,
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          verticalSpace(24),
          Text(isPending
              ? 'You cannot enter this Graduation research because the camp has not approved it yet.'
              : 'You cannot enter this course because the camp has rejected your application.',
            style: TextStyles.font14Black400Weight,
            textAlign: TextAlign.center,
          ),
          verticalSpace(24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppTextButton(
                onPressed: () {
                  context.pop();
                },
                buttonText: AppLocalizations.of(context)!.cancel,
                buttonWidth: 147,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
