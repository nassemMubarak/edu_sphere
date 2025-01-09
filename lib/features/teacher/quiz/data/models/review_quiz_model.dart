import 'dart:convert';

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
    return ReviewQuizModel(
      id: json['id'],
      studentId: json['student_id'],
      quizId: json['quiz_id'],
      data: (jsonDecode(json['data'][0]) as List<dynamic>)
          .map((e) => AnswerData.fromJson(e))
          .toList(),
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
      questionId: json['question_id'],
      answer: json['answer'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question_id': questionId,
      'answer': answer,
    };
  }
}
