import 'package:edu_sphere/core/helpers/constants.dart';
import 'package:edu_sphere/core/helpers/shared_pref_helper.dart';
import 'package:edu_sphere/core/routing/app_router.dart';
import 'package:edu_sphere/edu_sphere_app.dart';
import 'package:edu_sphere/features/auth/domain/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/theming/colors.dart';
import 'injection_container.dart' as di;

bool isShowOnBoarding = false;
bool isUserLogIn = false;
void main() async {
  await ScreenUtil.ensureScreenSize();
  await di.init();
  await checkIfShowOnboarding();
  await checkIfUserLogIn();
  // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
  //   // statusBarColor: ColorsManager.mainBlue,
  //   // systemNavigationBarDividerColor: ColorsManager.mainBlue,
  //   // systemNavigationBarColor: ColorsManager.mainBlue,
  //
  // ),);
  runApp(EduSphereApp(appRouter: AppRouter()));
}
checkIfShowOnboarding() async{
  bool? isShow = await SharedPrefHelper.getBool(SharedPrefKeys.isShowOnboarding);
  print(isShow);
  if(isShow==null){
    isShowOnBoarding = false;
  }else if(isShow==false){
    isShowOnBoarding = false;
  }else{

    isShowOnBoarding = true;
  }
}
checkIfUserLogIn() async{
  String? isShowUser = await SharedPrefHelper.getString(SharedPrefKeys.cachedUser);
  print(isShowUser);
  if(isShowUser==null){
    isUserLogIn = false;
  }else if(isShowUser.isEmpty){
    isUserLogIn = false;
  }
  else{
    isUserLogIn = true;
  }
}
