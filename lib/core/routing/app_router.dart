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
import 'package:edu_sphere/features/student/assessment_student/presesntations/pages/student_assessment_page.dart';
import 'package:edu_sphere/features/student/student_main/presentations/pages/add_course_student_search.dart';
import 'package:edu_sphere/features/student/student_main/presentations/pages/course_student_main_screen.dart';
import 'package:edu_sphere/features/student/student_main/presentations/pages/student_main_page.dart';
import 'package:edu_sphere/features/student/student_quiz/presentation/pages/review_student_quiz_page.dart';
import 'package:edu_sphere/features/student/student_quiz/presentation/pages/show_student_quiz_page.dart';
import 'package:edu_sphere/features/student/student_quiz/presentation/pages/student_quiz_main_page.dart';
import 'package:edu_sphere/features/teacher/assessments/presentation/pages/assessments_page.dart';
import 'package:edu_sphere/features/teacher/assessments/presentation/pages/estimate_assessment_page.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/pages/course_main_screen.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/widgets/lecture_widgets/show_video_widget.dart';
import 'package:edu_sphere/features/teacher/quiz/presentation/pages/estimate_quiz_page.dart';
import 'package:edu_sphere/features/teacher/quiz/presentation/pages/quiz_main_page.dart';
import 'package:edu_sphere/features/teacher/assessments/presentation/pages/show_review_assessment_page.dart';
import 'package:edu_sphere/features/teacher/quiz/presentation/pages/show_review_quiz_page.dart';
import 'package:edu_sphere/features/teacher/teacher_main/presentation/pages/teacher_main_screen.dart';
import 'package:flutter/material.dart';

import '../../features/profile/presentation/pages/accept_request_student_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/profile/presentation/pages/requests_teacher_page.dart';

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
      case Routes.reviewStudentQuizPage:
        return MaterialPageRoute(builder: (_) => ReviewStudentQuizPage());
      case Routes.studentAssessmentPage:
        return MaterialPageRoute(builder: (_) => StudentAssessmentPage());
      case Routes.estimateQuizPage:
        return MaterialPageRoute(builder: (_) => EstimateQuizPage());
      case Routes.studentMainPage:
        return MaterialPageRoute(builder: (_) => StudentMainPage());
      case Routes.addCourseStudentSearch:
        return MaterialPageRoute(builder: (_) => AddCourseStudentSearch());
      case Routes.showReviewQuizPage:
        return MaterialPageRoute(builder: (_) => ShowReviewQuizPage());
      case Routes.showReviewAssessmentPage:
        return MaterialPageRoute(builder: (_) => ShowReviewAssessmentPage());
      case Routes.acceptRequestStudentPage:
        return MaterialPageRoute(builder: (_) => AcceptRequestStudentPage());
      case Routes.requestsTeacherPage:
        return MaterialPageRoute(builder: (_) => RequestsTeacherPage());
      case Routes.profilePage:
        return MaterialPageRoute(builder: (_) => ProfilePage());
      case Routes.quizMainPage:
        return MaterialPageRoute(builder: (_) => QuizMainPage());
      case Routes.signUpStudentOrTeacherPage:
        return MaterialPageRoute(builder: (_) =>const SignUpStudentOrTeacherPage());
      case Routes.studentRequestPage:
        return MaterialPageRoute(builder: (_) =>const StudentRequestPage());
      case Routes.verifyPasswordScreen:
        return MaterialPageRoute(builder: (_) => VerifyPasswordScreen());
      case Routes.courseStudentMainScreen:
        return MaterialPageRoute(builder: (_) => CourseStudentMainScreen());
      case Routes.courseMainScreen:
        return MaterialPageRoute(builder: (_) =>const CourseMainScreen());
      case Routes.showVideoWidget:
        return MaterialPageRoute(builder: (_) => ShowVideoWidget());
      case Routes.assessmentsPage:
        return MaterialPageRoute(builder: (_) => AssessmentsPage());
      case Routes.estimateAssessmentPage:
        return MaterialPageRoute(builder: (_) => EstimateAssessmentPage());
      case Routes.showStudentQuizPage:
        return MaterialPageRoute(builder: (_) => ShowStudentQuizPage());
      case Routes.studentQuizMainPage:
        return MaterialPageRoute(builder: (_) => StudentQuizMainPage());
      case Routes.teacherMainScreen:
        return MaterialPageRoute(
          builder: (_) =>  TeacherMainScreen()
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
