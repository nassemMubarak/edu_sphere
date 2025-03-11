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
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text1,
            style: TextStyles.font20White600Weight,
            overflow: TextOverflow.visible,
            maxLines: 3,
          ),
          verticalSpace(8),
          Text(
            text2,
            style: TextStyles.font12White400Weight,
            overflow: TextOverflow.visible,
            maxLines: 3,
            textAlign: TextAlign.start,
          ),
          verticalSpace(49),
        ],
      ),
    );
  }
}
