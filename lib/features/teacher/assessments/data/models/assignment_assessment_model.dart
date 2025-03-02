import 'package:edu_sphere/features/teacher/assessments/data/models/document_assessment_model.dart';
import 'package:edu_sphere/features/teacher/assessments/domain/entities/assignment_assessment.dart';
import 'package:logger/logger.dart';

import '../../../quiz/domain/entities/estimate_quiz.dart';

class AssignmentAssessmentModel extends AssignmentAssessment {
  AssignmentAssessmentModel({
    required super.id,
    required super.assignmentableType,
    required super.assignmentableId,
    required super.type,
    required super.relatedTo,
    required super.createdAt,
    required super.updatedAt,
     super.documents,
    super.degree,
    super.description,
    super.endIn,
    super.grade,
    super.startIn,
    super.title,
    super.visibility
  });
  factory AssignmentAssessmentModel.fromJson(Map<String, dynamic> json) {
    Logger().f('-------------json[grade]-------------?${json['grade']}');
    return AssignmentAssessmentModel(
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
      documents: json['documents']==null?[]:(json['documents'] as List)
          .map((document) => DocumentAssessmentModel.fromJson(document))
          .toList(),
      grade: json['grade'] != null ? Grade.fromJson(json['grade']) : null,
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'id': id,
  //     'assignmentable_type': assignmentableType,
  //     'assignmentable_id': assignmentableId,
  //     'title': title,
  //     'description': description,
  //     'type': type,
  //     'degree': degree,
  //     'visibility': visibility,
  //     'start_in': startIn?.toIso8601String(),
  //     'end_in': endIn?.toIso8601String(),
  //     'related_to': relatedTo,
  //     'created_at': createdAt.toIso8601String(),
  //     'updated_at': updatedAt.toIso8601String(),
  //     'documents': documents.map((document) => document.toJson()).toList(),
  //     'grade': grade,
  //   };
  // }

}
