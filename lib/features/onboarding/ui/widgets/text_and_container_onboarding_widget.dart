import 'package:edu_sphere/features/onboarding/ui/widgets/text_onboarding_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextAndContainerOnboardingWidget extends StatelessWidget {
  String text1;
  String text2;

  TextAndContainerOnboardingWidget({
    super.key,
    required this.text1,
    required this.text2,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 32.h),
        height: 320.h,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFF000000).withOpacity(0.5),
              const Color(0xFF000000).withOpacity(0.8),
              const Color(0xFF000000).withOpacity(0.5),
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            // stops: const [0.14, 0.4],
          ),
        ),
        child: TextOnboardingWidget(
          text1: text1,
          text2: text2,
        ),
      ),
    );
  }
}
