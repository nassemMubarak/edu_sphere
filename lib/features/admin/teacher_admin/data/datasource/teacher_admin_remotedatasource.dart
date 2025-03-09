import 'dart:convert';

import 'package:edu_sphere/core/error/exception.dart';
import 'package:edu_sphere/core/networking/api_constants.dart';
import 'package:edu_sphere/features/admin/teacher_admin/data/model/show_course_teacher.dart';
import 'package:edu_sphere/features/admin/teacher_admin/data/model/teacher_information_model.dart';
import 'package:edu_sphere/features/admin/teacher_admin/domain/entities/teacher_informstion.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

abstract class TeacherAdminRemoteDataSource{
  Future<TeacherInformationModel> getTeacherInformationModel({required String token,required int idTeacher});
  Future<ShowCourseTeacherModel> showCourseTeacherAdmin({required String token,required int idCourse});

}
class TeacherAdminRemoteDataSourceImpl implements TeacherAdminRemoteDataSource{
  final http.Client client;
  TeacherAdminRemoteDataSourceImpl({required this.client});
  @override
  Future<TeacherInformationModel> getTeacherInformationModel({required String token, required int idTeacher}) async{
    final header = {'Authorization': 'Bearer $token'};
    final response = await client.get(Uri.parse('${ApiConstants.apiBaseUrl}${ApiConstants.adminCampsTeachers}$idTeacher'),headers: header);
    if(response.statusCode>=200&&response.statusCode<300){
      final decodeJson = json.decode(response.body);
      TeacherInformationModel teacherInformation = TeacherInformationModel.fromJson(decodeJson);
      Logger().w('teacherInformation----------------------$teacherInformation');
      return teacherInformation;
    }else if(response.statusCode >= 400 && response.statusCode < 500){
      throw InvalidDataExceptionMessage(message:json.decode(response.body)['message']);
    }else{
      throw ServerException();
    }
  }

  @override
  Future<ShowCourseTeacherModel> showCourseTeacherAdmin({required String token, required int idCourse}) async{
    final header = {'Authorization': 'Bearer $token'};
    final response = await client.get(Uri.parse('${ApiConstants.apiBaseUrl}${ApiConstants.adminCampsTeachersCourses}$idCourse'),headers: header);
    if(response.statusCode>=200&&response.statusCode<300){
      final decodeJson = json.decode(response.body);
      Logger().e(decodeJson);
      ShowCourseTeacherModel showCourseTeacherModel = ShowCourseTeacherModel.fromJson(decodeJson[0]);
      Logger().w('ShowCourseTeacherModel----------------------$showCourseTeacherModel');
      return showCourseTeacherModel;
    }else if(response.statusCode >= 400 && response.statusCode < 500){
      throw InvalidDataExceptionMessage(message:json.decode(response.body)['message']);
    }else{
      throw ServerException();
    }
  }

}