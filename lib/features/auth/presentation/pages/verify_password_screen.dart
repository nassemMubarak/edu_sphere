import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/routing/routes.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/widgets/app_text_button.dart';
import 'package:edu_sphere/core/widgets/wave_top_widget.dart';
import 'package:edu_sphere/features/auth/presentation/widgets/forget_password_widgets/verification_pin_code_widget.dart';
import 'package:edu_sphere/features/auth/presentation/widgets/forget_password_widgets/verify_password_timer_resend_code.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class VerifyPasswordScreen extends StatelessWidget {
  VerifyPasswordScreen({super.key});

  final formKey = GlobalKey<FormState>();
  TextEditingController pinCodeTextEditingController = TextEditingController();
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
                    Image.asset(
                      'assets/images/verify_image.png',
                      height: 170.h,
                      width: 190.w,
                      alignment: Alignment.center,
                    ),
                    verticalSpace(32),
                    Text(
                      AppLocalizations.of(context)!.enterVerificationCode,
                      style: TextStyles.font18MainBlue500Weight,
                    ),
                    verticalSpace(8),
                    Text(
                      AppLocalizations.of(context)!.verificationCodeReceived,
                      style: TextStyles.font16NeutralGray400Weight,
                    ),
                    verticalSpace(32),
                    Form(
                      key: formKey,
                      child: VerificationPinCodeWidget(
                        controller: pinCodeTextEditingController,
                      ),
                    ),
                    verticalSpace(30),
                    AppTextButton(
                      buttonText: AppLocalizations.of(context)!.verify,
                      onPressed: () {
                        context.pushNamed(Routes.resetPasswordScreen);
                      },
                    ),
                    verticalSpace(24),
                    VerifyPasswordTimerResendCode(),
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
