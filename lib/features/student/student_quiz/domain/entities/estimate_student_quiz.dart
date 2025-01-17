import 'package:equatable/equatable.dart';

class EstimateStudentQuiz extends Equatable {
  final int id;
  final String title;
  final String description;
  final int courseId;
  final int degree;
  final int time;
  final int visibility;
  final DateTime startIn;
  final DateTime endIn;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int resultVisible;
  final List<QuizAttempt> quizAttempts;

  const EstimateStudentQuiz({
    required this.id,
    required this.title,
    required this.description,
    required this.courseId,
    required this.degree,
    required this.time,
    required this.visibility,
    required this.startIn,
    required this.endIn,
    required this.createdAt,
    required this.updatedAt,
    required this.resultVisible,
    required this.quizAttempts,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    courseId,
    degree,
    time,
    visibility,
    startIn,
    endIn,
    createdAt,
    updatedAt,
    resultVisible,
    quizAttempts,
  ];


}
class QuizAttempt extends Equatable {
  final int id;
  final int studentId;
  final int quizId;
  final String? data;  // Optional, might be null
  final DateTime createdAt;
  final DateTime updatedAt;
  final Grade? grade;

  const QuizAttempt({
    required this.id,
    required this.studentId,
    required this.quizId,
    this.data,
    required this.createdAt,
    required this.updatedAt,
    this.grade,
  });

  @override
  List<Object?> get props => [
    id,
    studentId,
    quizId,
    data,
    createdAt,
    updatedAt,
    grade,
  ];

  factory QuizAttempt.fromJson(Map<String, dynamic> json) {
    return QuizAttempt(
      id: json['id'] as int,
      studentId: json['student_id'] as int,
      quizId: json['quiz_id'] as int,
      data: json['data'] as String?,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      grade: json['grade'] != null ? Grade.fromJson(json['grade']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'student_id': studentId,
      'quiz_id': quizId,
      'data': data,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'grade': grade?.toJson(),
    };
  }
}

// Represents the grade of a quiz attempt
class Grade extends Equatable {
  final int id;
  final String gradeableType;
  final int gradeableId;
  final int result;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Grade({
    required this.id,
    required this.gradeableType,
    required this.gradeableId,
    required this.result,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
    id,
    gradeableType,
    gradeableId,
    result,
    createdAt,
    updatedAt,
  ];

  factory Grade.fromJson(Map<String, dynamic> json) {
    return Grade(
      id: json['id'] as int,
      gradeableType: json['gradeable_type'] as String,
      gradeableId: json['gradeable_id'] as int,
      result: json['result'] as int,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'gradeable_type': gradeableType,
      'gradeable_id': gradeableId,
      'result': result,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
