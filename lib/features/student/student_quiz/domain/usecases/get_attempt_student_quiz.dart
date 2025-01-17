import 'package:dartz/dartz.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/features/student/student_quiz/domain/entities/question_student_quiz.dart';
import 'package:edu_sphere/features/student/student_quiz/domain/repositorises/student_quiz_repository.dart';
import 'package:edu_sphere/features/teacher/quiz/domain/entities/quiz.dart';

class GetAttemptStudentQuizUseCase{
  final StudentQuizRepository repository;
  GetAttemptStudentQuizUseCase({required this.repository});
  Future<Either<Failure,List<QuestionStudentQuiz>>> call({required int idQuiz,required int idCourse})async{
    return await repository.getAttemptStudentQuiz(idQuiz: idQuiz,idCourse: idCourse);
  }
}