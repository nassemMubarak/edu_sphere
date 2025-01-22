import 'package:edu_sphere/features/student/student_quiz/domain/entities/estimate_student_quiz.dart';
import 'package:edu_sphere/features/teacher/assessments/data/models/assignment_assessment_model.dart';
import 'package:edu_sphere/features/teacher/teacher_main/data/models/course_model.dart';
import 'package:equatable/equatable.dart';

class EstimatesStudent extends Equatable {
  final int id;
  final String name;
  final String email;
  final int campId;
  final String sex;
  final int age;
  final int level;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;
  final String? campName;
  final String status;
  final List<CourseModel> courses;
  final List<AssignmentAssessmentModel> assignments;
  final List<QuizAttempt> quizAttempts;

  EstimatesStudent({
    required this.id,
    required this.name,
    required this.email,
    required this.campId,
    required this.sex,
    required this.age,
    required this.level,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.campName,
    required this.status,
    required this.courses,
    required this.assignments,
    required this.quizAttempts,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    email,
    campId,
    sex,
    age,
    level,
    createdAt,
    updatedAt,
    deletedAt,
    campName,
    status,
    courses,
    assignments,
    quizAttempts,
  ];

}

