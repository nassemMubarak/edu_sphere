import 'package:dartz/dartz.dart';
import 'package:edu_sphere/core/error/exception.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/core/helpers/constants.dart';
import 'package:edu_sphere/core/helpers/shared_pref_helper.dart';
import 'package:edu_sphere/core/networking/network_info.dart';
import 'package:edu_sphere/features/teacher/teacher_main/data/datasources/teacher_main_local_data_source.dart';
import 'package:edu_sphere/features/teacher/teacher_main/data/datasources/teacher_main_remote_data_source.dart';
import 'package:edu_sphere/features/teacher/teacher_main/domain/entities/course.dart';
import 'package:edu_sphere/features/teacher/teacher_main/domain/repository/repository.dart';
import 'package:logger/logger.dart';

class TeacherMainRepositoryImpl implements TeacherMainRepository{
  final NetworkInfo networkInfo;
  final TeacherMainLocalDataSource teacherMainLocalDataSource;
  final TeacherMainRemoteDataSource teacherMainRemoteDataSource;
  TeacherMainRepositoryImpl({required this.networkInfo,required this.teacherMainLocalDataSource,required this.teacherMainRemoteDataSource});

  @override
  Future<Either<Failure, List<Course>>> getAllCourses() async{
    if(await networkInfo.isConnected){
          try{
              final String token = await SharedPrefHelper.getString(SharedPrefKeys.cachedToken);
              Logger().t('token -----> $token');
              final listCourses = await teacherMainRemoteDataSource.getAllCourses(token: token);
              await teacherMainLocalDataSource.saveCourses(listCourses: listCourses);
              return Right(listCourses);

          }on InvalidDataException{
            return Left(InvalidDataFailure());
          }on ServerException{
            return Left(ServerFailure());
          }
    }else{
      try {
        List<Course> courses = await teacherMainLocalDataSource.getLocalCourses();
        return Right(courses);
      } on EmptyCacheException {
        return Left(OfflineFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Course>> addCourse({required Map courseData}) async{
    if(await networkInfo.isConnected){
      try{
        final String token = await SharedPrefHelper.getString(SharedPrefKeys.cachedToken);
        Logger().t('token -----> $token');
        final course = await teacherMainRemoteDataSource.addCourse(courseData: courseData,token: token);
        return Right(course);
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
  Future<Either<Failure, Unit>> deleteCourse({required int id}) async{
    if(await networkInfo.isConnected){
      try{
        final String token = await SharedPrefHelper.getString(SharedPrefKeys.cachedToken);
        Logger().t('token -----> $token');
         await teacherMainRemoteDataSource.deleteCourse(id: id, token: token);
        return Right(unit);
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
  Future<Either<Failure, Unit>> updateCourse({required Map courseData,required int id})async {
    if(await networkInfo.isConnected){
      try{
        final String token = await SharedPrefHelper.getString(SharedPrefKeys.cachedToken);
        Logger().t('token -----> $token');
        await teacherMainRemoteDataSource.updateCourse(courseData: courseData,id: id, token: token);
        return Right(unit);
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