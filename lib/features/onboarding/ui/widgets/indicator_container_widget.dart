import 'package:edu_sphere/core/theming/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class IndicatorContainerWidget extends StatelessWidget {
  final bool isSelected;
  final double? margin;
  const IndicatorContainerWidget({
    super.key,
    required this.isSelected,
    this.margin
  });

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsetsDirectional.only(end: margin??0),
      width: isSelected?40.w:6.w,
      height: 6.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(isSelected?33:3),
          color: isSelected?ColorsManager.secondaryColor:Colors.white),
    );
  }
}
