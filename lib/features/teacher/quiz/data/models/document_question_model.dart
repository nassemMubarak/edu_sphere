import 'package:edu_sphere/features/teacher/quiz/domain/entities/document_question.dart';

class DocumentQuestionModel extends DocumentQuestion {
  DocumentQuestionModel({
    required super.id,
    required super.documentableType,
    required super.documentableId,
    required super.type,
    required super.url,
    super.createdAt,
    super.description,
    super.title,
    super.updatedAt,
  });
  // Convert JSON to DocumentQuestion object
  factory DocumentQuestionModel.fromJson(Map<String, dynamic> json) {
    return DocumentQuestionModel(
      id: json['id'],
      documentableType: json['documentable_type'],
      documentableId: json['documentable_id'],
      title: json['title'],
      description: json['description'],
      type: json['type'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      url: json['url'],
    );
  }

  // Convert DocumentQuestion object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'documentable_type': documentableType,
      'documentable_id': documentableId,
      'title': title,
      'description': description,
      'type': type,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'url': url,
    };
  }
}
