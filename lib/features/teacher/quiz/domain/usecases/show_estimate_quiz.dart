import 'package:dartz/dartz.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/features/teacher/quiz/data/models/review_quiz_model.dart';
import 'package:edu_sphere/features/teacher/quiz/domain/repositorises/quiz_repository.dart';

class ShowEstimateQuizUseCase{
  final QuizRepository repository;
  ShowEstimateQuizUseCase({required this.repository});
  Future<Either<Failure,ReviewQuizModel>> call({required int idQuiz,required int idCourse,required int idEstimate})async{
    return await repository.showEstimateQuiz(idQuiz: idQuiz, idCourse: idCourse, idEstimate: idEstimate);
  }
}