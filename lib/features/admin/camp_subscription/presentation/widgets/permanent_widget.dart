import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/routing/routes.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/widgets/app_text_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PermanentWidget extends StatelessWidget {
  String price;
  String supTitle1;
  String supTitle2;
  String supTitle3;
  bool isShowButtonSubscribe;

  PermanentWidget({
    super.key,
    required this.isShowButtonSubscribe,
    required this.price,
    required this.supTitle1,
    required this.supTitle2,
    required this.supTitle3,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
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
          SvgPicture.asset(
            'assets/svgs/permanet_icon.svg',
            width: 60.w,
            height: 60.h,
          ),
          verticalSpace(16),
          Text('$price/Permanent',
              style: TextStyles.font16MainBlue500Weight,
              textAlign: TextAlign.center),
          verticalSpace(24),
          Row(
            children: [
              Icon(Icons.check),
              horizontalSpace(8),
              Expanded(child: Text(supTitle1, style: TextStyles.font16Black500Weight)),
            ],
          ),
          verticalSpace(16),
          Row(
            children: [
              Icon(Icons.check),
              horizontalSpace(8),
              Expanded(child: Text(supTitle2, style: TextStyles.font16Black500Weight)),
            ],
          ),
          verticalSpace(16),
          Row(
            children: [
              Icon(Icons.check),
              horizontalSpace(8),
              Expanded(child: Text(supTitle3, style: TextStyles.font16Black500Weight)),
            ],
          ),
          verticalSpace(24),
          if (isShowButtonSubscribe)
            AppTextButton(buttonText: 'Subscribe With Us',onPressed: (){
              context.pushNamed(Routes.contactUsSubscribePage);
            },)
        ],
      ),
    );
  }
}
