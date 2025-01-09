import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:edu_sphere/core/error/exception.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/core/helpers/constants.dart';
import 'package:edu_sphere/core/helpers/shared_pref_helper.dart';
import 'package:edu_sphere/features/teacher/quiz/data/datasources/quiz_remote_data_source.dart';
import 'package:edu_sphere/features/teacher/quiz/data/models/review_quiz_model.dart';
import 'package:edu_sphere/features/teacher/quiz/domain/entities/estimate_quiz.dart';
import 'package:edu_sphere/features/teacher/quiz/domain/entities/question.dart';
  import 'package:edu_sphere/features/teacher/quiz/domain/entities/quiz.dart';
import 'package:edu_sphere/features/teacher/quiz/domain/repositorises/quiz_repository.dart';
import 'package:logger/logger.dart';

import '../../../../../core/networking/network_info.dart';

class QuizRepositoryImpl implements QuizRepository{
  final NetworkInfo networkInfo;
  final QuizRemoteDataSource remoteDataSourceImpl;

  QuizRepositoryImpl({required this.networkInfo, required this.remoteDataSourceImpl});

  @override
  Future<Either<Failure, List<Quiz>>> getAllQuiz({required int idCourse}) async{
    if(await networkInfo.isConnected){
      try{
        final String token = await SharedPrefHelper.getString(SharedPrefKeys.cachedToken);
        final listQuiz = await remoteDataSourceImpl.getAllQuiz(idCourse: idCourse, token: token);
        return Right(listQuiz);
      }on ServerException{
        return Left(ServerFailure());
      }
    }else{
      return Left(OfflineFailure());
    }
  }
  @override
  Future<Either<Failure, Quiz>> addQuiz({required int idCourse, required Map data}) async{
    if(await networkInfo.isConnected){
      try{
        final String token = await SharedPrefHelper.getString(SharedPrefKeys.cachedToken);
        final quiz = await remoteDataSourceImpl.addQuiz(token: token, data: data, idCourse: idCourse);
        return Right(quiz);
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
  Future<Either<Failure, Unit>> updateQuiz({required int idQuiz, required int idCourse, required Map data}) async{
    if(await networkInfo.isConnected){
      try{
        final String token = await SharedPrefHelper.getString(SharedPrefKeys.cachedToken);
        await remoteDataSourceImpl.updateQuiz(idQuiz: idQuiz, idCourse: idCourse, data: data, token: token);
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
  Future<Either<Failure, Unit>> deleteQuiz({required int idQuiz, required int idCourse}) async{
    if(await networkInfo.isConnected){
      try{
        final String token = await SharedPrefHelper.getString(SharedPrefKeys.cachedToken);
         await remoteDataSourceImpl.deleteQuiz(idQuiz: idQuiz, idCourse: idCourse, token: token);
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
  /// get all question quiz
  @override
  Future<Either<Failure, List<Question>>> getAllQuestion({required int idQuiz,required int idCourse}) async{
    if(await networkInfo.isConnected){
      try{
        final String token = await SharedPrefHelper.getString(SharedPrefKeys.cachedToken);
        final listQuestion = await remoteDataSourceImpl.getAllQuestion(idCourse: idCourse, token: token,idQuiz: idQuiz);
        return Right(listQuestion);
      }on ServerException{
        return Left(ServerFailure());
      }
    }else{
      return Left(OfflineFailure());
    }
  }
  /// add question quiz
  @override
  Future<Either<Failure, Question>> addQuestion({required int idCourse,required int idQuiz, required Map data,File? image}) async{

    if(await networkInfo.isConnected){
      try{
        final String token = await SharedPrefHelper.getString(SharedPrefKeys.cachedToken);
        final question = await remoteDataSourceImpl.addQuestion(image: image,idQuiz: idQuiz,token: token, data: data, idCourse: idCourse);
        return Right(question);
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
  Future<Either<Failure, Unit>> deleteQuestion({required int idQuestion,required int idQuiz, required int idCourse}) async{
    if(await networkInfo.isConnected){
      try{
        final String token = await SharedPrefHelper.getString(SharedPrefKeys.cachedToken);
        await remoteDataSourceImpl.deleteQuestion(idQuiz: idQuiz,idQuestion: idQuestion, idCourse: idCourse, token: token);
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
  Future<Either<Failure, Unit>> updateQuestion({File? image,required int idQuestion,required int idQuiz, required int idCourse, required Map data}) async{
    if(await networkInfo.isConnected){
      try{
        final String token = await SharedPrefHelper.getString(SharedPrefKeys.cachedToken);
        await remoteDataSourceImpl.updateQuestion(image:image,idQuiz: idQuiz,idQuestion: idQuestion, idCourse: idCourse, data: data, token: token);
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
  Future<Either<Failure, List<EstimateQuiz>>> getAllEstimateQuiz({required int idQuiz, required int idCourse})async {
    if(await networkInfo.isConnected){
      try{
        final String token = await SharedPrefHelper.getString(SharedPrefKeys.cachedToken);
        final listEstimateQuiz = await remoteDataSourceImpl.getAllEstimateQuiz(idCourse: idCourse, token: token,idQuiz: idQuiz);
        return Right(listEstimateQuiz);
      }on ServerException{
        return Left(ServerFailure());
      }
    }else{
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateAllEstimateQuiz({required int idQuiz, required int idCourse, required int idEstimate, required int grade}) async{
    if(await networkInfo.isConnected){
      try{
        final String token = await SharedPrefHelper.getString(SharedPrefKeys.cachedToken);
        await remoteDataSourceImpl.updateEstimateQuiz(idQuiz: idQuiz, grade: grade, idCourse: idCourse, token: token, idEstimate: idEstimate);
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
  Future<Either<Failure, ReviewQuizModel>> showEstimateQuiz({required int idQuiz, required int idCourse, required int idEstimate}) async{
    if(await networkInfo.isConnected){
      try{
        final String token = await SharedPrefHelper.getString(SharedPrefKeys.cachedToken);
        ReviewQuizModel reviewQuizModel = await remoteDataSourceImpl.showEstimateQuiz(idQuiz: idQuiz, idCourse: idCourse, idEstimate: idEstimate, token: token);

        return  Right(reviewQuizModel);
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