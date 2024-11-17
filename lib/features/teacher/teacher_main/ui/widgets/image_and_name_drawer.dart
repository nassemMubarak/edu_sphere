import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
class ImageAndNameDrawer extends StatelessWidget {
  const ImageAndNameDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return             Container(
      padding: EdgeInsetsDirectional.only(start: 16.w,end: 16.w,top: 48.h,bottom: 8.h),
      height: 132.w,
      width: double.infinity,
      decoration: BoxDecoration(
          color: ColorsManager.mainBlue
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsetsDirectional.symmetric(horizontal: 11.w,vertical: 8.h),
                width: 50.w,
                height: 50.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: Colors.white
                ),
                child: SvgPicture.asset('assets/svgs/person_icon.svg'),
              ),
              horizontalSpace(8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Welcome to our application',style: TextStyles.font12White400Weight,),
                  verticalSpace(4),
                  Text('Nassem Mubarak',style: TextStyles.font16White600Weight,),
                ],
              ),
            ],
          ),
          verticalSpace(8),
          Text(' Last login 30 minutes ago',style: TextStyles.font12White400Weight,)
        ],

      ),
    );
  }
}
