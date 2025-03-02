import 'package:edu_sphere/features/teacher/quiz/domain/entities/estimate_quiz.dart';
import 'package:logger/logger.dart';

class EstimateQuizModels extends EstimateQuiz{
  EstimateQuizModels({required super.id, required super.quizId, required super.createdAt, required super.updatedAt, required super.student, required super.grade});

  factory EstimateQuizModels.fromJson(Map<String, dynamic> json) {
    Logger().f('---------+++++++++++5555555555555555555${json['grade']}');
    return EstimateQuizModels(
      id: json['id'],
      quizId: json['quiz_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      student: Student.fromJson(json['student']),
      grade: Grade.fromJson(json['grade']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quiz_id': quizId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'student': student.toJson(),
      'grade': grade.toJson(),
    };
  }
}