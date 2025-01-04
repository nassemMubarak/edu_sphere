import 'package:edu_sphere/features/teacher/assessments/data/models/assignment_assessment_model.dart';
import 'package:edu_sphere/features/teacher/assessments/domain/entities/estimate_assessment.dart';

class EstimateAssessmentModel extends EstimateAssessment {
  EstimateAssessmentModel({
    required super.id,
    required super.name,
    required super.email,
    required super.sex,
    required super.phoneNumber,
    required super.age,
    required super.level,
    required super.createdAt,
    required super.updatedAt,
    required super.assignmentAssessment,
    super.campId,
    super.deletedAt,
  });
  factory EstimateAssessmentModel.fromJson(Map<String, dynamic> json) {
    return EstimateAssessmentModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      campId: json['camp_id'],
      sex: json['sex'],
      phoneNumber: json['phone_number'],
      age: json['age'],
      level: json['level'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      deletedAt: json['deleted_at'] != null
          ? DateTime.parse(json['deleted_at'])
          : null,
      assignmentAssessment: (json['assignments'] as List)
          .map((assignment) => AssignmentAssessmentModel.fromJson(assignment))
          .toList(),
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'id': id,
  //     'name': name,
  //     'email': email,
  //     'camp_id': campId,
  //     'sex': sex,
  //     'phone_number': phoneNumber,
  //     'age': age,
  //     'level': level,
  //     'created_at': createdAt.toIso8601String(),
  //     'updated_at': updatedAt.toIso8601String(),
  //     'deleted_at': deletedAt?.toIso8601String(),
  //     'assignments': assignmentAssessment.map((assignment) => assignment.toJson()).toList(),
  //   };
  // }

}
