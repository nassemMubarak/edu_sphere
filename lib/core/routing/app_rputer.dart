import 'package:edu_sphere/core/routing/routes.dart';
import 'package:edu_sphere/features/auth/presentation/pages/login_screen.dart';
import 'package:edu_sphere/features/auth/presentation/pages/forget_password_screen.dart';
import 'package:edu_sphere/features/auth/presentation/pages/reset_password_screen.dart';
import 'package:edu_sphere/features/auth/presentation/pages/verify_password_screen.dart';
import 'package:edu_sphere/features/onboarding/ui/onboarding_screen.dart';
import 'package:edu_sphere/features/auth/presentation/pages/signup_screen.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/pages/course_main_screen.dart';
import 'package:edu_sphere/features/teacher/teacher_main/ui/teacher_main_screen.dart';
import 'package:flutter/material.dart';

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
      case Routes.courseMainScreen:
        return MaterialPageRoute(builder: (_) =>const CourseMainScreen());
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
