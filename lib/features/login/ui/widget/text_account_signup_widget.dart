import 'package:edu_sphere/core/theming/styles.dart';
import 'package:flutter/material.dart';

class TextAccountSignupWidget extends StatelessWidget {
  const TextAccountSignupWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.center,
      child: RichText(
        text: TextSpan(
          text: 'Don’t have an account?  ',
          style: TextStyles.font12Black400Weight,
          children: [
            TextSpan(
              text: 'Sign up',
              style: TextStyles.font16LightBlue500Weight,
            ),
          ],
        ),
      ),
    );
  }
}
