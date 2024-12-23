import 'package:edu_sphere/features/teacher/teacher_main/domain/entities/course.dart';

class CourseModel extends Course{
  CourseModel({required super.id, required super.title, required super.description,  super.teacherId,  super.createdAt,  super.updatedAt,  super.type,super.deletedAt});
  // Factory method to create a Course instance from JSON
  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      teacherId: json['teacher_id'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
      deletedAt: json['deleted_at'],
      type: json['type'],
    );
  }

  // Method to convert a Course instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'teacher_id': teacherId,
      'created_at': createdAt?.toIso8601String(), // Convert DateTime to ISO 8601 string
      'updated_at': updatedAt?.toIso8601String(), // Convert DateTime to ISO 8601 string
      'deleted_at': deletedAt,
      'type': type,
    };
  }
}