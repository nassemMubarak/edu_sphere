import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:edu_sphere/core/error/exception.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/core/helpers/constants.dart';
import 'package:edu_sphere/core/helpers/shared_pref_helper.dart';
import 'package:edu_sphere/core/networking/network_info.dart';
import 'package:edu_sphere/features/student/assessment_student/data/datasources/student_assessment_remote_data_source.dart';
import 'package:edu_sphere/features/student/assessment_student/domain/entities/document_student_assessment.dart';
import 'package:edu_sphere/features/student/assessment_student/domain/repositorises/student_assessment_repository.dart';
import 'package:edu_sphere/features/teacher/assessments/domain/entities/assessment.dart';
import 'package:edu_sphere/features/teacher/assessments/domain/entities/document_assessment.dart';

class StudentAssessmentRepositoryImpl implements StudentAssessmentRepository{
  final NetworkInfo networkInfo;
  final StudentAssessmentRemoteDataSource remoteDataSourceImpl;
  StudentAssessmentRepositoryImpl({required this.remoteDataSourceImpl,required this.networkInfo});
  @override
  Future<Either<Failure, Unit>> deleteSubmitStudentDocumentToAssessment({required int idCourse, required int idAssessment}) async{
    if(await networkInfo.isConnected){
      try{
        final String token = await SharedPrefHelper.getString(SharedPrefKeys.cachedToken);
        await remoteDataSourceImpl.deleteSubmitStudentDocumentToAssessment(idCourse: idCourse, idAssessment: idAssessment, token: token);
        return const Right(unit);
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
  Future<Either<Failure, List<Assessment>>> getAllStudentAssessment({required int idCourse})async {
    if(await networkInfo.isConnected){
      try{
        final String token = await SharedPrefHelper.getString(SharedPrefKeys.cachedToken);
        final listAssessment = await remoteDataSourceImpl.getAllStudentAssessment(idCourse: idCourse, token: token);
        return Right(listAssessment);
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
  Future<Either<Failure, Assessment>> showStudentAssessment({required int idCourse, required int idAssessment}) async{
    if(await networkInfo.isConnected){
      try{
        final String token = await SharedPrefHelper.getString(SharedPrefKeys.cachedToken);
        final assessment = await remoteDataSourceImpl.showStudentAssessment(idAssessment: idAssessment,idCourse: idCourse, token: token);
        return Right(assessment);
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
  Future<Either<Failure, DocumentStudentAssessment>> submitStudentDocumentToAssessment({required int idCourse, required int idAssessment, required List<File> files})async {
    if(await networkInfo.isConnected){
      try{
        final String token = await SharedPrefHelper.getString(SharedPrefKeys.cachedToken);
        final assessment = await remoteDataSourceImpl.submitStudentDocumentToAssessment(files: files,idAssessment: idAssessment,idCourse: idCourse, token: token);
        return Right(assessment);
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
  Future<Either<Failure, DocumentStudentAssessment>> getAllSubmitStudentDocumentToAssessment({required int idCourse, required int idAssessment})async {
    if(await networkInfo.isConnected){
      try{
        final String token = await SharedPrefHelper.getString(SharedPrefKeys.cachedToken);
        final listDocumentToAssessment = await remoteDataSourceImpl.getAllSubmitStudentDocumentToAssessment(idCourse: idCourse, token: token,idAssessment: idAssessment);
        return Right(listDocumentToAssessment);
      }on InvalidDataExceptionMessage catch (e) {
        return Left(InvalidDataFailureMessage(message: e.message));
      }on InvalidDataException{
        return Left(InvalidDataFailure());
      } on ServerException {
        return Left(ServerFailure());
      }
    }else{
      return Left(OfflineFailure());
    }
  }

}