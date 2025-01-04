import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:edu_sphere/core/error/exception.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/core/helpers/constants.dart';
import 'package:edu_sphere/features/teacher/assessments/data/datasources/assessment_remote_data_source.dart';
import 'package:edu_sphere/features/teacher/assessments/domain/entities/assessment.dart';
import 'package:edu_sphere/features/teacher/assessments/domain/entities/document_assessment.dart';
import 'package:edu_sphere/features/teacher/assessments/domain/entities/estimate_assessment.dart';
import 'package:edu_sphere/features/teacher/assessments/domain/repositorises/assessment_repository.dart';

import '../../../../../core/helpers/shared_pref_helper.dart';
import '../../../../../core/networking/network_info.dart';

class AssessmentRepositoryImpl implements AssessmentRepository{
  final NetworkInfo networkInfo;
  final AssessmentRemoteDataSource remoteDataSourceImpl;
  AssessmentRepositoryImpl({required this.remoteDataSourceImpl,required this.networkInfo});
  @override
  Future<Either<Failure, List<Assessment>>> getAllAssessment({required int idCourse}) async{
    if(await networkInfo.isConnected){
      try{
        final String token = await SharedPrefHelper.getString(SharedPrefKeys.cachedToken);
        final listAssessment = await remoteDataSourceImpl.getAllAssessment(idCourse: idCourse, token: token);
        return Right(listAssessment);
      }on ServerException{
        return Left(ServerFailure());
      }
    }else{
      return Left(OfflineFailure());
    }
  }
  @override
  Future<Either<Failure, Assessment>> addAssessment({required int idCourse, required Map data}) async{
    if(await networkInfo.isConnected){
      try{
        final String token = await SharedPrefHelper.getString(SharedPrefKeys.cachedToken);
        final assessment = await remoteDataSourceImpl.addAssessment(token: token, data: data, idCourse: idCourse);
        return Right(assessment);
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
  Future<Either<Failure, Unit>> deleteAssessment({required int idAssessment, required int idCourse}) async{
    if(await networkInfo.isConnected){
      try{
        final String token = await SharedPrefHelper.getString(SharedPrefKeys.cachedToken);
        await remoteDataSourceImpl.deleteAssessment(idAssessment: idAssessment, idCourse: idCourse, token: token);
        return const Right(unit);
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
  Future<Either<Failure, Unit>> updateAssessment({required int idAssessment, required int idCourse, required Map data}) async{
    if(await networkInfo.isConnected){
      try{
        final String token = await SharedPrefHelper.getString(SharedPrefKeys.cachedToken);
        await remoteDataSourceImpl.updateAssessment(idAssessment: idAssessment, idCourse: idCourse, data: data, token: token);
        return const Right(unit);
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
  Future<Either<Failure, List<DocumentAssessment>>> addDocumentToAssessment({required int idCourse, required int idAssessment, required List<File> files})async {
    if(await networkInfo.isConnected){
      try{
        final String token = await SharedPrefHelper.getString(SharedPrefKeys.cachedToken);
        final assessment = await remoteDataSourceImpl.addDocumentToAssessment(idCourse: idCourse, idAssessment: idAssessment, files: files, token: token);
        return Right(assessment);
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
  Future<Either<Failure, Unit>> deleteDocumentToAssessment({required int idCourse, required int idAssessment, required int idDocument}) async{
    if(await networkInfo.isConnected){
      try{
        final String token = await SharedPrefHelper.getString(SharedPrefKeys.cachedToken);
        await remoteDataSourceImpl.deleteDocumentToAssessment(idCourse: idCourse, idAssessment: idAssessment, idDocument: idDocument, token: token);
        return const Right(unit);
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
  Future<Either<Failure, Unit>> downloadDocumentToAssessment({required int idCourse, required int idAssessment, required int idDocument})async {
    if(await networkInfo.isConnected){
      try{
        final String token = await SharedPrefHelper.getString(SharedPrefKeys.cachedToken);
        await remoteDataSourceImpl.downloadDocumentToAssessment(idCourse: idCourse, idAssessment: idAssessment, idDocument: idDocument, token: token);
        return const Right(unit);
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
  Future<Either<Failure, List<EstimateAssessment>>> getAllEstimateAssessment({required int idCourse, required int idAssessment})async {
    if(await networkInfo.isConnected){
      try{
        final String token = await SharedPrefHelper.getString(SharedPrefKeys.cachedToken);
        final listEstimateAssessment = await remoteDataSourceImpl.getAllEstimateAssessment(idCourse: idCourse, token: token,idAssessment: idAssessment);
        return Right(listEstimateAssessment);
      }on ServerException{
        return Left(ServerFailure());
      }
    }else{
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> addEstimateAssessment({required int idCourse, required int idAssessment, required int idStudent,required int mark}) async{
    if(await networkInfo.isConnected){
      try{
        final String token = await SharedPrefHelper.getString(SharedPrefKeys.cachedToken);
        final assessment = await remoteDataSourceImpl.addEstimateAssessment(token: token, mark: mark,idAssessment: idAssessment,idStudent: idStudent, idCourse: idCourse);
        return Right(assessment);
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