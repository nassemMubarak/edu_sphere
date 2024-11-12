import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/widgets/app_text_button.dart';
import 'package:edu_sphere/features/login/ui/widget/email_and_password_widget.dart';
import 'package:edu_sphere/features/login/ui/widget/remember_forget_password_widget.dart';
import 'package:edu_sphere/features/signup/ui/widget/selecte_student_or_teacher_or_camp_widget.dart';
import 'package:edu_sphere/features/login/ui/widget/text_account_signup_widget.dart';
import 'package:edu_sphere/core/widgets/wave_top_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(

        children: [
          const WaveTopWidget(),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Container(
                margin: EdgeInsets.only(top: 158.h), // margin to create space from the top
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 2,
                      blurRadius: 4,
                      color: ColorsManager.shadowColor.withOpacity(0.4),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome Back',
                        style: TextStyles.font18Black600Weight,
                      ),
                      verticalSpace(8),
                      Text(
                        'Login to continue',
                        style: TextStyles.font16NeutralGray400Weight,
                      ),
                      verticalSpace(32),
                      const EmailAndPasswordWidget(),
                      const RememberAndForgetPasswordWidget(),
                      verticalSpace(48),
                      const AppTextButton(buttonText: 'Login'),
                      verticalSpace(35),
                      const TextAccountSignupWidget(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
