import 'dart:convert';

import 'package:edu_sphere/core/error/exception.dart';
import 'package:edu_sphere/core/networking/api_constants.dart';
import 'package:edu_sphere/features/auth/data/models/user_model.dart';
import 'package:edu_sphere/features/auth/domain/entities/user.dart';
import 'package:edu_sphere/features/student/show_studetn_course_teachers/data/model/show_student_teacher_model.dart';
import 'package:edu_sphere/features/student/show_studetn_course_teachers/domain/entities/show_student_teacher.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';


abstract class ShowStudentTeacherRemoteDatasource{
  Future<List<User>> getAllStudentTeacher({required String token});
  Future<ShowStudentTeacherModel> showTeacherInformation({required String token,required int idTeacher});

}
class ShowStudentTeacherRemoteDatasourceImpl implements ShowStudentTeacherRemoteDatasource{
  final http.Client client;
  ShowStudentTeacherRemoteDatasourceImpl({required this.client});

  @override
  Future<List<User>> getAllStudentTeacher({required String token}) async{
    final header = {'Authorization': 'Bearer $token'};
    final response = await client.get(Uri.parse('${ApiConstants.apiBaseUrl}${ApiConstants.studentTeachers}'),headers: header);
    if(response.statusCode>=200&&response.statusCode<300){
      final List<dynamic> decodeJson = json.decode(response.body);
      Logger().w('response.body----------------------${response.body}');
      List<UserModel> listStudentTeacher = decodeJson.map((course)=>UserModel.fromJsonUpdate(course)).toList();
      Logger().w('listStudentTeacher----------------------$listStudentTeacher');
      return listStudentTeacher;
    }else if(response.statusCode >= 400 && response.statusCode < 500){
      throw InvalidDataExceptionMessage(message:json.decode(response.body)['message']);
    }else{
      throw ServerException();
    }
  }

  @override
  Future<ShowStudentTeacherModel> showTeacherInformation({required String token, required int idTeacher}) async{
    final header = {'Authorization': 'Bearer $token'};
    final response = await client.get(Uri.parse('${ApiConstants.apiBaseUrl}${ApiConstants.studentTeachers}/show/$idTeacher'),headers: header);
    if(response.statusCode>=200&&response.statusCode<300){
      final decodeJson = json.decode(response.body);
      ShowStudentTeacherModel showStudentTeacher = ShowStudentTeacherModel.fromJson(decodeJson);
      Logger().w('showStudentTeacher----------------------$showStudentTeacher');
      return showStudentTeacher;
    }else if(response.statusCode >= 400 && response.statusCode < 500){
      throw InvalidDataExceptionMessage(message:json.decode(response.body)['message']);
    }else{
      throw ServerException();
    }
  }

}