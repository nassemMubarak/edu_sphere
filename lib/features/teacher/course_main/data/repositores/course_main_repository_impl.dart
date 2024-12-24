import 'package:dartz/dartz.dart';
import 'package:edu_sphere/core/error/exception.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/core/helpers/constants.dart';
import 'package:edu_sphere/core/helpers/shared_pref_helper.dart';
import 'package:edu_sphere/core/networking/network_info.dart';
import 'package:edu_sphere/features/teacher/course_main/data/datasources/course_main_local_data_source.dart';
import 'package:edu_sphere/features/teacher/course_main/data/datasources/course_main_remote_data_source.dart';
import 'package:edu_sphere/features/teacher/course_main/domain/entities/advertisement.dart';
import 'package:edu_sphere/features/teacher/course_main/domain/repositorises/repository.dart';
import 'package:logger/logger.dart';

class CourseMainRepositoryImpl implements CourseMainRepository{
  final NetworkInfo networkInfo;
  final CourseMainLocalDataSource localDataSource;
  final CourseMainRemoteDataSourceImpl remoteDataSourceImpl;
  CourseMainRepositoryImpl({required this.networkInfo,required this.localDataSource,required this.remoteDataSourceImpl});
  @override
  Future<Either<Failure, List<Advertisement>>> getAllAdvertisement({required int idCourse}) async{
    if(await networkInfo.isConnected){
      try{
        final String token = await SharedPrefHelper.getString(SharedPrefKeys.cachedToken);
        final listAdvertisement = await remoteDataSourceImpl.getAllAdvertisement(idCourse: idCourse, token: token);
        return Right(listAdvertisement);
      }on ServerException{
        return Left(ServerFailure());
      }
    }else{
      return Left(OfflineFailure());
    }
  }
  @override
  Future<Either<Failure, Advertisement>> addAdvertisement({required int idCourse,required Map data}) async{
    if(await networkInfo.isConnected){
      try{

        final String token = await SharedPrefHelper.getString(SharedPrefKeys.cachedToken);
        final advertisement = await remoteDataSourceImpl.addAdvertisement(token: token, data: data, idCourse: idCourse);
        return Right(advertisement);
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
  Future<Either<Failure, Advertisement>> updateAdvertisement({required int idAdvertisement, required int idCourse, required Map data}) async{
    if(await networkInfo.isConnected){
      try{
        final String token = await SharedPrefHelper.getString(SharedPrefKeys.cachedToken);
        final advertisement = await remoteDataSourceImpl.updateAdvertisement(idAdvertisement: idAdvertisement, idCourse: idCourse, data: data, token: token);
        return Right(advertisement);
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
  Future<Either<Failure, Unit>> deleteAdvertisement({required int idAdvertisement, required int idCourse}) async{
    if(await networkInfo.isConnected){
      try{
        final String token = await SharedPrefHelper.getString(SharedPrefKeys.cachedToken);
        final advertisement = await remoteDataSourceImpl.deleteAdvertisement(idAdvertisement: idAdvertisement, idCourse: idCourse, token: token);
        return Right(advertisement);
      }on InvalidDataException{
        return Left(InvalidDataFailure());
      }on ServerException{
        return Left(ServerFailure());
      }
    }else{
      return Left(OfflineFailure());
    }
  }



}