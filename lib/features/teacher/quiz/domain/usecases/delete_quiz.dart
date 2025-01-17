import 'package:dartz/dartz.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/features/teacher/quiz/domain/repositorises/quiz_repository.dart';

class DeleteQuizUseCase{
  final QuizRepository repository;
  DeleteQuizUseCase({required this.repository});
  Future<Either<Failure,Unit>> call({required int idQuiz,required int idCourse})async{
    return await repository.deleteQuiz(idQuiz: idQuiz, idCourse: idCourse);
  }
}