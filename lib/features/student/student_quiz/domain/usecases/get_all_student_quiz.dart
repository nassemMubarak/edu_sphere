import 'package:dartz/dartz.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/features/student/student_quiz/domain/repositorises/student_quiz_repository.dart';
import 'package:edu_sphere/features/teacher/quiz/domain/entities/quiz.dart';

class GetAllStudentQuizUseCase{
  final StudentQuizRepository repository;
  GetAllStudentQuizUseCase({required this.repository});
  Future<Either<Failure,List<Quiz>>> call({required int idCourse})async{
    return await repository.getAllStudentQuiz(idCourse: idCourse);
  }
}