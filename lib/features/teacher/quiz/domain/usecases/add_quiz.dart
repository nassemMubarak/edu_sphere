import 'package:dartz/dartz.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/features/teacher/quiz/domain/entities/quize.dart';
import 'package:edu_sphere/features/teacher/quiz/domain/repositorises/quiz_repository.dart';

class AddQuizUseCase{
  final QuizRepository repository;
  AddQuizUseCase({required this.repository});
  Future<Either<Failure,Quize>> call({required int idCourse,required Map data})async{
    return await repository.addQuiz(idCourse: idCourse, data: data);
  }
}