import 'package:edu_sphere/features/admin/teacher_admin/data/model/assessment_course_admin.dart';
import 'package:edu_sphere/features/teacher/assessments/data/models/assignment_assessment_model.dart';
import 'package:edu_sphere/features/teacher/course_main/data/models/advertisement_model.dart';
import 'package:edu_sphere/features/teacher/course_main/data/models/lecture_model.dart';
import 'package:edu_sphere/features/teacher/quiz/data/models/quiz_model.dart';

import '../../domain/entities/show_teacher_courses.dart';

class ShowCourseTeacherModel extends ShowCourseTeacher {
  ShowCourseTeacherModel({
    required super.id,
    required super.title,
    required super.description,
    required super.teacherId,
    required super.createdAt,
    required super.updatedAt,
    required super.type,
    required super.lectures,
    required super.assignments,
    required super.quizzes,
    required super.advertisements,
    super.deletedAt,
  });
  factory ShowCourseTeacherModel.fromJson(Map<String, dynamic> json) {
    return ShowCourseTeacherModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      teacherId: json['teacher_id'],
      deletedAt: json['deleted_at'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      type: json['type'],
      // Ensure each field is correctly parsed as a list
      lectures: json['lectures'] is List
          ? List<LectureModel>.from(
          json['lectures'].map((x) => LectureModel.fromJson(x)))
          : [],
      assignments: json['assignments'] is List
          ? List<AssessmentCourseAdmin>.from(
          json['assignments'].map((x) => AssessmentCourseAdmin.fromJson(x)))
          : [],
      quizzes: json['quizzes'] is List
          ? List<QuizModel>.from(json['quizzes'].map((x) => QuizModel.fromJson(x)))
          : [],
      advertisements: json['advertisements'] is List
          ? List<AdvertisementModel>.from(
          json['advertisements'].map((x) => AdvertisementModel.fromJson(x)))
          : [],    );
  }

}
