import 'dart:convert';

import 'package:edu_sphere/features/teacher/quiz/data/models/document_question_model.dart';
import 'package:logger/logger.dart';

import '../../domain/entities/question.dart';

class QuestionModel extends Question {
  QuestionModel({
    required super.id,
    required super.quizId,
    required super.title,
    required super.type,
    required super.options,
    required super.correctAnswer,
    required super.mark,
    super.createdAt,
    super.documents,
    super.updatedAt,
  });
  // Convert JSON to Question object
  factory QuestionModel.fromJson(Map<String, dynamic> json) {

    // Safely handle options field
    List<String> optionsList = [];
    if (json['options'] != null) {
      if (json['options'] is String) {
        try {
          optionsList = List<String>.from(jsonDecode(json['options']));
        } catch (e) {
          Logger().e("Error decoding 'options': ${json['options']}");
        }
      } else if (json['options'] is List) {
        optionsList = List<String>.from(json['options']);
      }
    }

    // Safely parse mark field
    int markValue = 1; // Default mark value
    if (json['mark'] != null) {
      try {
        markValue = int.parse(json['mark'].toString());
      } catch (e) {
        Logger().e("Error parsing 'mark': ${json['mark']}");
      }
    }

    return QuestionModel(
      id: json['id'] as int,
      quizId: json['quiz_id'] as int,
      title: json['title'] ?? '',
      type: json['type'] ?? '',
      options: optionsList,
      correctAnswer: json['correct_answer'] ?? '',
      mark: markValue,
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
      documents: json['documents'] != null
          ? (json['documents'] as List)
          .map((docJson) => DocumentQuestionModel.fromJson(docJson))
          .toList()
          : null,
    );
  }

  // Convert Question object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quiz_id': quizId,
      'title': title,
      'type': type,
      'options': jsonEncode(options), // Encode list to string
      'correct_answer': correctAnswer,
      'mark': mark,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'documents': documents?.map((doc) => doc.toJson()).toList(),
    };
  }
}