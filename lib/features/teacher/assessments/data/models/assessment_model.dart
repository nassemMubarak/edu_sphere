import 'package:edu_sphere/features/teacher/assessments/data/models/document_assessment_model.dart';
import 'package:edu_sphere/features/teacher/assessments/domain/entities/assessment.dart';

class AssessmentModel extends Assessment {
  AssessmentModel({
    required super.id,
    required super.assignmentableType,
    required super.assignmentableId,
    required super.title,
    required super.description,
    required super.degree,
    required super.visibility,
    required super.startIn,
    required super.endIn,
    super.createdAt,
    super.documents,
    super.relatedTo,
    super.updatedAt,
    super.type
  });

  factory AssessmentModel.fromJson(Map<String, dynamic> json) {
    return AssessmentModel(
      id: json['id'],
      assignmentableType: json['assignmentable_type'],
      assignmentableId: json['assignmentable_id'],
      title: json['title'],
      description: json['description'],
      type: json['type'],
      degree: int.tryParse(json['degree'].toString()) ?? 0, // Handle 'degree' as a String or int
      visibility: json['visibility'],
      startIn: DateTime.parse(json['start_in']),
      endIn: DateTime.parse(json['end_in']),
      relatedTo: json['related_to'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
      documents: json['documents'] != null
          ? (json['documents'] as List).map((doc) => DocumentAssessmentModel.fromJson(doc)).toList()
          : null,
    );
  }
}
