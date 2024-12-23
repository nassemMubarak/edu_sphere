import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:edu_sphere/core/error/exception.dart';
import 'package:edu_sphere/core/networking/api_constants.dart';
import 'package:edu_sphere/features/teacher/teacher_main/data/models/course_model.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
abstract class TeacherMainRemoteDataSource{
  Future<List<CourseModel>> getAllCourses({required String token});
  Future<CourseModel> addCourse({required Map courseData,required String token});
  Future<Unit> updateCourse({required Map courseData,required int id,required String token});
  Future<Unit> deleteCourse({required int id,required String token});
}
class TeacherMainRemoteDataSourceImpl implements TeacherMainRemoteDataSource{
  final http.Client client;
  TeacherMainRemoteDataSourceImpl({required this.client});
  @override
  Future<List<CourseModel>> getAllCourses({required String token}) async{
    final header = {'Authorization': 'Bearer $token'};
    final response = await client.get(Uri.parse('${ApiConstants.apiBaseUrl}${ApiConstants.teacherCourses}'),headers: header);
    if(response.statusCode>=200&&response.statusCode<300){
      final List<dynamic> decodeJson = json.decode(response.body);
      List<CourseModel> listCourses = decodeJson.map((course)=>CourseModel.fromJson(course)).toList();
      Logger().w('listCourses----------------------$listCourses');
      return listCourses;
    }else if(response.statusCode >= 400 && response.statusCode < 500){
      throw InvalidDataException();
    }else{
      throw ServerException();
    }
  }
  @override
  Future<CourseModel> addCourse({required Map courseData,required String token}) async{
    final header = {'Authorization': 'Bearer $token'};
    final response = await client.post(Uri.parse('${ApiConstants.apiBaseUrl}${ApiConstants.teacherCourses}'),headers: header);
    return _addCourse(response);
  }
  @override
  Future<Unit> updateCourse({required Map courseData,required int id,required String token}) async{
    final header = {'Authorization': 'Bearer $token'};
    final response = await client.put(Uri.parse('${ApiConstants.apiBaseUrl}${ApiConstants.teacherCourses}/$id'),headers: header);
    return _returnUnitOrException(response: response);
  }

  @override
  Future<Unit> deleteCourse({required int id,required String token})async {
    final header = {'Authorization': 'Bearer $token'};
    final response = await client.delete(Uri.parse('${ApiConstants.apiBaseUrl}${ApiConstants.teacherCourses}/$id'),headers: header);
    return _returnUnitOrException(response: response);
  }



  Future<Unit> _returnUnitOrException({required http.Response response}){
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return Future.value(unit);
    } else if (response.statusCode >= 400 && response.statusCode < 500) {
      throw InvalidDataException();
    } else {
      throw ServerException();
    }
  }
  Future<CourseModel> _addCourse(http.Response response)async{
    if(response.statusCode>=200&&response.statusCode<300){
      final decodeJson = json.decode(response.body);
      CourseModel courseModel = CourseModel.fromJson(decodeJson);
      Logger().w('courseModel----------------------$courseModel');
      return courseModel;
    }else if(response.statusCode >= 400 && response.statusCode < 500){
      throw InvalidDataException();
    }else{
      throw ServerException();
    }
  }
}

