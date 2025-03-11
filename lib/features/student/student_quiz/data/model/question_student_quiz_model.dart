import 'dart:convert';

import 'package:edu_sphere/features/student/student_quiz/domain/entities/question_student_quiz.dart';
import 'package:logger/logger.dart';

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
    Logger().f('json logger--------------$json');
    // Fix malformed options
    List<String> parseOptions(String optionsString) {
      // Replace single quotes with double quotes and decode
      final validJson = optionsString.replaceAll("'", "\"");
      return List<String>.from(jsonDecode(validJson));
    }

    return QuestionStudentQuizModel(
      id: json['id'],
      quizId: json['quiz_id'],
      title: json['title'],
      type: json['type'],
      options: json['options'] is String
          ? parseOptions(json['options'])
          : List<String>.from(json['options']),
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
