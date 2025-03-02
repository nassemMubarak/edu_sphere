import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/routing/routes.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/widgets/app_text_button.dart';
import 'package:edu_sphere/core/widgets/wave_top_widget.dart';
import 'package:edu_sphere/features/auth/presentation/bloc/auth/auth_cubit.dart';
import 'package:edu_sphere/features/auth/presentation/widgets/login_widgets/email_and_password_widget.dart';
import 'package:edu_sphere/features/auth/presentation/widgets/login_widgets/remember_forget_password_widget.dart';
import 'package:edu_sphere/features/auth/presentation/widgets/login_widgets/text_account_signup_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:edu_sphere/l10n/app_localizations.dart';
import 'package:logger/logger.dart';
class LoginFormWidget extends StatelessWidget {
  const LoginFormWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                      AppLocalizations.of(context)!.welcomeBackMessage,
                      style: TextStyles.font18Black600Weight,
                    ),
                    verticalSpace(8),
                    Text(
                      AppLocalizations.of(context)!.loginToContinue,
                      style: TextStyles.font16NeutralGray400Weight,
                    ),
                    verticalSpace(32),
                    const EmailAndPasswordWidget(),
                    const RememberAndForgetPasswordWidget(),
                    verticalSpace(48),
                    AppTextButton(buttonText: AppLocalizations.of(context)!.login,onPressed: (){
                      // context.pushNamed(Routes.studentRequestWidget);
                      if(context.read<AuthCubit>().globalKey.currentState!.validate()){
                        context.read<AuthCubit>().emitLoginUser();
                      }
                        // context.read<AuthCubit>().emitLoginUser();
                    },),
                    verticalSpace(35),
                    const TextAccountSignupWidget(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
