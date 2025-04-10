import 'package:edu_sphere/core/routing/routes.dart';
import 'package:edu_sphere/features/admin/admin_main/presentation/pages/admin_main_page.dart';
import 'package:edu_sphere/features/admin/camp_subscription/presentation/pages/camp_subscribe_page.dart';
import 'package:edu_sphere/features/admin/camp_subscription/presentation/pages/contact_us_subscribe_page.dart';
import 'package:edu_sphere/features/admin/requests_admin/presentation/pages/accept_or_reject_request_page.dart';
import 'package:edu_sphere/features/admin/requests_admin/presentation/pages/request_admin_main_page.dart';
import 'package:edu_sphere/features/admin/student_main/presintation/pages/information_student_admin_page.dart';
import 'package:edu_sphere/features/admin/teacher_admin/presintation/pages/information_teacher_page.dart';
import 'package:edu_sphere/features/admin/teacher_admin/presintation/pages/show_course_teacher_page.dart';
import 'package:edu_sphere/features/auth/presentation/pages/login_screen.dart';
import 'package:edu_sphere/features/auth/presentation/pages/forget_password_screen.dart';
import 'package:edu_sphere/features/auth/presentation/pages/reset_password_screen.dart';
import 'package:edu_sphere/features/auth/presentation/pages/sign_up_student_or_teacher_page.dart';
import 'package:edu_sphere/features/auth/presentation/pages/student_request_page.dart';
import 'package:edu_sphere/features/auth/presentation/pages/verify_password_screen.dart';
import 'package:edu_sphere/features/auth/presentation/widgets/signup_widgets/sign_up_or_student_teacher_widget.dart';
import 'package:edu_sphere/features/auth/presentation/widgets/student_request_widget.dart';
import 'package:edu_sphere/features/communication/presentation/pages/communication_main_page.dart';
import 'package:edu_sphere/features/onboarding/ui/onboarding_screen.dart';
import 'package:edu_sphere/features/auth/presentation/pages/signup_screen.dart';
import 'package:edu_sphere/features/profile/presentation/pages/contact_us_page.dart';
import 'package:edu_sphere/features/student/assessment_student/presesntations/pages/student_assessment_page.dart';
import 'package:edu_sphere/features/student/estimates_students/presentations/pages/estimate_student_main_page.dart';
import 'package:edu_sphere/features/student/estimates_students/presentations/pages/show_grade_course_page.dart';
import 'package:edu_sphere/features/student/show_studetn_course_teachers/presentations/pages/show_student_detail_teacher_main_page.dart';
import 'package:edu_sphere/features/student/show_studetn_course_teachers/presentations/pages/show_student_teacher_main_page.dart';
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
      case Routes.informationStudentAdminPage:
        return MaterialPageRoute(builder: (_) => InformationStudentAdminPage());
      case Routes.requestAdminMainPage:
        return MaterialPageRoute(builder: (_) => RequestAdminMainPage());
      case Routes.adminMainPage:
        return MaterialPageRoute(builder: (_) => AdminMainPage());
      case Routes.informationTeacherPage:
        return MaterialPageRoute(builder: (_) => InformationTeacherPage());
      case Routes.showCourseTeacherPage:
        return MaterialPageRoute(builder: (_) => ShowCourseTeacherPage());
      case Routes.acceptOrRejectRequestPage:
        return MaterialPageRoute(builder: (_) => AcceptOrRejectRequestPage());
      case Routes.campSubscribePage:
        return MaterialPageRoute(builder: (_) => CampSubscribePage());
      case Routes.showStudentTeacherMainPage:
        return MaterialPageRoute(builder: (_) => ShowStudentTeacherMainPage());
      case Routes.showStudentDetailTeacherMainPage:
        return MaterialPageRoute(builder: (_) => ShowStudentDetailTeacherMainPage());
      case Routes.showGradeCoursePage:
        return MaterialPageRoute(builder: (_) => ShowGradeCoursePage());
      case Routes.estimateStudentMainPage:
        return MaterialPageRoute(builder: (_) => EstimateStudentMainPage());
      case Routes.communicationMainPage:
        return MaterialPageRoute(builder: (_) => CommunicationMainPage());
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
      case Routes.contactUsSubscribePage:
        return MaterialPageRoute(builder: (_) => ContactUsSubscribePage());
      case Routes.contactUsPage:
        return MaterialPageRoute(builder: (_) => ContactUsPage());
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
