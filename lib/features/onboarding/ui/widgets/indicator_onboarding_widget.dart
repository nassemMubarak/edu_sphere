import 'package:edu_sphere/features/onboarding/ui/widgets/indicator_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IndicatorOnboardingWidget extends StatelessWidget {
  int pageNumber;
   IndicatorOnboardingWidget({
    super.key,
    required this.pageNumber
  });

  @override
  Widget build(BuildContext context) {
    print(pageNumber);
    return PositionedDirectional(
      start: 16.w,
      bottom: 89.h,
      child: Row(
        children: [
          IndicatorContainerWidget(
            isSelected: pageNumber==0,
            margin: 6.w,
          ),
          IndicatorContainerWidget(
            isSelected: pageNumber==1,
            margin: 6.w,
          ),
          IndicatorContainerWidget(isSelected: pageNumber==2),
        ],
      ),
    );
  }
}
