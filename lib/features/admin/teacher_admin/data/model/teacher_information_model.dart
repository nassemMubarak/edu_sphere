import 'package:edu_sphere/features/admin/teacher_admin/domain/entities/teacher_informstion.dart';
import 'package:edu_sphere/features/auth/data/models/user_model.dart';
import 'package:edu_sphere/features/communication/data/domain/communication_model.dart';
import 'package:edu_sphere/features/teacher/teacher_main/data/models/course_model.dart';

class TeacherInformationModel extends TeacherInformation {
  TeacherInformationModel({
    required super.teacher,
    required super.courses,
    required super.communications,
    required super.students,
  });

  // Convert a JSON object into a TeacherInformation object
  factory TeacherInformationModel.fromJson(Map<String, dynamic> json) {
    return TeacherInformationModel(
      teacher: UserModel.fromJsonUpdate(json['teacher']),
      courses: (json['courses'] as List)
          .map((courseJson) => CourseModel.fromJson(courseJson))
          .toList(),
      communications: (json['communications'] as List)
          .map((communicationJson) =>
          CommunicationModel.fromJson(communicationJson))
          .toList(),
      students: (json['students'] as List).map((studentJson) =>
          UserModel.fromJsonUpdate(studentJson))
          .toList(),
    );
  }
}
