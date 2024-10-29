import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/widgets/app_text_form_field.dart';
import 'package:flutter/material.dart';

class LableAndTextFormField extends StatelessWidget {
  String lable;
  String hintText;
  Widget? prefixIcon;
  Widget? suffixIcon;
  bool? isObsecure;
  LableAndTextFormField({
    super.key,
    required this.lable,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.isObsecure,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          lable,
          style: TextStyles.font16Black500Weight,
        ),
        verticalSpace(8),
        AppTextFormField(
          hintText: hintText,
          validator: (value) {},
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          isObscureText: isObsecure,
        ),
        verticalSpace(24)
      ],
    );
  }
}
