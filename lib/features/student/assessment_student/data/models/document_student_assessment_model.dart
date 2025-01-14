import 'package:edu_sphere/features/student/assessment_student/domain/entities/document_student_assessment.dart';

class DocumentStudentAssessmentModel extends DocumentStudentAssessment {
  DocumentStudentAssessmentModel({
    required super.id,
    required super.assignmentableType,
    required super.assignmentableId,
    required super.type,
    required super.relatedTo,
    required super.createdAt,
    required super.updatedAt,
    required super.documents,
    super.degree,
    super.description,
    super.endIn,
    super.grade,
    super.startIn,
    super.title,
    super.visibility
  });
  // Factory constructor for deserialization (fromJson)
  factory DocumentStudentAssessmentModel.fromJson(Map<String, dynamic> json) {
    return DocumentStudentAssessmentModel(
      id: json['id'],
      assignmentableType: json['assignmentable_type'],
      assignmentableId: json['assignmentable_id'],
      title: json['title'],
      description: json['description'],
      type: json['type'],
      degree: json['degree'],
      visibility: json['visibility'],
      startIn: json['start_in'] != null ? DateTime.parse(json['start_in']) : null,
      endIn: json['end_in'] != null ? DateTime.parse(json['end_in']) : null,
      relatedTo: json['related_to'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      documents: (json['documents'] as List)
          .map((doc) => Document.fromJson(doc))
          .toList(),
      grade: json['grade'] != null ? Grade.fromJson(json['grade']) : null,
    );
  }

  // Method for serialization (toJson)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'assignmentable_type': assignmentableType,
      'assignmentable_id': assignmentableId,
      'title': title,
      'description': description,
      'type': type,
      'degree': degree,
      'visibility': visibility,
      'start_in': startIn?.toIso8601String(),
      'end_in': endIn?.toIso8601String(),
      'related_to': relatedTo,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'documents': documents.map((doc) => doc.toJson()).toList(),
      'grade': grade?.toJson(),
    };
  }
}
