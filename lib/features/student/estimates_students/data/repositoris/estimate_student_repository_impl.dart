import 'package:dartz/dartz.dart';
import 'package:edu_sphere/core/error/exception.dart';

import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/core/helpers/constants.dart';
import 'package:edu_sphere/core/helpers/shared_pref_helper.dart';
import 'package:edu_sphere/core/networking/network_info.dart';
import 'package:edu_sphere/features/student/estimates_students/data/datasources/estimate_student_remote_datasource.dart';

import 'package:edu_sphere/features/student/estimates_students/data/model/estimates_student_model.dart';
import 'package:edu_sphere/features/student/estimates_students/domain/entities/estimates_student.dart';

import '../../domain/repositorises/estimates_student_repository.dart';

class EstimateStudentRepositoryImpl implements EstimateStudentRepository{
  final NetworkInfo networkInfo;
  final EstimateStudentRemoteDataSource estimateStudentRemoteDataSource;
  EstimateStudentRepositoryImpl({required this.estimateStudentRemoteDataSource,required this.networkInfo});
  @override
  Future<Either<Failure, EstimatesStudentModel>> showEstimateStudentToCourse({required int idCourse}) async{
    if(await networkInfo.isConnected){
      try{
        final String token = await SharedPrefHelper.getString(SharedPrefKeys.cachedToken);

        EstimatesStudentModel estimatesStudent = await estimateStudentRemoteDataSource.showEstimateStudentToCourse(token: token, idCourse: idCourse);
        return  Right(estimatesStudent);
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