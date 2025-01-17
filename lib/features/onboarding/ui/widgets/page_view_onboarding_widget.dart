import 'package:edu_sphere/features/onboarding/ui/widgets/text_and_container_onboarding_widget.dart';
import 'package:flutter/cupertino.dart';

class PageViewOnboardingWidget extends StatelessWidget {
  String image;
  String text1;
  String text2;
   PageViewOnboardingWidget({
    super.key,
    required this.image,
    required this.text1,
    required this.text2,

  }) ;


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PositionedDirectional(
          bottom: 0,
          start: 0,
          end: 0,
          top: 0,
          child: Image.asset(image,
              fit: BoxFit.cover),
        ),
        TextAndContainerOnboardingWidget(text1: text1, text2: text2),
      ],
    );
  }
}
