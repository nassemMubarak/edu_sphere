import 'package:edu_sphere/core/routing/app_rputer.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/edu_sphere_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: ColorsManager.mainBlue,
  ));
  runApp(EduSphereApp(appRouter: AppRouter()));
}
