import 'package:equatable/equatable.dart';

class DocumentStudentAssessment extends Equatable {
  final int id;
  final String assignmentableType;
  final int assignmentableId;
  final String? title;
  final String? description;
  final String type;
  final int? degree;
  final String? visibility;
  final DateTime? startIn;
  final DateTime? endIn;
  final int relatedTo;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<Document> documents;
  final Grade? grade;

  DocumentStudentAssessment({
    required this.id,
    required this.assignmentableType,
    required this.assignmentableId,
    this.title,
    this.description,
    required this.type,
    this.degree,
    this.visibility,
    this.startIn,
    this.endIn,
    required this.relatedTo,
    required this.createdAt,
    required this.updatedAt,
    required this.documents,
    this.grade,
  });



  @override
  List<Object?> get props => [
    id,
    assignmentableType,
    assignmentableId,
    title,
    description,
    type,
    degree,
    visibility,
    startIn,
    endIn,
    relatedTo,
    createdAt,
    updatedAt,
    documents,
    grade,
  ];
}

class Document extends Equatable {
  final int id;
  final String documentableType;
  final int documentableId;
  final String title;
  final String? description;
  final String type;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String url;

  Document({
    required this.id,
    required this.documentableType,
    required this.documentableId,
    required this.title,
    this.description,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
    required this.url,
  });

  // Factory constructor for deserialization (fromJson)
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

  // Method for serialization (toJson)
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

  @override
  List<Object?> get props => [
    id,
    documentableType,
    documentableId,
    title,
    description,
    type,
    createdAt,
    updatedAt,
    url,
  ];
}

class Grade extends Equatable {
  final int id;
  final String gradeableType;
  final int gradeableId;
  final double result;
  final DateTime createdAt;
  final DateTime updatedAt;

  Grade({
    required this.id,
    required this.gradeableType,
    required this.gradeableId,
    required this.result,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory constructor for deserialization (fromJson)
  factory Grade.fromJson(Map<String, dynamic> json) {
    return Grade(
      id: json['id'],
      gradeableType: json['gradeable_type'],
      gradeableId: json['gradeable_id'],
      result: json['result'].toDouble(),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  // Method for serialization (toJson)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'gradeable_type': gradeableType,
      'gradeable_id': gradeableId,
      'result': result,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [
    id,
    gradeableType,
    gradeableId,
    result,
    createdAt,
    updatedAt,
  ];
}