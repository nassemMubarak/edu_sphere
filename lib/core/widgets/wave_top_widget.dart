import 'package:edu_sphere/core/theming/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WaveTopWidget extends StatelessWidget {
  const WaveTopWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Image.asset('assets/images/background_appbar.png'),
        ),
        PositionedDirectional(
          top: 100.h,
          start: 110.w,
          child: RichText(
            text: TextSpan(
                text: 'E',
                style: TextStyles.font30White700Weight,
                children: [
                  TextSpan(
                    text: 'du',
                    style: TextStyles.font30SkyBlue700Weight,
                  ),
                  TextSpan(
                    text: 'sphere',
                    style: TextStyles.font16White700Weight,
                  )
                ]),
          ),
        ),
      ],
    );
  }
}
