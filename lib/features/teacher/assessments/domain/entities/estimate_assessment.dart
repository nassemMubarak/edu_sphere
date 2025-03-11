import 'package:edu_sphere/features/teacher/assessments/domain/entities/assignment_assessment.dart';
import 'package:equatable/equatable.dart';

class EstimateAssessment extends Equatable {
  final int id;
  final String name;
  final String email;
  final int? campId;
  final String sex;
  final String? phoneNumber;
  final int age;
  final int level;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final List<AssignmentAssessment> assignmentAssessment;

  EstimateAssessment({
    required this.id,
    required this.name,
    required this.email,
    this.campId,
    required this.sex,
     this.phoneNumber,
    required this.age,
    required this.level,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.assignmentAssessment,
  });

  @override
  List<Object?> get props =>
      [
        id,
        name,
        email,
        campId,
        sex,
        phoneNumber,
        age,
        level,
        createdAt,
        updatedAt,
        deletedAt,
        assignmentAssessment
      ];
}