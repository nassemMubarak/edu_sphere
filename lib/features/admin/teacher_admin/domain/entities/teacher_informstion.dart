import 'package:edu_sphere/features/auth/data/models/user_model.dart';
import 'package:edu_sphere/features/auth/domain/entities/user.dart';
import 'package:edu_sphere/features/communication/data/domain/communication_model.dart';
import 'package:edu_sphere/features/teacher/teacher_main/data/models/course_model.dart';
import 'package:equatable/equatable.dart';

class TeacherInformation extends Equatable {
  final User teacher;
  final List<CourseModel> courses;
  final List<CommunicationModel> communications;
  final List<UserModel> students;

  TeacherInformation({
    required this.teacher,
    required this.courses,
    required this.communications,
    required this.students,
  });

  @override
  List<Object?> get props => [teacher, courses, communications, students];
}