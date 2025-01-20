import 'package:edu_sphere/core/routing/app_router.dart';
import 'package:edu_sphere/core/routing/routes.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/features/auth/presentation/bloc/auth/auth_cubit.dart';
import 'package:edu_sphere/features/auth/presentation/bloc/changTypSignUp/auth_type_cubit.dart';
import 'package:edu_sphere/features/communication/presentation/bloc/communication_cubit.dart';
import 'package:edu_sphere/features/profile/presentation/bloc/profile_cubit.dart';
import 'package:edu_sphere/features/student/assessment_student/presesntations/bloc/student_assessment_cubit.dart';
import 'package:edu_sphere/features/student/show_studetn_course_teachers/presentations/bloc/show_student_teacher_cubit.dart';
import 'package:edu_sphere/features/student/student_main/presentations/bloc/student_advertisements/student_advertisements_cubit.dart';
import 'package:edu_sphere/features/student/student_main/presentations/bloc/student_document_course/student_document_course_cubit.dart';
import 'package:edu_sphere/features/student/student_main/presentations/bloc/student_lecture/student_lecture_cubit.dart';
import 'package:edu_sphere/features/student/student_main/presentations/bloc/student_search_course/student_search_course_cubit.dart';
import 'package:edu_sphere/features/student/student_main/presentations/bloc/subscribe_student_courses/subscribe_student_courses_cubit.dart';
import 'package:edu_sphere/features/student/student_quiz/presentation/bloc/student_quiz_cubit.dart';
import 'package:edu_sphere/features/teacher/assessments/presentation/bloc/assessments_cubit.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/bloc/course_advertisement/course_advertisement_cubit.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/bloc/course_lecture/course_lecture_cubit.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/bloc/course_main_cubit.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/bloc/document_course/document_course_cubit.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/pages/course_main_screen.dart';
import 'package:edu_sphere/features/teacher/quiz/presentation/bloc/question/question_cubit.dart';
import 'package:edu_sphere/features/teacher/quiz/presentation/bloc/quiz_cubit.dart';
import 'package:edu_sphere/features/teacher/teacher_main/presentation/logic/teacher_main_cubit.dart';
import 'package:edu_sphere/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:logger/logger.dart';
import 'injection_container.dart' as di;

class EduSphereApp extends StatelessWidget {
  final AppRouter appRouter;

  const EduSphereApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.sl<AuthCubit>()..emitGetCurrentUser()),
        BlocProvider(create: (context) => AuthTypeCubit()..emitChangTypSignUp('student')),
        BlocProvider(create: (context) => di.sl<TeacherMainCubit>()),
        BlocProvider(create: (context) => CourseMainCubit()),
        BlocProvider(create: (context) => di.sl<QuizCubit>()),
        BlocProvider(create: (context) => di.sl<QuestionCubit>()),
        BlocProvider(create: (context) => di.sl<AssessmentsCubit>()),
        BlocProvider(create: (context) => di.sl<CourseAdvertisementCubit>()),
        BlocProvider(create: (context) => di.sl<CourseLectureCubit>()),
        BlocProvider(create: (context) => di.sl<DocumentCourseCubit>()),
        BlocProvider(create: (context) => di.sl<SubscribeStudentCoursesCubit>()),
        BlocProvider(create: (context) => di.sl<StudentAdvertisementsCubit>()),
        BlocProvider(create: (context) => di.sl<StudentLectureCubit>()),
        BlocProvider(create: (context) => di.sl<StudentDocumentCourseCubit>()),
        BlocProvider(create: (context) => di.sl<StudentSearchCourseCubit>()),
        BlocProvider(create: (context) => di.sl<StudentQuizCubit>()),
        BlocProvider(create: (context) => di.sl<StudentAssessmentCubit>()),
        BlocProvider(create: (context) => di.sl<ProfileCubit>()),
        BlocProvider(create: (context) => di.sl<CommunicationCubit>()),
        BlocProvider(create: (context) => di.sl<ShowStudentTeacherCubit>()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('ar', ''),
              Locale('en', ''),
            ],
            locale: const Locale('en'),
            debugShowCheckedModeBanner: false,
            title: 'Edu Sphere App',
            onGenerateRoute: appRouter.generateRoute,
            theme: ThemeData(
              primaryColor: ColorsManager.mainBlue,
            ),
            initialRoute:_getInitialRoute(context),//Routes.showStudentQuizPage,// ,
            routes: {
              Routes.courseMainScreen: (context) => const CourseMainScreen(),
            },
          );
        },
        child: const Placeholder(),
      ),
    );
  }

  String _getInitialRoute(BuildContext context){
    if (isShowOnBoarding) {
      if (isUserLogIn) {
        if (isUserLogIn) {
          return typeUser.toUpperCase() == 'STUDENT' ? Routes.studentMainPage : Routes.teacherMainScreen;
        } else {
          return Routes.loginScreen;
        }
      } else {
        return Routes.loginScreen;
      }
    } else {
      return Routes.onBoardingScreen;
    }
  }
}
