import 'package:edu_sphere/features/student/student_quiz/domain/entities/estimate_student_quiz.dart';

class EstimateStudentQuizModel extends EstimateStudentQuiz {
  const EstimateStudentQuizModel({
    required super.id,
    required super.title,
    required super.description,
    required super.courseId,
    required super.degree,
    required super.time,
    required super.visibility,
    required super.startIn,
    required super.endIn,
    required super.createdAt,
    required super.updatedAt,
    required super.resultVisible,
    required super.quizAttempts,
  });

  factory EstimateStudentQuizModel.fromJson(Map<String, dynamic> json) {
    return EstimateStudentQuizModel(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      courseId: json['course_id'] as int,
      degree: json['degree'] as int,
      time: json['time'] as int,
      visibility: json['visibility'] as int,
      startIn: DateTime.parse(json['start_in']),
      endIn: DateTime.parse(json['end_in']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      resultVisible: json['result_visible'] as int,
      quizAttempts: (json['quiz_attempts'] as List<dynamic>)
          .map((attempt) => QuizAttempt.fromJson(attempt))
          .toList(),
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
      'start_in': startIn.toIso8601String(),
      'end_in': endIn.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'result_visible': resultVisible,
      'quiz_attempts': quizAttempts.map((attempt) => attempt.toJson()).toList(),
    };
  }
}
