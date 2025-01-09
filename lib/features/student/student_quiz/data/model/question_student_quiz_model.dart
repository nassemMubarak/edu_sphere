import 'dart:convert';

import 'package:edu_sphere/features/student/student_quiz/domain/entities/question_student_quiz.dart';

class QuestionStudentQuizModel extends QuestionStudentQuiz {
  QuestionStudentQuizModel({
    required super.id,
    required super.quizId,
    required super.title,
    required super.type,
    required super.options,
    required super.mark,
    required super.createdAt,
    required super.updatedAt,
    required super.documents,
  });

  factory QuestionStudentQuizModel.fromJson(Map<String, dynamic> json) {
    return QuestionStudentQuizModel(
      id: json['id'],
      quizId: json['quiz_id'],
      title: json['title'],
      type: json['type'],
      options: List<String>.from(jsonDecode(json['options'])),
      mark: json['mark'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      documents: (json['documents'] as List<dynamic>)
          .map((doc) => Document.fromJson(doc))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quiz_id': quizId,
      'title': title,
      'type': type,
      'options': jsonEncode(options),
      'mark': mark,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'documents': documents.map((doc) => doc.toJson()).toList(),
    };
  }
}
