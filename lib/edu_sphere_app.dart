import 'package:edu_sphere/core/routing/app_rputer.dart';
import 'package:edu_sphere/core/routing/routes.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// nassem
class EduSphereApp extends StatelessWidget {
  final AppRouter appRouter;
   const EduSphereApp({super.key,required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          // localizationsDelegates: [
          //   AppLocalizations.delegate,
          //   GlobalWidgetsLocalizations.delegate,
          //   GlobalCupertinoLocalizations.delegate,
          //   GlobalMaterialLocalizations.delegate,
          // ],
          // supportedLocales: [
          //   Locale('ar',''),
          //   Locale('en',''),
          // ],
          // locale: Locale('en'),
          debugShowCheckedModeBanner: false,
          title: 'Edu Sphere App',
          onGenerateRoute: appRouter.generateRoute,
          theme: ThemeData(
            primaryColor: ColorsManager.mainBlue,
          ),
          initialRoute: Routes.onBoardingScreen,
        );
      },
      
      child: const Placeholder(),
    );
  }
}
