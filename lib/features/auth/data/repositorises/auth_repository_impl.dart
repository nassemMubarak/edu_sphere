import 'package:dartz/dartz.dart';
import 'package:edu_sphere/core/error/exception.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/core/networking/network_info.dart';
import 'package:edu_sphere/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:edu_sphere/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:edu_sphere/features/auth/data/models/user_model.dart';
import 'package:edu_sphere/features/auth/domain/entities/user.dart';
import 'package:edu_sphere/features/auth/domain/repositorises/repository.dart';

class RepositoryImpl implements AuthRepository {
  final AuthLocalDataSource localDataSource;
  final AuthRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  RepositoryImpl(
      {required this.localDataSource, required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    try {
      UserModel userModel = await localDataSource.getCurrentUser();
      return Right(userModel);
    } on EmptyCacheException {
      return left(EmptyCacheFailure());
    }
  }

  @override
  Future<Either<Failure, User>> loginUser({required Map authData}) async {
    if (await networkInfo.isConnected) {
      try {
        final user = await remoteDataSource.loginUser(authData: authData);
        await localDataSource.saveUser(userModel: user);
        return Right(user);
      } on InvalidDataException{
        return Left(InvalidDataFailure());
      } on ServerException{
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
  @override
  Future<Either<Failure, User>> registerUser({required Map authData}) async{
    if(await networkInfo.isConnected){
      try{
        final user = await remoteDataSource.registerUser(authData: authData);
        await localDataSource.saveUser(userModel: user);
        return Right(user);
      }on InvalidDataException{
        return Left(InvalidDataFailure());
      }on ServerException{
        return Left(ServerFailure());
      }
    }else{
      return Left(OfflineFailure());
    }
  }
  @override
  Future<Either<Failure, Unit>> codeCheckForgetPassword(
      {required String code}) {
    // TODO: implement codeCheckForgetPassword
    throw UnimplementedError();
  }


  @override
  Future<Either<Failure, Unit>> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }



  @override
  Future<Either<Failure, Unit>> sendCodeToForgetPassword(
      {required String email}) {
    // TODO: implement sendCodeToForgetPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> updatePassword({required String password}) {
    // TODO: implement updatePassword
    throw UnimplementedError();
  }

}