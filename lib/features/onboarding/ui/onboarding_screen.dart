import 'package:edu_sphere/core/helpers/constants.dart';
import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/helpers/shared_pref_helper.dart';
import 'package:edu_sphere/core/routing/routes.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/features/onboarding/ui/widgets/indicator_onboarding_widget.dart';
import 'package:edu_sphere/features/onboarding/ui/widgets/page_view_onboarding_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController pageController;
  int _counterPage = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0);
    Future.delayed(Duration.zero,() async{
      await SharedPrefHelper.setData(SharedPrefKeys.isShowOnboarding, true);
    },);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            onPageChanged: (value) {
              setState(() {
                _counterPage = value;
              });
            },
            children: [
              PageViewOnboardingWidget(
                image: 'assets/images/onboarding_image1.png',
                text1:
                    AppLocalizations.of(context)!.onBoarding1Text1,
                text2:
                AppLocalizations.of(context)!.onBoarding1Text2,
              ),
              PageViewOnboardingWidget(
                image: 'assets/images/onboarding_image2.png',
                text1:
                AppLocalizations.of(context)!.onBoarding2Text1,
                text2:
                AppLocalizations.of(context)!.onBoarding2Text2,
              ),
              PageViewOnboardingWidget(
                image: 'assets/images/onboarding_image3.png',
                text1:
                AppLocalizations.of(context)!.onBoarding3Text1,
                text2:
                AppLocalizations.of(context)!.onBoarding3Text2,
              ),
            ],
          ),
          PositionedDirectional(
            bottom: 72.h,
            end: 16.w,
            child: GestureDetector(
              onTap: () {
                if (_counterPage == 2) {
                  context.pushNamed(Routes.loginScreen);
                } else {
                  pageController.nextPage(
                      duration: const Duration(seconds: 1),
                      curve: Curves.easeInOut);
                  setState(() {
                    _counterPage = _counterPage++;
                  });
                }
              },
              child: CircleAvatar(
                backgroundColor: ColorsManager.secondaryColor,
                radius: 25.r,
                child: const Icon(Icons.arrow_forward, color: Colors.white),
              ),
            ),
          ),
          IndicatorOnboardingWidget(pageNumber: _counterPage),
        ],
      ),
    );
  }
}
