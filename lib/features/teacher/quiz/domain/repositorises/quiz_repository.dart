import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/features/teacher/quiz/domain/entities/question.dart';
import 'package:edu_sphere/features/teacher/quiz/domain/entities/quize.dart';

abstract class QuizRepository{
  /// quiz
  Future<Either<Failure,List<Quize>>> getAllQuiz({required int idCourse});
  Future<Either<Failure,Quize>> addQuiz({required int idCourse,required Map data});
  Future<Either<Failure,Unit>> updateQuiz({required int idQuiz,required int idCourse,required Map data});
  Future<Either<Failure,Unit>> deleteQuiz({required int idQuiz,required int idCourse});

  /// question
  Future<Either<Failure,List<Question>>> getAllQuestion({required int idQuiz,required int idCourse});
  Future<Either<Failure,Question>> addQuestion({required int idQuiz,required int idCourse,required Map data,File? image});
  Future<Either<Failure,Unit>> updateQuestion({File? image,required int idQuiz,required int idQuestion,required int idCourse,required Map data});
  Future<Either<Failure,Unit>> deleteQuestion({required int idQuestion,required int idQuiz,required int idCourse});
}