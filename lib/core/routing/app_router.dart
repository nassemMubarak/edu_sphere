import 'package:edu_sphere/core/routing/routes.dart';
import 'package:edu_sphere/features/auth/presentation/pages/login_screen.dart';
import 'package:edu_sphere/features/auth/presentation/pages/forget_password_screen.dart';
import 'package:edu_sphere/features/auth/presentation/pages/reset_password_screen.dart';
import 'package:edu_sphere/features/auth/presentation/pages/sign_up_student_or_teacher_page.dart';
import 'package:edu_sphere/features/auth/presentation/pages/student_request_page.dart';
import 'package:edu_sphere/features/auth/presentation/pages/verify_password_screen.dart';
import 'package:edu_sphere/features/auth/presentation/widgets/signup_widgets/sign_up_or_student_teacher_widget.dart';
import 'package:edu_sphere/features/auth/presentation/widgets/student_request_widget.dart';
import 'package:edu_sphere/features/onboarding/ui/onboarding_screen.dart';
import 'package:edu_sphere/features/auth/presentation/pages/signup_screen.dart';
import 'package:edu_sphere/features/teacher/assessments/presentation/pages/assessments_page.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/pages/course_main_screen.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/widgets/lecture_widgets/show_video_widget.dart';
import 'package:edu_sphere/features/teacher/quiz/presentation/pages/estimate_quiz_page.dart';
import 'package:edu_sphere/features/teacher/quiz/presentation/pages/quiz_main_page.dart';
import 'package:edu_sphere/features/teacher/quiz/presentation/pages/show_review_quiz_page.dart';
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
      case Routes.estimateQuizPage:
        return MaterialPageRoute(builder: (_) => EstimateQuizPage());
      case Routes.showReviewQuizPage:
        return MaterialPageRoute(builder: (_) => ShowReviewQuizPage());
      case Routes.quizMainPage:
        return MaterialPageRoute(builder: (_) => QuizMainPage());
      case Routes.signUpStudentOrTeacherPage:
        return MaterialPageRoute(builder: (_) =>const SignUpStudentOrTeacherPage());
      case Routes.studentRequestPage:
        return MaterialPageRoute(builder: (_) =>const StudentRequestPage());
      case Routes.verifyPasswordScreen:
        return MaterialPageRoute(builder: (_) => VerifyPasswordScreen());
      case Routes.courseMainScreen:
        return MaterialPageRoute(builder: (_) =>const CourseMainScreen());
      case Routes.showVideoWidget:
        return MaterialPageRoute(builder: (_) => ShowVideoWidget());
      case Routes.assessmentsPage:
        return MaterialPageRoute(builder: (_) => AssessmentsPage());
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
