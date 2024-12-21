import 'package:edu_sphere/features/auth/presentation/bloc/auth/auth_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GenderWidget extends StatefulWidget {
  Function()? onSelectGender;

  GenderWidget({super.key, this.onSelectGender});

  @override
  State<GenderWidget> createState() => _GenderWidgetState();
}

class _GenderWidgetState extends State<GenderWidget> {
  bool isMale = true;
  bool isFemale = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if(widget.onSelectGender!=null)...[
            SvgPicture.asset('assets/svgs/mail_icon.svg',color: ColorsManager.neutralGray,),
              horizontalSpace(8),
            ],
            Text(
              AppLocalizations.of(context)!.gender,
              style: TextStyles.font14Black500Weight,
            ),
          ],
        ),
        verticalSpace(8),
        Row(
          children: [
            selecteAndLabel(
              onTap: () {
                setState(() {
                  isFemale = false;
                  isMale = true;
                  if (widget.onSelectGender != null) {
                    widget.onSelectGender;
                  } else {
                    context.read<AuthCubit>().genderIsMale = true;
                  }
                });
              },
              label: AppLocalizations.of(context)!.male,
              isSelected: isMale,
            ),
            horizontalSpace(32),
            selecteAndLabel(
              onTap: () {
                setState(() {
                  isFemale = true;
                  isMale = false;
                  if (widget.onSelectGender != null) {
                    widget.onSelectGender;
                  } else {
                    context.read<AuthCubit>().genderIsMale = false;
                  }
                });
              },
              label: AppLocalizations.of(context)!.female,
              isSelected: isFemale,
            ),
          ],
        ),
      ],
    );
  }

  Widget selecteAndLabel(
      {required String label,
      required bool isSelected,
      required Function() onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: isSelected ? ColorsManager.lightBlue : Colors.white,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(color: ColorsManager.lightBlue),
              ),
              child: isSelected
                  ? const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 14,
                    )
                  : const Padding(padding: EdgeInsets.all(6)),
            ),
            horizontalSpace(8),
            Text(label, style: TextStyles.font12Black500Weight),
          ],
        ),
      ),
    );
  }
}
