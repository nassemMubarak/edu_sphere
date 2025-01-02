import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/features/teacher/quiz/domain/repositorises/quiz_repository.dart';

class UpdateQuestionUseCase{
  final QuizRepository repository;
  UpdateQuestionUseCase({required this.repository});
  Future<Either<Failure,Unit>> call({File? image,required int idQuestion,required int idCourse,required Map data,required int idQuiz})async{
    return await repository.updateQuestion(image: image,idQuestion: idQuestion, idCourse: idCourse, data: data,idQuiz: idQuiz);
  }
}