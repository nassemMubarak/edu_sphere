import 'package:edu_sphere/features/communication/data/domain/communication_model.dart';
import 'package:edu_sphere/features/student/show_studetn_course_teachers/domain/entities/show_student_teacher.dart';
import 'package:edu_sphere/features/teacher/teacher_main/data/models/course_model.dart';

class ShowStudentTeacherModel extends ShowStudentTeacher {
  ShowStudentTeacherModel({
    required super.id,
    required super.name,
    required super.email,
    required super.specialization,
    required super.sex,
    required super.phoneNumber,
    required super.age,
    required super.createdAt,
    required super.updatedAt,
    required super.communications,
    required super.courses,
    super.deletedAt,
  });
  factory ShowStudentTeacherModel.fromJson(Map<String, dynamic> json) {
    return ShowStudentTeacherModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      specialization: json['specialization'],
      sex: json['sex'],
      phoneNumber: json['phone_number'],
      age: json['age'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      deletedAt: json['deleted_at'] != null ? DateTime.parse(json['deleted_at']) : null,
      communications: (json['communications'] as List)
          .map((e) => CommunicationModel.fromJson(e))
          .toList(),
      courses: (json['courses'] as List).map((e) => CourseModel.fromJson(e)).toList(),
    );
  }

}
