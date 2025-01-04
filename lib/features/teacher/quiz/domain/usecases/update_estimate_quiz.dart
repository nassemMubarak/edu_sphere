import 'package:dartz/dartz.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/features/teacher/quiz/domain/entities/quiz.dart';
import 'package:edu_sphere/features/teacher/quiz/domain/repositorises/quiz_repository.dart';

class UpdateEstimateQuizUseCase{
  final QuizRepository repository;
  UpdateEstimateQuizUseCase({required this.repository});
  Future<Either<Failure,Unit>> call({required int idQuiz,required int idCourse,required int idEstimate,required int grade})async{
    return await repository.updateAllEstimateQuiz(idQuiz: idQuiz, idCourse: idCourse, idEstimate: idEstimate,grade: grade);
  }
}