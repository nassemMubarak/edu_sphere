import 'package:edu_sphere/core/helpers/constants.dart';
import 'package:edu_sphere/core/helpers/shared_pref_helper.dart';
import 'package:edu_sphere/core/routing/app_rputer.dart';
import 'package:edu_sphere/edu_sphere_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'injection_container.dart' as di;

bool isShowOnBoarding = false;
void main() async {
  await ScreenUtil.ensureScreenSize();
  await checkIfShowOnboarding();
  await di.init();
  // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
  //   statusBarColor: ColorsManager.mainBlue,
  // ));
  runApp(EduSphereApp(appRouter: AppRouter()));
}
checkIfShowOnboarding() async{
  bool? isShow = await SharedPrefHelper.getBool(SharedPrefKeys.isShowOnboarding);
  if(isShow==null){
    isShowOnBoarding = false;
  }else if(isShow==false){
    isShowOnBoarding = false;
  }else{
    isShowOnBoarding = true;
  }
}
