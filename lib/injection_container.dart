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

GetIt sl = GetIt.instance;
Future<void> init() async {
  ///Feature Auth
  // Bloc
  sl.registerFactory(()=>AuthCubit(registerUserUseCase: sl(),loginUserUseCase: sl(), getCurrentUserUseCase: sl(),getAllCampUserUseCase: sl()));
  //feature teacher main
  sl.registerFactory(()=>TeacherMainCubit(addCourseUseCase: sl(), deleteCourseUseCase: sl(), getAllCoursesUseCase: sl(), updateCourseUseCase: sl()));

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
  // Repository
  sl.registerLazySingleton<AuthRepository>(()=>RepositoryImpl(localDataSource: sl(), remoteDataSource: sl(), networkInfo: sl()));
  //feature teacher main
  sl.registerLazySingleton<TeacherMainRepository>(()=>TeacherMainRepositoryImpl(networkInfo: sl(), teacherMainLocalDataSource: sl(), teacherMainRemoteDataSource: sl()));

  // Data Sources

  sl.registerLazySingleton<AuthLocalDataSource>(()=>AuthLocalDataSourceImpl());
  sl.registerLazySingleton<AuthRemoteDataSource>(()=>AuthRemoteDataSourceImpl(client: sl()));
  //feature teacher main
  sl.registerLazySingleton<TeacherMainLocalDataSource>(()=>TeacherMainLocalDataSourceImpl());
  sl.registerLazySingleton<TeacherMainRemoteDataSource>(()=>TeacherMainRemoteDataSourceImpl(client: sl()));
  // Network
  sl.registerLazySingleton<NetworkInfo>(()=>NetworkInfoImpl(connectionChecker: sl()));

  // External
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());

}