import 'dart:convert';

import 'package:edu_sphere/features/teacher/quiz/data/models/quiz_model.dart';
import 'package:edu_sphere/features/teacher/quiz/domain/entities/quiz.dart';

// Main ReviewQuizModel class
class ReviewQuizModel {
  final int id;
  final int studentId;
  final int quizId;
  final List<QuizData> data;
  final DateTime createdAt;
  final DateTime updatedAt;
  final QuizModel quiz;

  ReviewQuizModel({
    required this.id,
    required this.studentId,
    required this.quizId,
    required this.data,
    required this.createdAt,
    required this.updatedAt,
    required this.quiz,
  });

  factory ReviewQuizModel.fromJson(Map<String, dynamic> json) {
    return ReviewQuizModel(
      id: json['id'],
      studentId: json['student_id'],
      quizId: json['quiz_id'],
      data: List<QuizData>.from(json['data'].map((x) => QuizData.fromJson(x))),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      quiz: QuizModel.fromJson(json['quiz']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'student_id': studentId,
    'quiz_id': quizId,
    'data': List<dynamic>.from(data.map((x) => x.toJson())),
    'created_at': createdAt.toIso8601String(),
    'updated_at': updatedAt.toIso8601String(),
    'quiz': quiz.toJson(),
  };
}

// QuizData class for the data array
class QuizData {
  final int questionId;
  final String title;
  final String type;
  final String options;
  final String correctAnswer;
  final int mark;
  final String studentAnswer;
  final bool isCorrect;
  final List<Document> documents;

  QuizData({
    required this.questionId,
    required this.title,
    required this.type,
    required this.options,
    required this.correctAnswer,
    required this.mark,
    required this.studentAnswer,
    required this.isCorrect,
    required this.documents,
  });

  factory QuizData.fromJson(Map<String, dynamic> json) {
    return QuizData(
      questionId: json['question_id'],
      title: json['title'],
      type: json['type'],
      options: json['options'],
      correctAnswer: json['correct_answer'],
      mark: json['mark'],
      studentAnswer: json['student_answer'],
      isCorrect: json['is_correct'],
      documents: List<Document>.from(
          json['documents'].map((x) => Document.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    'question_id': questionId,
    'title': title,
    'type': type,
    'options': options,
    'correct_answer': correctAnswer,
    'mark': mark,
    'student_answer': studentAnswer,
    'is_correct': isCorrect,
    'documents': List<dynamic>.from(documents.map((x) => x.toJson())),
  };
}

// Document class
class Document {
  final int id;
  final String documentableType;
  final int documentableId;
  final String? title;
  final String? description;
  final String type;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String url;

  Document({
    required this.id,
    required this.documentableType,
    required this.documentableId,
    this.title,
    this.description,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
    required this.url,
  });

  factory Document.fromJson(Map<String, dynamic> json) {
    return Document(
      id: json['id'],
      documentableType: json['documentable_type'],
      documentableId: json['documentable_id'],
      title: json['title'],
      description: json['description'],
      type: json['type'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'documentable_type': documentableType,
    'documentable_id': documentableId,
    'title': title,
    'description': description,
    'type': type,
    'created_at': createdAt.toIso8601String(),
    'updated_at': updatedAt.toIso8601String(),
    'url': url,
  };
}
