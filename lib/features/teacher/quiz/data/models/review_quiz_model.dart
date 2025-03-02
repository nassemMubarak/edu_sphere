import 'dart:convert';

import 'package:logger/logger.dart';

class ReviewQuizModel {
  final int id;
  final int studentId;
  final int quizId;
  final List<AnswerData> data;
  final DateTime createdAt;
  final DateTime updatedAt;

  ReviewQuizModel({
    required this.id,
    required this.studentId,
    required this.quizId,
    required this.data,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ReviewQuizModel.fromJson(Map<String, dynamic> json) {
    Logger().e('--------------***********************${json['data']}');
    List<dynamic> decodedData;
    if (json['data'] is String) {
      decodedData = jsonDecode(json['data']) as List<dynamic>;
    } else if (json['data'] is List) {
      decodedData = json['data'] as List<dynamic>;
    } else {
      // Handle the case where 'data' is neither a String nor a List
      throw Exception('Invalid type for "data" field');
    }

    return ReviewQuizModel(
      id: json['id'],
      studentId: json['student_id'],
      quizId: json['quiz_id'],
      data: decodedData.map((e) => AnswerData.fromJson(e)).toList(),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'student_id': studentId,
      'quiz_id': quizId,
      'data': [
        jsonEncode(data.map((e) => e.toJson()).toList()),
      ],
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

class AnswerData {
  final String questionId;
  final String answer;

  AnswerData({
    required this.questionId,
    required this.answer,
  });

  factory AnswerData.fromJson(Map<String, dynamic> json) {
    return AnswerData(
      questionId: json['question_id'].toString(),
      answer: json['answer']??'no answer selected',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question_id': questionId,
      'answer': answer,
    };
  }
}
