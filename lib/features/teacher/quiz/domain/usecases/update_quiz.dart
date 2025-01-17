import 'package:dartz/dartz.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/features/teacher/quiz/domain/repositorises/quiz_repository.dart';

class UpdateQuizUseCase{
  final QuizRepository repository;
  UpdateQuizUseCase({required this.repository});
  Future<Either<Failure,Unit>> call({required int idQuiz,required int idCourse,required Map data})async{
    return await repository.updateQuiz(idQuiz: idQuiz, idCourse: idCourse, data: data);
  }
}