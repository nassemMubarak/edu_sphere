
import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class GenderWidget extends StatefulWidget {
  const GenderWidget({super.key});

  @override
  State<GenderWidget> createState() => _GenderWidgetState();
}

class _GenderWidgetState extends State<GenderWidget> {
  bool isMale = false;
  bool isFemale = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.gender,
          style: TextStyles.font14Black500Weight,
        ),
        verticalSpace(8),
        Row(
          children: [
            GestureDetector(
                onTap: () {
                  setState(() {
                    isFemale = false;
                    isMale = true;
                  });
                },
                child: selecteAndLabel(label: AppLocalizations.of(context)!.male, isSelected: isMale,),),
            horizontalSpace(32),
            GestureDetector(
              onTap: () {
                  setState(() {
                    isFemale = true;
                    isMale = false;
                  });
                },
              child: selecteAndLabel(label: AppLocalizations.of(context)!.female, isSelected: isFemale,),),
          ],
        ),
      ],
    );
  }

  Row selecteAndLabel({required String label, required bool isSelected}) {
    return Row(
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
    );
  }
}
