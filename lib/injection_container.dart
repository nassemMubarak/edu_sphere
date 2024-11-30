import 'package:edu_sphere/core/helpers/shared_pref_helper.dart';
import 'package:edu_sphere/core/networking/network_info.dart';
import 'package:edu_sphere/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:edu_sphere/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:edu_sphere/features/auth/data/repositorises/auth_repository_impl.dart';
import 'package:edu_sphere/features/auth/domain/repositorises/repository.dart';
import 'package:edu_sphere/features/auth/domain/usecases/code_check_forget_password.dart';
import 'package:edu_sphere/features/auth/domain/usecases/get_current_user.dart';
import 'package:edu_sphere/features/auth/domain/usecases/login_user.dart';
import 'package:edu_sphere/features/auth/domain/usecases/logout.dart';
import 'package:edu_sphere/features/auth/domain/usecases/register_user.dart';
import 'package:edu_sphere/features/auth/domain/usecases/send_code_to_forget_password.dart';
import 'package:edu_sphere/features/auth/domain/usecases/update_password.dart';
import 'package:edu_sphere/features/auth/presentation/bloc/auth/auth_cubit.dart';
import 'package:get_it/get_it.dart';
GetIt sl = GetIt.instance;
Future<void> init() async {
  ///Feature Auth
  // Bloc
  sl.registerFactory(()=>AuthCubit(loginUserUseCase: sl(), getCurrentUserUseCase: sl()));

  // Use Cases
  sl.registerLazySingleton(()=>CodeCheckForgetPasswordUseCase(authRepository: sl()));
  sl.registerLazySingleton(()=>GetCurrentUserUseCase(repository: sl()));
  sl.registerLazySingleton(()=>LoginUserUseCase(repository: sl()));
  sl.registerLazySingleton(()=>LogoutUseCase(repository: sl()));
  sl.registerLazySingleton(()=>RegisterUserUseCase(repository: sl()));
  sl.registerLazySingleton(()=>SendCodeToForgetPasswordUseCase(authRepository: sl()));
  sl.registerLazySingleton(()=>UpdatePasswordUseCase(repository: sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(()=>RepositoryImpl(localDataSource: sl(), remoteDataSource: sl(), networkInfo: sl()));

  // Data Sources

  sl.registerLazySingleton<AuthLocalDataSource>(()=>AuthLocalDataSourceImpl());
  sl.registerLazySingleton<AuthRemoteDataSource>(()=>AuthRemoteDataSourceImpl(client: sl()));

  // Network
  sl.registerLazySingleton<NetworkInfo>(()=>NetworkInfoImpl(connectionChecker: sl()));

  // External


}