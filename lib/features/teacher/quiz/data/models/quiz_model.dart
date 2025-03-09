import 'package:logger/logger.dart';

import '../../domain/entities/quiz.dart';

class QuizModel extends Quiz {
  QuizModel({
    required super.id,
     super.title,
    required super.description,
    required super.time,
    required super.degree,
    required super.visibility,
    required super.startIn,
    required super.endIn,
    required super.courseId,
     super.createdAt,
     super.updatedAt,
    super.resultVisible,
  });

  factory QuizModel.fromJson(Map<String, dynamic> json) {
    return QuizModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      courseId: json['course_id'],
      degree: json['degree'].toString(),
      time: json['time'].toString(),
      visibility: int.parse(json['visibility'].toString()),
      startIn: DateTime.parse(json['start_in']), // Convert string to DateTime
      endIn: DateTime.parse(json['end_in']), // Convert string to DateTime
      createdAt: json['created_at'],  // Nullable field
      updatedAt: json['updated_at'],  // Nullable field
      resultVisible: json['result_visible'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'course_id': courseId,
      'degree': degree,
      'time': time,
      'visibility': visibility,
      'start_in': startIn.toIso8601String(), // Convert DateTime to String
      'end_in': endIn.toIso8601String(), // Convert DateTime to String
      'created_at': createdAt,
      'updated_at': updatedAt,
      'result_visible': resultVisible,
    };
  }
}
