import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:flutter/cupertino.dart';

class TextOnboardingWidget extends StatelessWidget {
  final String text1;
  final String text2;
  const TextOnboardingWidget({
    super.key,
    required this.text1,required this.text2,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          text1,
          style: TextStyles.font20White600Weight,
        ),
        verticalSpace(8),
        Text(
          text2,
          style: TextStyles.font12White400Weight,
        ),
        verticalSpace(49),
      ],
    );
  }
}
