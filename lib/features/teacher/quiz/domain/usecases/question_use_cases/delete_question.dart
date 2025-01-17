import 'package:dartz/dartz.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/features/teacher/quiz/domain/repositorises/quiz_repository.dart';

class DeleteQuestionUseCase{
  final QuizRepository repository;
  DeleteQuestionUseCase({required this.repository});
  Future<Either<Failure,Unit>> call({required int idQuestion,required int idQuiz,required int idCourse})async{
    return await repository.deleteQuestion(idQuestion: idQuestion, idCourse: idCourse,idQuiz: idQuiz);
  }
}