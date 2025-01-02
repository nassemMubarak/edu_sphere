import 'package:dartz/dartz.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/features/teacher/quiz/domain/entities/question.dart';
import 'package:edu_sphere/features/teacher/quiz/domain/entities/question1.dart';
import 'package:edu_sphere/features/teacher/quiz/domain/repositorises/quiz_repository.dart';
class GetAllQuestionUseCase{
  final QuizRepository repository;
  GetAllQuestionUseCase({required this.repository});
  Future<Either<Failure,List<Question>>> call({required int idCourse,required int idQuiz})async{
    return await repository.getAllQuestion(idCourse: idCourse,idQuiz: idQuiz);
  }
}