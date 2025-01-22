import 'package:edu_sphere/features/student/estimates_students/domain/entities/estimates_student.dart';
import 'package:edu_sphere/features/student/student_quiz/domain/entities/estimate_student_quiz.dart';
import 'package:edu_sphere/features/teacher/assessments/data/models/assignment_assessment_model.dart';
import 'package:edu_sphere/features/teacher/teacher_main/data/models/course_model.dart';

class EstimatesStudentModel extends EstimatesStudent {
  EstimatesStudentModel({
    required super.id,
    required super.name,
    required super.email,
    required super.campId,
    required super.sex,
    required super.age,
    required super.level,
    required super.createdAt,
    required super.updatedAt,
    required super.status,
    required super.courses,
    required super.assignments,
    required super.quizAttempts,
    super.campName,
    super.deletedAt
  });

  // Factory method to create EstimatesStudent from JSON
  factory EstimatesStudentModel.fromJson(Map<String, dynamic> json) {
    return EstimatesStudentModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      campId: json['camp_id'],
      sex: json['sex'],
      age: json['age'],
      level: json['level'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],
      campName: json['camp_name'],
      status: json['status'],
      courses: (json['courses'] as List)
          .map((courseJson) => CourseModel.fromJson(courseJson))
          .toList(),
      assignments: (json['assignments'] as List)
          .map((assignmentJson) => AssignmentAssessmentModel.fromJson(assignmentJson))
          .toList(),
      quizAttempts: (json['quiz_attempts'] as List)
          .map((quizAttemptJson) => QuizAttempt.fromJson(quizAttemptJson))
          .toList(),
    );
  }
}
