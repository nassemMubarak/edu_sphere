import 'package:edu_sphere/core/theming/styles.dart';
import 'package:flutter/cupertino.dart';

class ByClickingSignUpText extends StatelessWidget {
  const ByClickingSignUpText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(children: [
      TextSpan(
          text: 'By Clicking “Sign Up “ , I Agree To ',
          style: TextStyles.font12Black400Weight),
      TextSpan(
          text: 'Terms Of Condition & Privacy Policy',
          style: TextStyles.font12ElectricBlue400Weight,),
    ],),);
  }
}
