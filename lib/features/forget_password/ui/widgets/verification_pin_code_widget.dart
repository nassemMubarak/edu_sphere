import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerificationPinCodeWidget extends StatefulWidget {
  final TextEditingController controller;
  final String? Function(String?)? validate;
  const VerificationPinCodeWidget(
      {Key? key, required this.controller, this.validate})
      : super(key: key);

  @override
  State<VerificationPinCodeWidget> createState() =>
      _VerifyEmailPinCodeWidgetState();
}

class _VerifyEmailPinCodeWidgetState extends State<VerificationPinCodeWidget> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: PinCodeTextField(
        validator: widget.validate,
        onSubmitted: (v) async {
          ///  await performEmailValidation();
        },
        appContext: context,
        length: 4,
        animationType: AnimationType.fade,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(8.r),
          activeColor: ColorsManager.silverGray,
          borderWidth: 1,
          inactiveColor: ColorsManager.silverGray,
          selectedColor: ColorsManager.mainBlue,
          selectedFillColor: Colors.white,
          inactiveFillColor: Colors.white,
          fieldHeight: 73,
          fieldWidth: 73,
          activeFillColor: Colors.white,
        ),
        animationDuration: const Duration(milliseconds: 300),
        backgroundColor: Colors.transparent,
        enableActiveFill: true,
        keyboardType: TextInputType.number,
        textStyle: TextStyles.font24NeutralGray500Weight,
        controller: widget.controller,
        onCompleted: (v) {
          print("Completed");
        },
        onChanged: (value) {
          print(value);
        },
        beforeTextPaste: (text) {
          setState(() {
            widget.controller.text = text ?? '';
          });
          return false;
        },
      ),
    );
  }
}
