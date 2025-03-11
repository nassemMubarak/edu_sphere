import 'package:edu_sphere/features/communication/data/domain/communication_model.dart';
import 'package:edu_sphere/features/teacher/teacher_main/data/models/course_model.dart';
import 'package:equatable/equatable.dart';

class ShowStudentTeacher extends Equatable {
  final int id;
  final String name;
  final String email;
  final String specialization;
  final String sex;
  final String? phoneNumber;
  final int age;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final List<CommunicationModel> communications;
  final List<CourseModel> courses;

  ShowStudentTeacher({
    required this.id,
    required this.name,
    required this.email,
    required this.specialization,
    required this.sex,
     this.phoneNumber,
    required this.age,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.communications,
    required this.courses,
  });


  @override
  List<Object?> get props => [
    id,
    name,
    email,
    specialization,
    sex,
    phoneNumber,
    age,
    createdAt,
    updatedAt,
    deletedAt,
    communications,
    courses,
  ];
}
