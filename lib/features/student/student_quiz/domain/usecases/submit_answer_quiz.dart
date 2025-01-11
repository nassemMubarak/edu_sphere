import 'package:dartz/dartz.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/features/student/student_quiz/domain/entities/question_student_quiz.dart';
import 'package:edu_sphere/features/student/student_quiz/domain/repositorises/student_quiz_repository.dart';
import 'package:edu_sphere/features/teacher/quiz/domain/entities/quiz.dart';

class SubmitAnswerQuizUseCase{
  final StudentQuizRepository repository;
  SubmitAnswerQuizUseCase({required this.repository});
  Future<Either<Failure,Unit>> call({required int idQuiz,required int idCourse,required Map<int, String?> data})async{
    return await repository.submitAnswerQuiz(idQuiz: idQuiz, idCourse: idCourse, data: data);
  }
}