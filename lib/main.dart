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
String typeUser = 'Student';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await di.init();
  await checkIfShowOnboarding();
  await checkIfUserLogIn();
  await getTypeUserLogIn();

  runApp(EduSphereApp(appRouter: AppRouter()));
}

Future<void> checkIfShowOnboarding() async {
  bool? isShow = await SharedPrefHelper.getBool(SharedPrefKeys.isShowOnboarding);
  isShowOnBoarding = isShow ?? false;
}

Future<void> checkIfUserLogIn() async {
  String? cachedUser = await SharedPrefHelper.getString(SharedPrefKeys.cachedUser);
  isUserLogIn = cachedUser?.isNotEmpty ?? false;
}
Future<void> getTypeUserLogIn() async {
  String? cachedUser = await SharedPrefHelper.getString(SharedPrefKeys.cachedUser);
  typeUser = cachedUser??'Student';
}
