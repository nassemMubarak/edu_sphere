import 'package:dartz/dartz.dart';
import 'package:edu_sphere/core/error/exception.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/core/helpers/constants.dart';
import 'package:edu_sphere/core/helpers/shared_pref_helper.dart';
import 'package:edu_sphere/core/networking/network_info.dart';
import 'package:edu_sphere/features/auth/domain/entities/user.dart';
import 'package:edu_sphere/features/student/show_studetn_course_teachers/data/datasource/show_student_teacher_remote_datasource.dart';
import 'package:edu_sphere/features/student/show_studetn_course_teachers/domain/entities/show_student_teacher.dart';
import 'package:edu_sphere/features/student/show_studetn_course_teachers/domain/repositorises/show_repository_student_teature.dart';
import 'package:edu_sphere/features/student/student_quiz/domain/repositorises/student_quiz_repository.dart';

class ShowRepositoryStudentTeacherImpl implements ShowRepositoryStudentTeacher{
  final NetworkInfo networkInfo;
  final ShowStudentTeacherRemoteDatasource remoteDataSourceImpl;

  ShowRepositoryStudentTeacherImpl(
      {required this.networkInfo, required this.remoteDataSourceImpl});
  @override
  Future<Either<Failure, List<User>>> getAllStudentTeacher() async{
    if (await networkInfo.isConnected) {
      try {
        final String token =
            await SharedPrefHelper.getString(SharedPrefKeys.cachedToken);
        final listTeacher = await remoteDataSourceImpl.getAllStudentTeacher(token: token);
        return Right(listTeacher);
      } on InvalidDataExceptionMessage catch (e) {
        return Left(InvalidDataFailureMessage(message: e.message));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, ShowStudentTeacher>> showTeacherInformation({required int idTeacher}) async{
    if (await networkInfo.isConnected) {
      try {
        final String token =
            await SharedPrefHelper.getString(SharedPrefKeys.cachedToken);
        final showStudentTeacher = await remoteDataSourceImpl.showTeacherInformation(idTeacher: idTeacher,token: token);
        return Right(showStudentTeacher);
      } on InvalidDataExceptionMessage catch (e) {
        return Left(InvalidDataFailureMessage(message: e.message));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

}