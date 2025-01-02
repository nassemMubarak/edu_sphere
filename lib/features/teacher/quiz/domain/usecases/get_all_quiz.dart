import 'package:dartz/dartz.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/features/teacher/quiz/domain/entities/quiz.dart';
import 'package:edu_sphere/features/teacher/quiz/domain/entities/quize.dart';
import 'package:edu_sphere/features/teacher/quiz/domain/repositorises/quiz_repository.dart';

class GetAllQuizUseCase{
  final QuizRepository repository;
  GetAllQuizUseCase({required this.repository});
  Future<Either<Failure,List<Quize>>> call({required int idCourse})async{
    return await repository.getAllQuiz(idCourse: idCourse);
  }
}