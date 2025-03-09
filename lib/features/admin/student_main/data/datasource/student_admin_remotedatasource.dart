import 'dart:convert';

import 'package:edu_sphere/core/error/exception.dart';
import 'package:edu_sphere/core/networking/api_constants.dart';
import 'package:edu_sphere/features/admin/student_main/data/model/student_information_model.dart';
import 'package:edu_sphere/features/admin/teacher_admin/data/model/show_course_teacher.dart';
import 'package:edu_sphere/features/admin/teacher_admin/data/model/teacher_information_model.dart';
import 'package:edu_sphere/features/admin/teacher_admin/domain/entities/teacher_informstion.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

abstract class StudentAdminRemoteDataSource{
  Future<StudentInformationModel> getStudentInformationModel({required String token,required int idStudent});

}
class StudentAdminRemoteDataSourceImpl implements StudentAdminRemoteDataSource{
  final http.Client client;
  StudentAdminRemoteDataSourceImpl({required this.client});
  @override
  Future<StudentInformationModel> getStudentInformationModel({required String token, required int idStudent}) async {
    final header = {'Authorization': 'Bearer $token'};
    Logger().f('${ApiConstants.apiBaseUrl}${ApiConstants.adminCampsStudents}$idStudent');

    final response = await client.get(
      Uri.parse('${ApiConstants.apiBaseUrl}${ApiConstants.adminCampsStudents}$idStudent'),
      headers: header,
    );

    Logger().f('Response body: ${response.body}'); // Debugging the response

    final decodeJson = json.decode(response.body);

    if (decodeJson is List) {
      // If the response is a list of students, parse accordingly
      List<StudentInformationModel> students = decodeJson
          .map((studentJson) => StudentInformationModel.fromJson(studentJson))
          .toList();
      return students.isNotEmpty ? students[0] : throw Exception("No student found");
    } else if (decodeJson is Map<String, dynamic>) {
      // If the response is a map (single student), parse it directly
      return StudentInformationModel.fromJson(decodeJson);
    } else {
      throw FormatException("Unexpected response format");
    }
  }
}