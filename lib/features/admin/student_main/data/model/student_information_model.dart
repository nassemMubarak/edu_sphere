import 'package:edu_sphere/features/teacher/assessments/data/models/assignment_assessment_model.dart';

class StudentInformationModel {
  final int id;
  final String name;
  final String email;
  final int campId;
  final String sex;
  final int age;
  final int level;
  final String status;
  final List<Course> courses;
  final List<AssignmentAssessmentModel> assignments;
  final List<QuizAttemptModel> quizAttempts;

  StudentInformationModel({
    required this.id,
    required this.name,
    required this.email,
    required this.campId,
    required this.sex,
    required this.age,
    required this.level,
    required this.status,
    required this.courses,
    required this.assignments,
    required this.quizAttempts,
  });

  factory StudentInformationModel.fromJson(Map<String, dynamic> json) {
    return StudentInformationModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      campId: json['camp_id'],
      sex: json['sex'],
      age: json['age'],
      level: json['level'],
      status: json['status'],
      // Ensure you're mapping the 'courses' field correctly as a list
      courses: json['courses'] != null
          ? (json['courses'] as List)
          .map((courseJson) => Course.fromJson(courseJson))
          .toList()
          : [],
      // Handle the 'assignments' field as a list
      assignments: json['assignments'] != null
          ? (json['assignments'] as List)
          .map((assignmentJson) => AssignmentAssessmentModel.fromJson(assignmentJson))
          .toList()
          : [],
      // Handle the 'quiz_attempts' field as a list
      quizAttempts: json['quiz_attempts'] != null
          ? (json['quiz_attempts'] as List)
          .map((quizJson) => QuizAttemptModel.fromJson(quizJson))
          .toList()
          : [],
    );
  }
}

class Course {
  final int id;
  final String title;
  final String description;
  final String type;

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      type: json['type'],
    );
  }
}

class Assignment {
  final int id;
  final String type;
  final String title;

  Assignment({
    required this.id,
    required this.type,
    required this.title,
  });

  factory Assignment.fromJson(Map<String, dynamic> json) {
    return Assignment(
      id: json['id'],
      type: json['type'],
      title: json['title']??'assessment',  // Fallback in case title is null
    );
  }
}

class QuizAttemptModel {
  final int id;
  final int studentId;
  final int quizId;
  final String data;
  final String createdAt;
  final String updatedAt;
  final GradeModel grade;

  QuizAttemptModel({
    required this.id,
    required this.studentId,
    required this.quizId,
    required this.data,
    required this.createdAt,
    required this.updatedAt,
    required this.grade,
  });

  factory QuizAttemptModel.fromJson(Map<String, dynamic> json) {
    return QuizAttemptModel(
      id: json['id'],
      studentId: json['student_id'],
      quizId: json['quiz_id'],
      data: json['data'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      grade: GradeModel.fromJson(json['grade']),
    );
  }
}

class GradeModel {
  final int id;
  final String gradeableType;
  final int gradeableId;
  final int result;
  final String createdAt;
  final String updatedAt;

  GradeModel({
    required this.id,
    required this.gradeableType,
    required this.gradeableId,
    required this.result,
    required this.createdAt,
    required this.updatedAt,
  });

  factory GradeModel.fromJson(Map<String, dynamic> json) {
    return GradeModel(
      id: json['id'],
      gradeableType: json['gradeable_type'],
      gradeableId: json['gradeable_id'],
      result: json['result'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
