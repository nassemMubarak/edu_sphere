import 'package:dartz/dartz.dart';
import 'package:edu_sphere/features/student/student_quiz/domain/entities/estimate_student_quiz.dart';
import 'package:edu_sphere/features/student/student_quiz/domain/entities/question_student_quiz.dart';
import 'package:edu_sphere/features/teacher/quiz/data/models/review_quiz_model.dart';
import 'package:edu_sphere/features/teacher/quiz/domain/entities/estimate_quiz.dart';
import 'package:edu_sphere/features/teacher/quiz/domain/entities/question.dart';

import '../../../../../core/error/failure.dart';
import '../../../../teacher/quiz/domain/entities/quiz.dart';

abstract class StudentQuizRepository{
  Future<Either<Failure,List<Quiz>>> getAllStudentQuiz({required int idCourse});
  Future<Either<Failure,List<QuestionStudentQuiz>>> getAttemptStudentQuiz({required int idQuiz,required int idCourse});
  Future<Either<Failure,Unit>> submitAnswerQuiz({required int idQuiz,required int idCourse,required Map<int, String?> data});
  Future<Either<Failure,EstimateStudentQuiz>> showAttemptQuiz({required int idQuiz,required int idCourse});


}