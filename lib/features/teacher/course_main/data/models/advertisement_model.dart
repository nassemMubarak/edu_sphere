import 'package:edu_sphere/features/teacher/course_main/domain/entities/advertisement.dart';

class AdvertisementModel extends Advertisement{
  AdvertisementModel({required super.id, required super.courseId, required super.text, required super.color,super.createdAt,super.updatedAt});
  // Factory constructor for creating an AdvertisementModel from JSON
  factory AdvertisementModel.fromJson(Map<String, dynamic> json) {
    return AdvertisementModel(
      id: json['id'] as int,
      courseId: json['course_id'] as int,
      text: json['text'] as String,
      color: json['color'] as String,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  // Method to convert AdvertisementModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'course_id': courseId,
      'text': text,
      'color': color,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
