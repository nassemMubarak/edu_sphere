import 'package:dartz/dartz.dart';
import 'package:edu_sphere/core/error/exception.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/core/helpers/constants.dart';
import 'package:edu_sphere/core/helpers/shared_pref_helper.dart';
import 'package:edu_sphere/core/networking/network_info.dart';
import 'package:edu_sphere/features/admin/student_main/data/datasource/student_admin_remotedatasource.dart';
import 'package:edu_sphere/features/admin/student_main/data/model/student_information_model.dart';
import 'package:edu_sphere/features/admin/student_main/domain/repositorises/student_admin_repository.dart';
import 'package:edu_sphere/features/admin/teacher_admin/data/datasource/teacher_admin_remotedatasource.dart';
import 'package:edu_sphere/features/admin/teacher_admin/domain/entities/show_teacher_courses.dart';
import 'package:edu_sphere/features/admin/teacher_admin/domain/entities/teacher_informstion.dart';
import 'package:edu_sphere/features/admin/teacher_admin/domain/repositorises/teacher_admin_repository.dart';

class StudentAdminRepositoryImpl implements StudentAdminRepository{
  final NetworkInfo networkInfo;
  final StudentAdminRemoteDataSource remoteDataSource;
  StudentAdminRepositoryImpl({required this.remoteDataSource,required this.networkInfo});

  @override
  Future<Either<Failure, StudentInformationModel>> getInformationStudent({required int idStudent})async {
    if(await networkInfo.isConnected){
      try{
        final String token = await SharedPrefHelper.getString(SharedPrefKeys.cachedToken);
        final teacherInformation = await remoteDataSource.getStudentInformationModel(token: token, idStudent: idStudent);
        return Right(teacherInformation);
      }on InvalidDataExceptionMessage catch (e){
        return Left(InvalidDataFailureMessage(message:e.message ));
      }
    }else{
      return Left(OfflineFailure());
    }
  }
}