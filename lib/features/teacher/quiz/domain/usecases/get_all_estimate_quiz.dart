import 'package:dartz/dartz.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/features/teacher/quiz/domain/entities/estimate_quiz.dart';
import 'package:edu_sphere/features/teacher/quiz/domain/entities/quize.dart';
import 'package:edu_sphere/features/teacher/quiz/domain/repositorises/quiz_repository.dart';

class GetAllEstimateQuizUseCase{
  final QuizRepository repository;
  GetAllEstimateQuizUseCase({required this.repository});
  Future<Either<Failure,List<EstimateQuiz>>>  call({required int idQuiz,required int idCourse})async{
    return await repository.getAllEstimateQuiz(idQuiz: idQuiz, idCourse: idCourse);
  }
}