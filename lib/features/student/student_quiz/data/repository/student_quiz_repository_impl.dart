import 'package:dartz/dartz.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/core/helpers/constants.dart';
import 'package:edu_sphere/core/helpers/shared_pref_helper.dart';
import 'package:edu_sphere/features/student/student_quiz/data/datasources/student_quiz_remote_data_source.dart';
import 'package:edu_sphere/features/student/student_quiz/data/model/estimate_student_quiz_model.dart';
import 'package:edu_sphere/features/student/student_quiz/domain/entities/estimate_student_quiz.dart';
import 'package:edu_sphere/features/student/student_quiz/domain/entities/question_student_quiz.dart';
import 'package:edu_sphere/features/student/student_quiz/domain/repositorises/student_quiz_repository.dart';
import 'package:edu_sphere/features/teacher/quiz/domain/entities/estimate_quiz.dart';
import 'package:edu_sphere/features/teacher/quiz/domain/entities/quiz.dart';

import '../../../../../core/error/exception.dart';
import '../../../../../core/networking/network_info.dart';

class StudentQuizRepositoryImpl implements StudentQuizRepository {
  final NetworkInfo networkInfo;
  final StudentQuizRemoteDataSource remoteDataSourceImpl;

  StudentQuizRepositoryImpl(
      {required this.networkInfo, required this.remoteDataSourceImpl});

  @override
  Future<Either<Failure, List<Quiz>>> getAllStudentQuiz(
      {required int idCourse}) async {
    if (await networkInfo.isConnected) {
      try {
        final String token =
            await SharedPrefHelper.getString(SharedPrefKeys.cachedToken);
        final listQuiz = await remoteDataSourceImpl.getAllStudentQuiz(
            idCourse: idCourse, token: token);
        return Right(listQuiz);
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
  Future<Either<Failure, List<QuestionStudentQuiz>>> getAttemptStudentQuiz(
      {required int idQuiz, required int idCourse}) async {
    if (await networkInfo.isConnected) {
      try {
        final String token =
            await SharedPrefHelper.getString(SharedPrefKeys.cachedToken);
        final listQuestionStudentQuiz =
            await remoteDataSourceImpl.getAttemptStudentQuiz(
                idQuiz: idQuiz, idCourse: idCourse, token: token);
        return Right(listQuestionStudentQuiz);
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
  Future<Either<Failure, Unit>> submitAnswerQuiz(
      {required int idQuiz, required int idCourse, required Map<int, String?> data}) async {
    if (await networkInfo.isConnected) {
      try {
        final String token =
            await SharedPrefHelper.getString(SharedPrefKeys.cachedToken);
        await remoteDataSourceImpl.submitAnswerQuiz(
            data: data, idQuiz: idQuiz, idCourse: idCourse, token: token);
        return Right(unit);
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
  Future<Either<Failure, EstimateStudentQuiz>> showAttemptQuiz({required int idQuiz, required int idCourse}) async{
    if (await networkInfo.isConnected) {
      try {
        final String token =
            await SharedPrefHelper.getString(SharedPrefKeys.cachedToken);
        EstimateStudentQuizModel estimateQuiz =  await remoteDataSourceImpl.showAttemptQuiz(
            idQuiz: idQuiz, idCourse: idCourse, token: token);
        return Right(estimateQuiz);
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
