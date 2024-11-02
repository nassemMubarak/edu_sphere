import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:flutter/material.dart';

class LabelAndWidget extends StatelessWidget {
  String label;
  Widget widget;
  LabelAndWidget({
    super.key,
    required this.label,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyles.font14Black500Weight,
        ),
        verticalSpace(8),
        widget,
        verticalSpace(24)
      ],
    );
  }
}
