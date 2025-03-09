
import 'package:dartz/dartz.dart';
import 'package:edu_sphere/core/error/exception.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/core/helpers/constants.dart';
import 'package:edu_sphere/core/helpers/shared_pref_helper.dart';
import 'package:edu_sphere/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:edu_sphere/features/auth/data/models/user_model.dart';
import 'package:edu_sphere/features/auth/domain/entities/user.dart';
import 'package:edu_sphere/features/profile/data/datasource/profile_local_data_source.dart';
import 'package:edu_sphere/features/profile/data/datasource/profile_remote_datasource.dart';
import 'package:edu_sphere/features/profile/domain/repositorises/profile_repository.dart';
import 'package:logger/logger.dart';

import '../../../../core/networking/network_info.dart';

class ProfileRepositoryImpl implements ProfileRepository{
  final NetworkInfo networkInfo;
  final ProfileRemoteDataSource profileRemoteDataSource;
  final ProfileLocalDataSourceImpl profileLocalDataSource;
  ProfileRepositoryImpl({
    required this.profileLocalDataSource,
    required this.networkInfo,
    required this.profileRemoteDataSource

});
  @override
  Future<Either<Failure, User>> getInfoUser()async {
    if(await networkInfo.isConnected){
      try{
        final String token = await SharedPrefHelper.getString(SharedPrefKeys.cachedToken);

        User user = await profileRemoteDataSource.getInfoUser(token: token);
        return  Right(user);
      }on InvalidDataExceptionMessage catch (e) {
        return Left(InvalidDataFailureMessage(message: e.message));
      } on ServerException {
        return Left(ServerFailure());
      }
    }else{
      return Left(OfflineFailure());
    }

  }

  @override
  Future<Either<Failure, User>> updateUser({required Map data,required String type}) async{
    if(await networkInfo.isConnected){
      try{
        final String token = await SharedPrefHelper.getString(SharedPrefKeys.cachedToken);
        UserModel user = await profileRemoteDataSource.updateUser(token: token,data: data,isStudent: type.toUpperCase()=='STUDENT',isAdmin:  type.toUpperCase()=='ADMIN'?true:null);
        user.type = type;
        profileLocalDataSource.saveUser(userModel: user);
        return  Right(user);
      }on InvalidDataExceptionMessage catch (e) {
        return Left(InvalidDataFailureMessage(message: e.message));
      } on ServerException {
        return Left(ServerFailure());
      }
    }else{
      return Left(OfflineFailure());
    }

  }

}