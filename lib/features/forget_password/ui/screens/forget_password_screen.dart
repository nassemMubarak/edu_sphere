import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/routing/routes.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/widgets/app_text_button.dart';
import 'package:edu_sphere/core/widgets/app_text_form_field.dart';
import 'package:edu_sphere/core/widgets/label_and_widget.dart';
import 'package:edu_sphere/core/widgets/wave_top_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});
  final formKey = GlobalKey<FormState>();
  TextEditingController emailTextEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          const WaveTopWidget(),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 200.h),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    verticalSpace(10),
                    Image.asset(
                      'assets/images/forget_password_image.png',
                      height: 170.h,
                      width: 190.w,
                      alignment: Alignment.center,
                    ),
                    verticalSpace(32),
                    Text(
                      'Forgot Your Password?',
                      style: TextStyles.font18MainBlue500Weight,
                    ),
                    verticalSpace(8),
                    Text(
                      'We will send you a verification code.',
                      style: TextStyles.font16NeutralGray400Weight,
                    ),
                    verticalSpace(32),
                    Form(
                      key: formKey,
                      child: LabelAndWidget(
                        label: 'Email',
                        widget: AppTextFormField(
                          controller: emailTextEditingController,
                          hintText: 'example@example.com',
                          validator: (value) {},
                        ),
                      ),
                    ),
                    verticalSpace(30),
                    AppTextButton(
                      buttonText: 'Send Verification Code',
                      onPressed: () {
                        context.pushNamed(Routes.verifyPasswordScreen);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
