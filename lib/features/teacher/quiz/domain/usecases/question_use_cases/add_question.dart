import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/features/teacher/quiz/domain/entities/question.dart';
import 'package:edu_sphere/features/teacher/quiz/domain/repositorises/quiz_repository.dart';

class AddQuestionUseCase{
  final QuizRepository repository;
  AddQuestionUseCase({required this.repository});
  Future<Either<Failure,Question>> call({required int idCourse,File? image,required int idQuiz,required Map data})async{
    return await repository.addQuestion(idCourse: idCourse, data: data,image: image,idQuiz: idQuiz);
  }
}