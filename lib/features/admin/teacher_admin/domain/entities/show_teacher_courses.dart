import 'dart:convert';

import 'package:edu_sphere/features/admin/teacher_admin/data/model/assessment_course_admin.dart';
import 'package:edu_sphere/features/teacher/assessments/data/models/assignment_assessment_model.dart';
import 'package:edu_sphere/features/teacher/course_main/data/models/advertisement_model.dart';
import 'package:edu_sphere/features/teacher/course_main/data/models/lecture_model.dart';
import 'package:edu_sphere/features/teacher/course_main/domain/entities/lecture.dart';
import 'package:edu_sphere/features/teacher/quiz/data/models/quiz_model.dart';

// Course Model
class ShowCourseTeacher {
  int id;
  String title;
  String description;
  int teacherId;
  String? deletedAt;
  DateTime createdAt;
  DateTime updatedAt;
  String type;
  List<Lecture> lectures;
  List<AssessmentCourseAdmin> assignments;
  List<QuizModel> quizzes;
  List<AdvertisementModel> advertisements;

  ShowCourseTeacher({
    required this.id,
    required this.title,
    required this.description,
    required this.teacherId,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.type,
    required this.lectures,
    required this.assignments,
    required this.quizzes,
    required this.advertisements,
  });



}
