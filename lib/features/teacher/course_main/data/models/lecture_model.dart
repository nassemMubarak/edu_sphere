import 'package:edu_sphere/features/teacher/course_main/domain/entities/lecture.dart';

class LectureModel extends Lecture{
  LectureModel({required super.id, required super.title, required super.description, required super.link, required super.courseId,super.createdAt,super.updatedAt});
  // Factory constructor to create an instance from a JSON object
  factory LectureModel.fromJson(Map<String, dynamic> json) {
    return LectureModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      link: json['content'], // Map 'content' from JSON to 'link'
      courseId: json['course_id'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
    );
  }

  // Method to convert an instance to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'content': link, // Map 'link' back to 'content' for JSON
      'course_id': courseId,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}