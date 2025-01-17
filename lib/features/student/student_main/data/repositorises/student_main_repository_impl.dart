import 'package:dartz/dartz.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/features/student/student_main/data/datasources/student_main_local_data_source.dart';
import 'package:edu_sphere/features/student/student_main/data/datasources/student_main_remote_data_source.dart';
import 'package:edu_sphere/features/student/student_main/domain/repositorises/repository.dart';
import 'package:edu_sphere/features/teacher/assessments/domain/entities/document_assessment.dart';
import 'package:edu_sphere/features/teacher/course_main/domain/entities/advertisement.dart';
import 'package:edu_sphere/features/teacher/course_main/domain/entities/lecture.dart';
import 'package:edu_sphere/features/teacher/teacher_main/domain/entities/course.dart';
import 'package:logger/logger.dart';

import '../../../../../core/error/exception.dart';
import '../../../../../core/helpers/constants.dart';
import '../../../../../core/helpers/shared_pref_helper.dart';
import '../../../../../core/networking/network_info.dart';

class StudentMainRepositoryImpl implements StudentMainRepository{
  final NetworkInfo networkInfo;
  final StudentMainLocalDataSource localDataSource;
  final StudentMainRemoteDataSource remoteDataSource;
  StudentMainRepositoryImpl({required this.remoteDataSource,required this.localDataSource,required this.networkInfo});

  @override
  Future<Either<Failure, List<Advertisement>>> getAllStudentAdvertisement({required int idCourse}) async{
    if(await networkInfo.isConnected){
      try{
        final String token = await SharedPrefHelper.getString(SharedPrefKeys.cachedToken);
        final listAdvertisement = await remoteDataSource.getAllStudentAdvertisementCourse(idCourse: idCourse, token: token);
        return Right(listAdvertisement);
      }on ServerException{
        return Left(ServerFailure());
      }
    }else{
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, List<Course>>> getAllStudentCourses()async {
    if(await networkInfo.isConnected){
      try{
        final String token = await SharedPrefHelper.getString(SharedPrefKeys.cachedToken);
        Logger().t('token -----> $token');
        final listCourses = await remoteDataSource.getAllStudentCourses(token: token);
        return Right(listCourses);

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
  Future<Either<Failure, List<Course>>> getAllSubscribeStudentCourses() async{
    if(await networkInfo.isConnected){
      try{
        final String token = await SharedPrefHelper.getString(SharedPrefKeys.cachedToken);
        Logger().t('token -----> $token');
        final listCourses = await remoteDataSource.getAllSubscribeStudentCourses(token: token);
        await localDataSource.saveStudentCourses(listCourses: listCourses);
        return Right(listCourses);

      }on InvalidDataException{
        return Left(InvalidDataFailure());
      }on ServerException{
        return Left(ServerFailure());
      }
    }else{
      try {
        List<Course> courses = await localDataSource.getLocalStudentCourses();
        return Right(courses);
      } on EmptyCacheException {
        return Left(OfflineFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<Lecture>>> getAllStudentLecture({required int idCourse}) async{
    if(await networkInfo.isConnected){
      try{
        final String token = await SharedPrefHelper.getString(SharedPrefKeys.cachedToken);
        final listLecture = await remoteDataSource.getAllStudentLectureCourse(idCourse: idCourse, token: token);
        return Right(listLecture);
      }on ServerException{
        return Left(ServerFailure());
      }
    }else{
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, List<DocumentAssessment>>> getAllStudentDocumentCourse({required int idCourse}) async{
    if(await networkInfo.isConnected){
      try{
        final String token = await SharedPrefHelper.getString(SharedPrefKeys.cachedToken);
        final listDocument = await remoteDataSource.getAllStudentDocumentCourse(idCourse: idCourse, token: token);
        return Right(listDocument);
      }on ServerException{
        return Left(ServerFailure());
      }
    }else{
      return Left(OfflineFailure());
    }
  }



  @override
  Future<Either<Failure, Unit>> subscribeStudentCourse({required int idCourse})async {
    if(await networkInfo.isConnected){
      try{
        final String token = await SharedPrefHelper.getString(SharedPrefKeys.cachedToken);
        await remoteDataSource.subscribeStudentCourse(idCourse: idCourse, token: token);
        return Right(unit);
      }on ServerException{
        return Left(ServerFailure());
      }
    }else{
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> leaveStudentCourse({required int idCourse}) async{
    if(await networkInfo.isConnected){
      try{
        final String token = await SharedPrefHelper.getString(SharedPrefKeys.cachedToken);
        await remoteDataSource.subscribeStudentCourse(idCourse: idCourse, token: token);
        return Right(unit);
      }on ServerException{
        return Left(ServerFailure());
      }
    }else{
      return Left(OfflineFailure());
    }
  }

}