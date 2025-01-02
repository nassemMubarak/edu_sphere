import 'package:edu_sphere/features/teacher/quiz/domain/entities/question1.dart';

class Question1Model extends Question1{
  Question1Model({required super.questionText, required super.correctAnswer, required super.questionScore});
  factory Question1Model.fromJson(Map<String, dynamic> json) {
    return Question1Model(questionText: json['id'], correctAnswer: json['id'], questionScore: json['id']);
  }
}