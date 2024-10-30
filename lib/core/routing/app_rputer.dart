import 'package:edu_sphere/core/routing/routes.dart';
import 'package:edu_sphere/features/login/ui/login_screen.dart';
import 'package:edu_sphere/features/onboarding/ui/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class AppRouter{
  Route generateRoute(RouteSettings settings){
    switch (settings.name) {
      case Routes.onBoardingScreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case Routes.loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
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
