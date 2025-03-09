import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/widgets/sliver_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CampSubscribePage extends StatelessWidget {
  const CampSubscribePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverWidget(
      widget: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 2,
                    blurRadius: 4,
                    color: ColorsManager.shadowColor.withOpacity(0.3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  SvgPicture.asset('assets/svgs/permanet_icon.svg'),
                  verticalSpace(16),
                  Text('Free/permanent',style: TextStyles.font16MainBlue500Weight),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
