import 'package:dartz/dartz.dart';
import 'package:edu_sphere/core/error/exception.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/core/helpers/constants.dart';
import 'package:edu_sphere/core/helpers/shared_pref_helper.dart';
import 'package:edu_sphere/core/networking/network_info.dart';
import 'package:edu_sphere/features/admin/teacher_admin/data/datasource/teacher_admin_remotedatasource.dart';
import 'package:edu_sphere/features/admin/teacher_admin/domain/entities/show_teacher_courses.dart';
import 'package:edu_sphere/features/admin/teacher_admin/domain/entities/teacher_informstion.dart';
import 'package:edu_sphere/features/admin/teacher_admin/domain/repositorises/teacher_admin_repository.dart';

class TeacherAdminRepositoryImpl implements TeacherAdminRepository{
  final NetworkInfo networkInfo;
  final TeacherAdminRemoteDataSource remoteDataSource;
  TeacherAdminRepositoryImpl({required this.remoteDataSource,required this.networkInfo});
  @override
  Future<Either<Failure, TeacherInformation>> getInformationTeacher({required int idTeacher})async {
    if(await networkInfo.isConnected){
      try{
        final String token = await SharedPrefHelper.getString(SharedPrefKeys.cachedToken);
        final teacherInformation = await remoteDataSource.getTeacherInformationModel(token: token, idTeacher: idTeacher);
        return Right(teacherInformation);
      }on InvalidDataExceptionMessage catch (e){
        return Left(InvalidDataFailureMessage(message:e.message ));
      }
    }else{
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, ShowCourseTeacher>> showCourseTeacherAdmin({required int idCourse}) async{
    if(await networkInfo.isConnected){
      try{
        final String token = await SharedPrefHelper.getString(SharedPrefKeys.cachedToken);
        final teacherInformation = await remoteDataSource.showCourseTeacherAdmin(token: token, idCourse: idCourse);
        return Right(teacherInformation);
      }on InvalidDataExceptionMessage catch (e){
        return Left(InvalidDataFailureMessage(message:e.message ));
      }
    }else{
      return Left(OfflineFailure());
    }
  }
}