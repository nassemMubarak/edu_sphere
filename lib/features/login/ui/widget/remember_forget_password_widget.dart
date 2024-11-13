import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/routing/routes.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class RememberAndForgetPasswordWidget extends StatefulWidget {
  const RememberAndForgetPasswordWidget({super.key});

  @override
  State<RememberAndForgetPasswordWidget> createState() =>
      _RememberAndForgetPasswordWidgetState();
}

class _RememberAndForgetPasswordWidgetState
    extends State<RememberAndForgetPasswordWidget> {
  bool isRemmember = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isRemmember = !isRemmember;
            });
          },
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: isRemmember ? Colors.white : ColorsManager.lightBlue,
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(color: ColorsManager.lightBlue),
                ),
                child: isRemmember
                    ? const Padding(padding: const EdgeInsets.all(6))
                    : const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 14,
                      ),
              ),
              horizontalSpace(4),
              Text(
                AppLocalizations.of(context)!.rememberMe,
                style: TextStyles.font12Black400Weight,
              ),
            ],
          ),
        ),
        Spacer(),
        GestureDetector(
          onTap: () {
            context.pushNamed(Routes.forgetPasswordScreen);
          },
          child: Text(
            AppLocalizations.of(context)!.forgotPassword,
            style: TextStyles.font12Red400Weight,
          ),
        ),
      ],
    );
  }
}
