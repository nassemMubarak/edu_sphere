import 'package:dartz/dartz.dart';
import 'package:edu_sphere/core/error/exception.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/core/networking/network_info.dart';
import 'package:edu_sphere/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:edu_sphere/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:edu_sphere/features/auth/data/models/user_model.dart';
import 'package:edu_sphere/features/auth/domain/entities/admin.dart';
import 'package:edu_sphere/features/auth/domain/entities/camp.dart';
import 'package:edu_sphere/features/auth/domain/entities/user.dart';
import 'package:edu_sphere/features/auth/domain/repositorises/repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';

import '../../../../core/helpers/constants.dart';
import '../../../../core/helpers/shared_pref_helper.dart';

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
        await localDataSource.saveToken(token: user.token);
        await localDataSource.saveUserType(type: user.type??' ');
        await localDataSource.saveUser(userModel: user);

        return Right(user);
      } on InvalidDataExceptionMessage catch (e){
        return Left(InvalidDataFailureMessage(message:e.message ));
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
        await localDataSource.saveToken(token: user.token);
        await localDataSource.saveUserType(type: user.type??' ');
        await localDataSource.saveUser(userModel: user);
        return Right(user);
      }on InvalidDataExceptionMessage catch (e){
        return Left(InvalidDataFailureMessage(message:e.message ));
      }on ServerException{
        return Left(ServerFailure());
      }
    }else{
      return Left(OfflineFailure());
    }
  }
  @override
  Future<Either<Failure, List<Camp>>> getAllCamp() async{
    if(await networkInfo.isConnected){
      try{
        final listCamp = await remoteDataSource.getAllCamp();
        return Right(listCamp);
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

  @override
  Future<Either<Failure, Admin>> loginAdmin({required Map authData}) {
    // TODO: implement loginAdmin
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Admin>> registerAdmin({required Map authData}) async{
    if(await networkInfo.isConnected){
      try{
        final admin = await remoteDataSource.registerAdmin(authData: authData);
        // await localDataSource.saveToken(token: user.token);
        // await localDataSource.saveUserType(type: user.type??' ');
        // await localDataSource.saveUser(userModel: user);
        return Right(admin);
      }on InvalidDataExceptionMessage catch (e){
        return Left(InvalidDataFailureMessage(message:e.message ));
      }on ServerException{
        return Left(ServerFailure());
      }
    }else{
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Camp>> showCamp() async{
    if(await networkInfo.isConnected){
      try{
        final String token = await SharedPrefHelper.getString(SharedPrefKeys.cachedToken);
        final String type = await SharedPrefHelper.getString(SharedPrefKeys.cachedTypeUser);
        final camp = await remoteDataSource.showCamp(token: token,isStudent:type.toUpperCase()=='STUDENT' );
        return Right(camp);
      }on ServerException{
        return Left(ServerFailure());
      }
    }else{
      return Left(OfflineFailure());
    }
  }



}