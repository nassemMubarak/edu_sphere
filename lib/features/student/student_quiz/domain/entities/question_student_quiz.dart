import 'dart:convert';

import 'package:equatable/equatable.dart';

class QuestionStudentQuiz extends Equatable {
  final int id;
  final int quizId;
  final String title;
  final String type;
  final List<String> options;
  final int mark;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<Document> documents;

  const QuestionStudentQuiz({
    required this.id,
    required this.quizId,
    required this.title,
    required this.type,
    required this.options,
    required this.mark,
    required this.createdAt,
    required this.updatedAt,
    required this.documents,
  });

  @override
  List<Object?> get props => [id, quizId, title, type, options, mark, createdAt, updatedAt, documents];

}

class Document extends Equatable {
  final int id;
  final String documentableType;
  final int documentableId;
  final String? title;
  final String? description;
  final String type;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String url;

  const Document({
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

  @override
  List<Object?> get props => [id, documentableType, documentableId, title, description, type, createdAt, updatedAt, url];

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

  Map<String, dynamic> toJson() {
    return {
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
}
