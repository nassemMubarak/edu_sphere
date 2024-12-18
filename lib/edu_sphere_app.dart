import 'package:edu_sphere/core/routing/app_router.dart';
import 'package:edu_sphere/core/routing/routes.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/features/auth/presentation/bloc/auth/auth_cubit.dart';
import 'package:edu_sphere/features/auth/presentation/bloc/changTypSignUp/auth_type_cubit.dart';
import 'package:edu_sphere/features/teacher/assessments/presentation/bloc/assessments_cubit.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/bloc/course_main_cubit.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/pages/course_main_screen.dart';
import 'package:edu_sphere/features/teacher/quiz/presentation/bloc/quiz_cubit.dart';
import 'package:edu_sphere/features/teacher/teacher_main/logic/teacher_main_cubit.dart';
import 'package:edu_sphere/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'injection_container.dart' as di;
class EduSphereApp extends StatelessWidget {
  final AppRouter appRouter;
   const EduSphereApp({super.key,required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
         BlocProvider(create: (context)=>di.sl<AuthCubit>()..emitGetCurrentUser()),
         BlocProvider(create: (context)=>AuthTypeCubit()..emitChangTypSignUp('student')),
         BlocProvider(create: (context)=>TeacherMainCubit()),
         BlocProvider(create: (context)=>CourseMainCubit()),
         BlocProvider(create: (context)=>QuizCubit()),
         BlocProvider(create: (context)=>AssessmentsCubit()),
      ],
      child:
         ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, child) {
            return MaterialApp(
              localizationsDelegates: [
                AppLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
              ],
              supportedLocales: [
                Locale('ar',''),
                Locale('en',''),
              ],
              locale: Locale('en'),
              debugShowCheckedModeBanner: false,
              title: 'Edu Sphere App',
              onGenerateRoute: appRouter.generateRoute,
              theme: ThemeData(
                primaryColor: ColorsManager.mainBlue,
              ),
              initialRoute: isShowOnBoarding?isUserLogIn?Routes.teacherMainScreen:Routes.teacherMainScreen:Routes.onBoardingScreen,
              routes: {
                Routes.courseMainScreen: (context) => const CourseMainScreen( ),
              },
            );
          },
          
          child: const Placeholder(),
        )
      
    );
  }
}
