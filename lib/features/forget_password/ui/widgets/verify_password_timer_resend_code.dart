import 'package:edu_sphere/core/theming/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class VerifyPasswordTimerResendCode extends StatefulWidget {
  VerifyPasswordTimerResendCode({Key? key}) : super(key: key);

  @override
  State<VerifyPasswordTimerResendCode> createState() =>
      _VerifyEmailTimerResendCodeState();
}

class _VerifyEmailTimerResendCodeState
    extends State<VerifyPasswordTimerResendCode> {
  bool enableResendCode = false;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Colors.white,
      child: !enableResendCode
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context)!.didNotReceiveCode,
                  textAlign: TextAlign.center,
                  style: TextStyles.font12Black400Weight,
                ),
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.resendAfter,
                      textAlign: TextAlign.center,
                      style: TextStyles.font12Black500Weight,
                    ),
                    TimerCountdown(
                      spacerWidth: 0,
                      timeTextStyle: TextStyles.font12Black500Weight,
                      enableDescriptions: false,
                      format: CountDownTimerFormat.minutesSeconds,
                      endTime: DateTime.now().add(
                        const Duration(
                          minutes: 1,
                        ),
                      ),
                      onEnd: () {
                        setState(() {
                          enableResendCode = true;
                        });
                      },
                    ),
                  ],
                ),
              ],
            )
          : Center(
              child: Column(
                children: [
                  Text(
                    AppLocalizations.of(context)!.resendAfter,
                    textAlign: TextAlign.center,
                    style: TextStyles.font12Black500Weight,
                  ),
                  SizedBox(height: 10.h),
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        enableResendCode = false;
                      });
                    },
                    child: Text(
                      AppLocalizations.of(context)!.resend,
                      textAlign: TextAlign.center,
                      style: TextStyles.font12MainBlue500Weight,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
