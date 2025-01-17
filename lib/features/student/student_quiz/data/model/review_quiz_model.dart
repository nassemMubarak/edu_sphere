import 'package:edu_sphere/features/student/student_quiz/data/model/question_student_quiz_model.dart';
import 'package:edu_sphere/features/student/student_quiz/domain/entities/review_student_quiz.dart';
import 'package:edu_sphere/features/teacher/quiz/data/models/quiz_model.dart';

class ReviewQuizModel extends ReviewQuiz{
  ReviewQuizModel({required super.id, required super.studentId, required super.quizId, required super.data, required super.createdAt, required super.updatedAt, required super.quiz});

  factory ReviewQuizModel.fromJson(Map<String, dynamic> json) {
    return ReviewQuizModel(
      id: json['id'],
      studentId: json['student_id'],
      quizId: json['quiz_id'],
      data: (json['data'] as List)
          .map((item) => QuestionData.fromJson(item))
          .toList(),
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      quiz: QuizDetails.fromJson(json['quiz']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'student_id': studentId,
      'quiz_id': quizId,
      'data': data.map((item) => item.toJson()).toList(),
      'created_at': createdAt,
      'updated_at': updatedAt,
      'quiz': quiz.toJson(),
    };
  }}