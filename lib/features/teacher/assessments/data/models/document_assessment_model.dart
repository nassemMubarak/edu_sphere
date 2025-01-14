import 'package:edu_sphere/features/teacher/assessments/domain/entities/assessment.dart';
import 'package:edu_sphere/features/teacher/assessments/domain/entities/document_assessment.dart';

class DocumentAssessmentModel extends DocumentAssessment {
  DocumentAssessmentModel({
    required super.id,
    required super.documentableType,
    required super.documentableId,
    required super.type,
    super.createdAt,
    super.description,
    super.title,
    super.updatedAt
  });
  factory DocumentAssessmentModel.fromJson(Map<String, dynamic> json) {
    return DocumentAssessmentModel(
      id: json['id'],
      documentableType: json['documentable_type']??'',
      documentableId: json['documentable_id']??1,
      title: json['title'],
      description: json['description'],
      type: json['type'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
    );
  }
}
