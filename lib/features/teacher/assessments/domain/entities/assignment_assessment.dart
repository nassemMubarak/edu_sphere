import 'package:edu_sphere/features/teacher/assessments/data/models/document_assessment_model.dart';
import 'package:equatable/equatable.dart';

import '../../../quiz/domain/entities/estimate_quiz.dart';

class AssignmentAssessment extends Equatable {
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
  final List<DocumentAssessmentModel>? documents;
  final Grade? grade;

  AssignmentAssessment({
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
     this.documents,
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