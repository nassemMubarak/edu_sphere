import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/widgets/app_text_button.dart';
import 'package:edu_sphere/core/widgets/wave_top_widget.dart';
import 'package:edu_sphere/features/forget_password/ui/widgets/rest_password_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          WaveTopWidget(),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 200.h),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.asset(
                      'assets/images/reset_password_image.png',
                      height: 220.h,
                      width: 220.w,
                      alignment: Alignment.center,
                    ),
                    // verticalSpace(32),
                    Text(
                      AppLocalizations.of(context)!.resetPassword,
                      style: TextStyles.font18MainBlue500Weight,
                    ),
                    verticalSpace(8),
                    Text(
                      AppLocalizations.of(context)!.enterNewPassword,
                      style: TextStyles.font16NeutralGray400Weight,
                    ),
                    verticalSpace(32),
                    RestPasswordForm(),
                    verticalSpace(30),
                    AppTextButton(
                      buttonText: AppLocalizations.of(context)!.sendVerificationCode,
                      onPressed: () {},
                    ),
                    verticalSpace(74),
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
