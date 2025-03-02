import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/routing/routes.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:edu_sphere/l10n/app_localizations.dart';
class TextAccountSignupWidget extends StatelessWidget {
  const TextAccountSignupWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.center,
      child: RichText(
        text: TextSpan(
          text: AppLocalizations.of(context)!.noAccount,
          style: TextStyles.font12Black400Weight,
          children: [
            TextSpan(
              text: AppLocalizations.of(context)!.signUp,
              style: TextStyles.font16LightBlue500Weight,
              recognizer: TapGestureRecognizer()..onTap = () {
                context.pushNamed(Routes.signupScreen);

              }
            ),
          ],
        ),
      ),
    );
  }
}
