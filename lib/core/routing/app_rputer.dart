import 'package:edu_sphere/core/routing/routes.dart';
import 'package:edu_sphere/features/forget_password/ui/screens/forget_password_screen.dart';
import 'package:edu_sphere/features/forget_password/ui/screens/reset_password_screen.dart';
import 'package:edu_sphere/features/forget_password/ui/screens/verify_password_screen.dart';
import 'package:edu_sphere/features/login/ui/login_screen.dart';
import 'package:edu_sphere/features/onboarding/ui/onboarding_screen.dart';
import 'package:edu_sphere/features/signup/logic/sign_up_cubit.dart';
import 'package:edu_sphere/features/signup/ui/signup_screen.dart';
import 'package:edu_sphere/features/teacher/teacher_main/logic/teacher_main_cubit.dart';
import 'package:edu_sphere/features/teacher/teacher_main/ui/teacher_main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.onBoardingScreen:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case Routes.loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case Routes.signupScreen:
        return MaterialPageRoute(
            builder: (_) => const SignupScreen());
      case Routes.forgetPasswordScreen:
        return MaterialPageRoute(builder: (_) => ForgetPasswordScreen());

      case Routes.verifyPasswordScreen:
        return MaterialPageRoute(builder: (_) => VerifyPasswordScreen());
      case Routes.teacherMainScreen:
        return MaterialPageRoute(
          builder: (_) => const TeacherMainScreen()
        );

      case Routes.resetPasswordScreen:
        return MaterialPageRoute(builder: (_) => ResetPasswordScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
