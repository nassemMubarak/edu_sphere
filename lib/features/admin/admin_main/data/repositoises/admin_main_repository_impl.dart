import 'package:dartz/dartz.dart';
import 'package:edu_sphere/core/error/exception.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/core/helpers/constants.dart';
import 'package:edu_sphere/core/helpers/shared_pref_helper.dart';
import 'package:edu_sphere/core/networking/network_info.dart';
import 'package:edu_sphere/features/admin/admin_main/data/datasource/admin_main_remote_datasource.dart';
import 'package:edu_sphere/features/admin/admin_main/domain/repositorises/admin_main_repository.dart';
import 'package:edu_sphere/features/auth/domain/entities/user.dart';

class AdminMainRepositoryImpl implements AdminMainRepository{
  final NetworkInfo networkInfo;
  final AdminMainRemoteDataSource remoteDataSource;
  AdminMainRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource
  });
  @override
  Future<Either<Failure, List<User>>> getAllTeacherInAdmin()async {
    if(await networkInfo.isConnected){
      try{
        final String token = await SharedPrefHelper.getString(SharedPrefKeys.cachedToken);
        final listCommunication = await remoteDataSource.getAllTeacherInAdmin( token: token);
        return Right(listCommunication);
      }on InvalidDataExceptionMessage catch (e){
        return Left(InvalidDataFailureMessage(message:e.message ));
      }
    }else{
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, List<User>>> getAllStudentInAdmin() async{
    if(await networkInfo.isConnected){
      try{
        final String token = await SharedPrefHelper.getString(SharedPrefKeys.cachedToken);
        final listCommunication = await remoteDataSource.getAllStudentInAdmin( token: token);
        return Right(listCommunication);
      }on InvalidDataExceptionMessage catch (e){
        return Left(InvalidDataFailureMessage(message:e.message));
      }
    }else{
      return Left(OfflineFailure());
    }
  }
}