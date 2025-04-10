import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/widgets/app_text_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:edu_sphere/l10n/app_localizations.dart';
class AlertDialogWidget extends StatelessWidget {
  String title;
  String textButton;
  Widget widget;
  TextStyle? styleTitle;
  Function() onTapButton;
  bool showCancel;
   AlertDialogWidget({
    super.key,
     required this.title,
     required this.textButton,
     required this.widget,
     required this.onTapButton,
      this.styleTitle,
      this.showCancel=true
  });

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
        title,
        style: styleTitle??TextStyles.font16Black600Weight,
        textAlign: TextAlign.center,
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          verticalSpace(24),
          widget,
          verticalSpace(24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(
                  visible: !showCancel,
                  child: AppTextButton(
                onPressed: onTapButton,
                buttonText: textButton,
                textStyle: TextStyles.font12White400Weight,
                buttonWidth: 160,
              )),
              Visibility(
                visible: showCancel,
                child: Expanded(
                  child: AppTextButton(
                    onPressed: onTapButton,
                    buttonText: textButton,
                    textStyle: TextStyles.font12White400Weight,
                    buttonWidth: 160,
                  ),
                ),
              ),
              horizontalSpace(16),
              Visibility(
                visible: showCancel,
                child: Expanded(
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
              ),
            ],
          )
        ],
      ),
    );
  }
}
