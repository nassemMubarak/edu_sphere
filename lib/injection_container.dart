import 'package:edu_sphere/core/helpers/shared_pref_helper.dart';
import 'package:edu_sphere/core/networking/network_info.dart';
import 'package:edu_sphere/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:edu_sphere/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:edu_sphere/features/auth/data/repositorises/auth_repository_impl.dart';
import 'package:edu_sphere/features/auth/domain/repositorises/repository.dart';
import 'package:edu_sphere/features/auth/domain/usecases/code_check_forget_password.dart';
import 'package:edu_sphere/features/auth/domain/usecases/get_all_camp.dart';
import 'package:edu_sphere/features/auth/domain/usecases/get_current_user.dart';
import 'package:edu_sphere/features/auth/domain/usecases/login_user.dart';
import 'package:edu_sphere/features/auth/domain/usecases/logout.dart';
import 'package:edu_sphere/features/auth/domain/usecases/register_user.dart';
import 'package:edu_sphere/features/auth/domain/usecases/send_code_to_forget_password.dart';
import 'package:edu_sphere/features/auth/domain/usecases/update_password.dart';
import 'package:edu_sphere/features/auth/presentation/bloc/auth/auth_cubit.dart';
import 'package:edu_sphere/features/student/student_main/data/datasources/student_main_local_data_source.dart';
import 'package:edu_sphere/features/student/student_main/data/datasources/student_main_remote_data_source.dart';
import 'package:edu_sphere/features/student/student_main/data/repositorises/student_main_repository_impl.dart';
import 'package:edu_sphere/features/student/student_main/domain/repositorises/repository.dart';
import 'package:edu_sphere/features/student/student_main/domain/usecases/get_all_student_advertisement_course.dart';
import 'package:edu_sphere/features/student/student_main/domain/usecases/get_all_student_courses.dart';
import 'package:edu_sphere/features/student/student_main/domain/usecases/get_all_student_document_course.dart';
import 'package:edu_sphere/features/student/student_main/domain/usecases/get_all_student_lecture_course.dart';
import 'package:edu_sphere/features/student/student_main/domain/usecases/get_all_subscribe_student_courses.dart';
import 'package:edu_sphere/features/student/student_main/domain/usecases/leave_student_course.dart';
import 'package:edu_sphere/features/student/student_main/domain/usecases/subscribe_student_course.dart';
import 'package:edu_sphere/features/student/student_main/presentations/bloc/student_advertisements/student_advertisements_cubit.dart';
import 'package:edu_sphere/features/student/student_main/presentations/bloc/student_document_course/student_document_course_cubit.dart';
import 'package:edu_sphere/features/student/student_main/presentations/bloc/student_lecture/student_lecture_cubit.dart';
import 'package:edu_sphere/features/student/student_main/presentations/bloc/student_search_course/student_search_course_cubit.dart';
import 'package:edu_sphere/features/student/student_main/presentations/bloc/subscribe_student_courses/subscribe_student_courses_cubit.dart';
import 'package:edu_sphere/features/student/student_quiz/data/datasources/student_quiz_remote_data_source.dart';
import 'package:edu_sphere/features/student/student_quiz/data/repository/student_quiz_repository_impl.dart';
import 'package:edu_sphere/features/student/student_quiz/domain/repositorises/student_quiz_repository.dart';
import 'package:edu_sphere/features/student/student_quiz/domain/usecases/get_all_student_quiz.dart';
import 'package:edu_sphere/features/student/student_quiz/domain/usecases/get_attempt_student_quiz.dart';
import 'package:edu_sphere/features/student/student_quiz/domain/usecases/submit_answer_quiz.dart';
import 'package:edu_sphere/features/student/student_quiz/presentation/bloc/student_quiz_cubit.dart';
import 'package:edu_sphere/features/teacher/assessments/data/datasources/assessment_remote_data_source.dart';
import 'package:edu_sphere/features/teacher/assessments/data/reopsitory/assessment_repository_impl.dart';
import 'package:edu_sphere/features/teacher/assessments/domain/repositorises/assessment_repository.dart';
import 'package:edu_sphere/features/teacher/assessments/domain/usecases/add_assessment.dart';
import 'package:edu_sphere/features/teacher/assessments/domain/usecases/add_document_to_assessment.dart';
import 'package:edu_sphere/features/teacher/assessments/domain/usecases/add_estimate_assessment.dart';
import 'package:edu_sphere/features/teacher/assessments/domain/usecases/delete_assessment.dart';
import 'package:edu_sphere/features/teacher/assessments/domain/usecases/delete_document_to_assessment.dart';
import 'package:edu_sphere/features/teacher/assessments/domain/usecases/download_document_to_assessment.dart';
import 'package:edu_sphere/features/teacher/assessments/domain/usecases/get_all_assessment.dart';
import 'package:edu_sphere/features/teacher/assessments/domain/usecases/get_all_estimate_assessment.dart';
import 'package:edu_sphere/features/teacher/assessments/domain/usecases/update_assessment.dart';
import 'package:edu_sphere/features/teacher/assessments/presentation/bloc/assessments_cubit.dart';
import 'package:edu_sphere/features/teacher/course_main/data/datasources/course_main_local_data_source.dart';
import 'package:edu_sphere/features/teacher/course_main/data/datasources/course_main_remote_data_source.dart';
import 'package:edu_sphere/features/teacher/course_main/data/repositores/course_main_repository_impl.dart';
import 'package:edu_sphere/features/teacher/course_main/domain/repositorises/repository.dart';
import 'package:edu_sphere/features/teacher/course_main/domain/usecases/advertisement_usecase/add_advertisement.dart';
import 'package:edu_sphere/features/teacher/course_main/domain/usecases/advertisement_usecase/delete_advertisement.dart';
import 'package:edu_sphere/features/teacher/course_main/domain/usecases/advertisement_usecase/get_all_advertisement.dart';
import 'package:edu_sphere/features/teacher/course_main/domain/usecases/advertisement_usecase/update_advertisement.dart';
import 'package:edu_sphere/features/teacher/course_main/domain/usecases/document_to_course/get_all_document_to_course.dart';
import 'package:edu_sphere/features/teacher/course_main/domain/usecases/lecture_usecase/add_lecture.dart';
import 'package:edu_sphere/features/teacher/course_main/domain/usecases/lecture_usecase/delete_lecture.dart';
import 'package:edu_sphere/features/teacher/course_main/domain/usecases/lecture_usecase/get_all_lecture.dart';
import 'package:edu_sphere/features/teacher/course_main/domain/usecases/lecture_usecase/update_lecture.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/bloc/course_advertisement/course_advertisement_cubit.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/bloc/course_lecture/course_lecture_cubit.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/bloc/document_course/document_course_cubit.dart';
import 'package:edu_sphere/features/teacher/quiz/data/datasources/quiz_remote_data_source.dart';
import 'package:edu_sphere/features/teacher/quiz/data/repository/quiz_repository_impl.dart';
import 'package:edu_sphere/features/teacher/quiz/domain/repositorises/quiz_repository.dart';
import 'package:edu_sphere/features/teacher/quiz/domain/usecases/add_quiz.dart';
import 'package:edu_sphere/features/teacher/quiz/domain/usecases/delete_quiz.dart';
import 'package:edu_sphere/features/teacher/quiz/domain/usecases/get_all_estimate_quiz.dart';
import 'package:edu_sphere/features/teacher/quiz/domain/usecases/get_all_quiz.dart';
import 'package:edu_sphere/features/teacher/quiz/domain/usecases/question_use_cases/add_question.dart';
import 'package:edu_sphere/features/teacher/quiz/domain/usecases/question_use_cases/delete_question.dart';
import 'package:edu_sphere/features/teacher/quiz/domain/usecases/question_use_cases/get_all_question.dart';
import 'package:edu_sphere/features/teacher/quiz/domain/usecases/question_use_cases/update_question.dart';
import 'package:edu_sphere/features/teacher/quiz/domain/usecases/show_estimate_quiz.dart';
import 'package:edu_sphere/features/teacher/quiz/domain/usecases/update_estimate_quiz.dart';
import 'package:edu_sphere/features/teacher/quiz/domain/usecases/update_quiz.dart';
import 'package:edu_sphere/features/teacher/quiz/presentation/bloc/question/question_cubit.dart';
import 'package:edu_sphere/features/teacher/quiz/presentation/bloc/quiz_cubit.dart';
import 'package:edu_sphere/features/teacher/teacher_main/data/datasources/teacher_main_local_data_source.dart';
import 'package:edu_sphere/features/teacher/teacher_main/data/datasources/teacher_main_remote_data_source.dart';
import 'package:edu_sphere/features/teacher/teacher_main/data/repositores/teacher_main_repository_impl.dart';
import 'package:edu_sphere/features/teacher/teacher_main/domain/repository/repository.dart';
import 'package:edu_sphere/features/teacher/teacher_main/domain/usecases/add_course.dart';
import 'package:edu_sphere/features/teacher/teacher_main/domain/usecases/delete_course.dart';
import 'package:edu_sphere/features/teacher/teacher_main/domain/usecases/get_all_courses.dart';
import 'package:edu_sphere/features/teacher/teacher_main/domain/usecases/update_course.dart';
import 'package:edu_sphere/features/teacher/teacher_main/presentation/logic/teacher_main_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:http/http.dart' as http;

import 'features/teacher/course_main/domain/usecases/document_to_course/add_document_to_course.dart';
import 'features/teacher/course_main/domain/usecases/document_to_course/delete_document_to_course.dart';
import 'features/teacher/course_main/domain/usecases/document_to_course/dwonload_document_to_course.dart';

GetIt sl = GetIt.instance;
Future<void> init() async {
  ///Feature Auth
  // Bloc
  sl.registerFactory(()=>AuthCubit(registerUserUseCase: sl(),loginUserUseCase: sl(), getCurrentUserUseCase: sl(),getAllCampUserUseCase: sl()));
  //feature teacher main
  sl.registerFactory(()=>TeacherMainCubit(addCourseUseCase: sl(), deleteCourseUseCase: sl(), getAllCoursesUseCase: sl(), updateCourseUseCase: sl()));
  /// feature course main
    /// Course Advertisement
  sl.registerFactory(()=>CourseAdvertisementCubit(updateAdvertisementUseCase: sl(), addAdvertisementUseCase: sl(), deleteAdvertisementUseCase: sl(), getAllAdvertisementUseCase: sl()));
  /// Course Lecture
  sl.registerFactory(()=>CourseLectureCubit(getAllLectureUseCase: sl(), updateLectureUseCase: sl(), deleteLectureUseCase: sl(), addLectureUseCase: sl()));
    /// Document Course
  sl.registerFactory(()=>DocumentCourseCubit(getAllDocumentToCourseUseCase: sl(), addDocumentToCourseUseCase: sl(), downloadDocumentToCourseUseCase: sl(), deleteDocumentToCourseUseCase: sl()));
  /// quiz
  /// course quiz
  sl.registerFactory(()=>QuizCubit(showEstimateQuizUseCase: sl(),getAllEstimateQuizUseCase: sl(),updateEstimateQuizUseCase: sl(),getAllQuizUseCase: sl(), addQuizUseCase: sl(), updateQuizUseCase: sl(), deleteQuizUseCase: sl()));
  /// question quiz
  sl.registerFactory(()=>QuestionCubit(getAllQuestionUseCase: sl(), addQuestionUseCase: sl(), deleteQuestionUseCase: sl(), updateQuestionUseCase: sl()));
  /// Assessments
  sl.registerFactory(()=>AssessmentsCubit(addEstimateAssessmentUseCase: sl(),getAllEstimateAssessmentUseCase: sl(),downloadDocumentToAssessmentUseCase: sl(),updateAssessmentUseCase: sl(), getAllAssessmentUseCase: sl(), addAssessmentUseCase: sl(), deleteAssessmentUseCase: sl(),addDocumentToAssessmentUseCase: sl(),deleteDocumentToAssessmentUseCase: sl()));
///feature student
  /// get all subscribe course
  sl.registerFactory(()=>SubscribeStudentCoursesCubit(leaveStudentCourseUseCase: sl(),getAllSubscribeStudentCoursesUseCase: sl()));
  sl.registerFactory(()=>StudentAdvertisementsCubit(getAllStudentAdvertisementUseCase: sl()));
  sl.registerFactory(()=>StudentLectureCubit(getAllStudentLectureCourseUseCase: sl()));
  sl.registerFactory(()=>StudentDocumentCourseCubit(getAllStudentDocumentCourseUseCase: sl()));
  sl.registerFactory(()=>StudentSearchCourseCubit(getAllStudentCoursesUseCase: sl(),subscribeStudentCourse: sl()));
  sl.registerFactory(()=>StudentQuizCubit(submitAnswerQuizUseCase: sl(), getAttemptStudentQuizUseCase: sl(), getAllStudentQuizUseCase: sl()));

  // Use Cases
  sl.registerLazySingleton(()=>CodeCheckForgetPasswordUseCase(authRepository: sl()));
  sl.registerLazySingleton(()=>GetCurrentUserUseCase(repository: sl()));
  sl.registerLazySingleton(()=>LoginUserUseCase(repository: sl()));
  sl.registerLazySingleton(()=>LogoutUseCase(repository: sl()));
  sl.registerLazySingleton(()=>RegisterUserUseCase(repository: sl()));
  sl.registerLazySingleton(()=>SendCodeToForgetPasswordUseCase(authRepository: sl()));
  sl.registerLazySingleton(()=>UpdatePasswordUseCase(repository: sl()));
  sl.registerLazySingleton(()=>GetAllCampUseCase(repository: sl()));
  // use case Teacher main Feature
  sl.registerLazySingleton(()=>AddCourseUseCase(repository: sl()));
  sl.registerLazySingleton(()=>DeleteCourseUseCase(repository: sl()));
  sl.registerLazySingleton(()=>GetAllCoursesUseCase(repository: sl()));
  sl.registerLazySingleton(()=>UpdateCourseUseCase(repository: sl()));
  /// use case course main feature
    /// use case Course Advertisement
  sl.registerLazySingleton(()=>AddAdvertisementUseCase(repository: sl()));
  sl.registerLazySingleton(()=>DeleteAdvertisementUseCase(repository: sl()));
  sl.registerLazySingleton(()=>GetAllAdvertisementUseCase(repository: sl()));
  sl.registerLazySingleton(()=>UpdateAdvertisementUseCase(repository: sl()));
    /// Course Lecture
  sl.registerLazySingleton(()=>AddLectureUseCase(repository: sl()));
  sl.registerLazySingleton(()=>DeleteLectureUseCase(repository: sl()));
  sl.registerLazySingleton(()=>GetAllLectureUseCase(repository: sl()));
  sl.registerLazySingleton(()=>UpdateLectureUseCase(repository: sl()));
    /// Course Document
  sl.registerLazySingleton(()=>GetAllDocumentToCourseUseCase(repository: sl()));
  sl.registerLazySingleton(()=>AddDocumentToCourseUseCase(repository: sl()));
  sl.registerLazySingleton(()=>DeleteDocumentToCourseUseCase(repository: sl()));
  sl.registerLazySingleton(()=>DownloadDocumentToCourseUseCase(repository: sl()));

  /// use cases quiz
  sl.registerLazySingleton(()=>GetAllQuizUseCase(repository: sl()));
  sl.registerLazySingleton(()=>AddQuizUseCase(repository: sl()));
  sl.registerLazySingleton(()=>UpdateQuizUseCase(repository: sl()));
  sl.registerLazySingleton(()=>DeleteQuizUseCase(repository: sl()));
  sl.registerLazySingleton(()=>GetAllEstimateQuizUseCase(repository: sl()));
  sl.registerLazySingleton(()=>UpdateEstimateQuizUseCase(repository: sl()));
  sl.registerLazySingleton(()=>ShowEstimateQuizUseCase(repository: sl()));
  /// use cases question quiz
  sl.registerLazySingleton(()=>GetAllQuestionUseCase(repository: sl()));
  sl.registerLazySingleton(()=>AddQuestionUseCase(repository: sl()));
  sl.registerLazySingleton(()=>UpdateQuestionUseCase(repository: sl()));
  sl.registerLazySingleton(()=>DeleteQuestionUseCase(repository: sl()));
  /// use case assessment
  sl.registerLazySingleton(()=>GetAllAssessmentUseCase(repository: sl()));
  sl.registerLazySingleton(()=>AddAssessmentUseCase(repository: sl()));
  sl.registerLazySingleton(()=>UpdateAssessmentUseCase(repository: sl()));
  sl.registerLazySingleton(()=>DeleteAssessmentUseCase(repository: sl()));
  sl.registerLazySingleton(()=>AddDocumentToAssessmentUseCase(repository: sl()));
  sl.registerLazySingleton(()=>DeleteDocumentToAssessmentUseCase(repository: sl()));
  sl.registerLazySingleton(()=>DownloadDocumentToAssessmentUseCase(repository: sl()));
  sl.registerLazySingleton(()=>GetAllEstimateAssessmentUseCase(repository: sl()));
  sl.registerLazySingleton(()=>AddEstimateAssessmentUseCase(repository: sl()));

  ///feature student -> use cases
  sl.registerLazySingleton(()=>GetAllStudentAdvertisementUseCase(repository: sl()));
  sl.registerLazySingleton(()=>GetAllStudentCoursesUseCase(repository: sl()));
  sl.registerLazySingleton(()=>GetAllStudentDocumentCourseUseCase(repository: sl()));
  sl.registerLazySingleton(()=>GetAllStudentLectureCourseUseCase(repository: sl()));
  sl.registerLazySingleton(()=>GetAllSubscribeStudentCoursesUseCase(repository: sl()));
  sl.registerLazySingleton(()=>SubscribeStudentCourse(repository: sl()));
  sl.registerLazySingleton(()=>LeaveStudentCourseUseCase(repository: sl()));
      /// use case student quiz
  sl.registerLazySingleton(()=>GetAllStudentQuizUseCase(repository: sl()));
  sl.registerLazySingleton(()=>GetAttemptStudentQuizUseCase(repository: sl()));
  sl.registerLazySingleton(()=>SubmitAnswerQuizUseCase(repository: sl()));



  // Repository
  sl.registerLazySingleton<AuthRepository>(()=>RepositoryImpl(localDataSource: sl(), remoteDataSource: sl(), networkInfo: sl()));
  //feature teacher main
  sl.registerLazySingleton<TeacherMainRepository>(()=>TeacherMainRepositoryImpl(networkInfo: sl(), teacherMainLocalDataSource: sl(), teacherMainRemoteDataSource: sl()));
  ///  course main feature
  ///  Course Advertisement
  ///  Course Lecture
  sl.registerLazySingleton<CourseMainRepository>(()=>CourseMainRepositoryImpl(networkInfo: sl(), localDataSource: sl(), remoteDataSourceImpl: sl()));
  /// Quiz Repository
  sl.registerLazySingleton<QuizRepository>(()=>QuizRepositoryImpl(networkInfo: sl(), remoteDataSourceImpl: sl()));
  /// assessment repository
  sl.registerLazySingleton<AssessmentRepository>(()=>AssessmentRepositoryImpl(remoteDataSourceImpl: sl(), networkInfo: sl()));
  /// feature student main repository
  sl.registerLazySingleton<StudentMainRepository>(()=>StudentMainRepositoryImpl(remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));
  /// feature student quiz repository
  sl.registerLazySingleton<StudentQuizRepository>(()=>StudentQuizRepositoryImpl(networkInfo: sl(),remoteDataSourceImpl: sl()));



  /// Data Sources

  sl.registerLazySingleton<AuthLocalDataSource>(()=>AuthLocalDataSourceImpl());
  sl.registerLazySingleton<AuthRemoteDataSource>(()=>AuthRemoteDataSourceImpl(client: sl()));
  ///feature teacher main
  sl.registerLazySingleton<TeacherMainLocalDataSource>(()=>TeacherMainLocalDataSourceImpl());
  sl.registerLazySingleton<TeacherMainRemoteDataSource>(()=>TeacherMainRemoteDataSourceImpl(client: sl()));
  /// Data Sources course main feature
  ///  Course Advertisement
  ///  Course Lecture
  sl.registerLazySingleton<CourseMainLocalDataSource>(() => CourseMainLocalDataSourceImpl());
  sl.registerLazySingleton<CourseMainRemoteDataSourceImpl>(() => CourseMainRemoteDataSourceImpl(client: sl()));
  /// feature quiz
  sl.registerLazySingleton<QuizRemoteDataSource>(() => QuizRemoteDataSourceImpl(client: sl()));
  /// feature assessment
  sl.registerLazySingleton<AssessmentRemoteDataSource>(() => AssessmentRemoteDataSourceImpl(client: sl()));
  /// feature student main data sources
  sl.registerLazySingleton<StudentMainLocalDataSource>(()=>StudentMainLocalDataSourceImpl());
  sl.registerLazySingleton<StudentMainRemoteDataSource>(()=>StudentMainRemoteDataSourceImpl(client: sl()));
  /// feature student quiz repository
  sl.registerLazySingleton<StudentQuizRemoteDataSource>(()=>StudentQuizRemoteDataSourceImpl(client: sl()));

  // Network
  sl.registerLazySingleton<NetworkInfo>(()=>NetworkInfoImpl(connectionChecker: sl()));

  // External
  sl.registerLazySingleton<http.Client>(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());

}