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
          top: 68.h,
          start: 91.w,
          child: RichText(
            text: TextSpan(
                text: 'E',
                style: TextStyles.font50White700Weight,
                children: [
                  TextSpan(
                    text: 'du',
                    style: TextStyles.font50SkyBlue700Weight,
                  ),
                  TextSpan(
                    text: 'sphere',
                    style: TextStyles.font24White700Weight,
                  )
                ]),
          ),
        ),
      ],
    );
  }
}
