import 'package:edu_sphere/core/theming/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:edu_sphere/l10n/app_localizations.dart';
class ByClickingSignUpText extends StatelessWidget {
  const ByClickingSignUpText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(children: [
      TextSpan(
          text: AppLocalizations.of(context)!.byClickingText,
          style: TextStyles.font12Black400Weight),
      TextSpan(
          text: AppLocalizations.of(context)!.termsAndConditions,
          style: TextStyles.font12ElectricBlue400Weight,),
    ],),);
  }
}
