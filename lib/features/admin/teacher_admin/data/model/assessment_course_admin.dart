import 'dart:convert';

class AssessmentCourseAdmin {
  final int id;
  final String assignmentableType;
  final int assignmentableId;
  final String title;
  final String description;
  final String? type;
  final int degree;
  final bool visibility;
  final DateTime startIn;
  final DateTime endIn;
  final String? relatedTo;
  final DateTime createdAt;
  final DateTime updatedAt;

  AssessmentCourseAdmin({
    required this.id,
    required this.assignmentableType,
    required this.assignmentableId,
    required this.title,
    required this.description,
    this.type,
    required this.degree,
    required this.visibility,
    required this.startIn,
    required this.endIn,
    this.relatedTo,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory method to create the model from a JSON map
  factory AssessmentCourseAdmin.fromJson(Map<String, dynamic> json) {
    return AssessmentCourseAdmin(
      id: json['id'],
      assignmentableType: json['assignmentable_type'],
      assignmentableId: json['assignmentable_id'],
      title: json['title'],
      description: json['description'],
      type: json['type'], // Can be null, hence String?
      degree: json['degree'],
      visibility: json['visibility'],
      startIn: DateTime.parse(json['start_in']),
      endIn: DateTime.parse(json['end_in']),
      relatedTo: json['related_to'], // Can be null, hence String?
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  // Convert the model to a JSON map
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
      'start_in': startIn.toIso8601String(),
      'end_in': endIn.toIso8601String(),
      'related_to': relatedTo,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
