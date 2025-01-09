import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:edu_sphere/features/teacher/assessments/data/models/document_assessment_model.dart';
import 'package:edu_sphere/features/teacher/assessments/domain/entities/document_assessment.dart';
import 'package:edu_sphere/features/teacher/course_main/data/models/advertisement_model.dart';
import 'package:edu_sphere/features/teacher/course_main/data/models/lecture_model.dart';
import 'package:edu_sphere/features/teacher/course_main/domain/entities/advertisement.dart';
import 'package:edu_sphere/features/teacher/course_main/domain/entities/lecture.dart';
import 'package:edu_sphere/features/teacher/teacher_main/data/models/course_model.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../../../../../core/error/exception.dart';
import '../../../../../core/networking/api_constants.dart';

abstract class StudentMainRemoteDataSource{
  Future<List<CourseModel>> getAllStudentCourses({required String token});
  Future<List<CourseModel>> getAllSubscribeStudentCourses({required String token});
  Future<Unit> subscribeStudentCourse({required int idCourse,required String token});
  Future<Unit> leaveStudentCourse({required int idCourse,required String token});
  Future<List<AdvertisementModel>> getAllStudentAdvertisementCourse({required int idCourse,required String token});
  Future<List<LectureModel>> getAllStudentLectureCourse({required int idCourse,required String token});
  Future<List<DocumentAssessmentModel>> getAllStudentDocumentCourse({required int idCourse,required String token});
}
class StudentMainRemoteDataSourceImpl implements StudentMainRemoteDataSource{
  final http.Client client;
  StudentMainRemoteDataSourceImpl({required this.client});
  @override
  Future<List<CourseModel>> getAllStudentCourses({required String token}) async{
    final header = {'Authorization': 'Bearer $token'};
    final response = await client.get(Uri.parse('${ApiConstants.apiBaseUrl}${ApiConstants.studentCoursesAvailable}'),headers: header);
    if(response.statusCode>=200&&response.statusCode<300){
      final List<dynamic> decodeJson = json.decode(response.body);
      List<CourseModel> listCourses = decodeJson.map((course)=>CourseModel.fromJson(course)).toList();
      Logger().w('studentCoursesAvailable listCourses----------------------$listCourses');
      return listCourses;
    }else if(response.statusCode >= 400 && response.statusCode < 500){
      throw InvalidDataException();
    }else{
      throw ServerException();
    }
  }
  @override
  Future<List<CourseModel>> getAllSubscribeStudentCourses({required String token}) async{
    final header = {'Authorization': 'Bearer $token'};
    final response = await client.get(Uri.parse('${ApiConstants.apiBaseUrl}${ApiConstants.studentCourses}'),headers: header);
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
  Future<Unit> subscribeStudentCourse({required int idCourse,required String token}) async{
    final header = {'Authorization': 'Bearer $token'};
    final response = await client.get(Uri.parse('${ApiConstants.apiBaseUrl}${ApiConstants.studentCoursesJoin}/$idCourse'),headers: header);
    if(response.statusCode>=200&&response.statusCode<300){
      return unit;
    }else if(response.statusCode >= 400 && response.statusCode < 500){
      throw InvalidDataException();
    }else{
      throw ServerException();
    }
  }
  @override
  Future<List<AdvertisementModel>> getAllStudentAdvertisementCourse({required int idCourse,required String token})async {
    final header = {'Authorization': 'Bearer $token'};
    final response = await client.get(Uri.parse('${ApiConstants.apiBaseUrl}${ApiConstants.studentCourses}/$idCourse/${ApiConstants.advertisements}'),headers: header);
    if(response.statusCode>=200&&response.statusCode<300){
      final List<dynamic> decodeJson = json.decode(response.body);
      List<AdvertisementModel> listAdvertisementModel = decodeJson.map((course)=>AdvertisementModel.fromJson(course)).toList();
      Logger().w('listAdvertisementModel----------------------$listAdvertisementModel');
      return listAdvertisementModel;
    }else if(response.statusCode >= 400 && response.statusCode < 500){
      throw InvalidDataException();
    }else{
      throw ServerException();
    }
  }



  @override
  Future<List<DocumentAssessmentModel>> getAllStudentDocumentCourse({required int idCourse,required String token}) async{
    final header = {'Authorization': 'Bearer $token'};
    final response = await client.get(Uri.parse('${ApiConstants.apiBaseUrl}${ApiConstants.studentCourses}/$idCourse/${ApiConstants.documents}'),headers: header);
    if(response.statusCode>=200&&response.statusCode<300){
      final List<dynamic> decodeJson = json.decode(response.body);
      List<DocumentAssessmentModel> listDocument = decodeJson.map((document)=>DocumentAssessmentModel.fromJson(document)).toList();
      Logger().w('listDocument----------------------$listDocument');
      return listDocument;
    }else if(response.statusCode >= 400 && response.statusCode < 500){
      throw InvalidDataException();
    }else{
      throw ServerException();
    }
  }

  @override
  Future<List<LectureModel>> getAllStudentLectureCourse({required int idCourse,required String token}) async{
    final header = {'Authorization': 'Bearer $token'};
    final response = await client.get(Uri.parse('${ApiConstants.apiBaseUrl}${ApiConstants.studentCourses}/$idCourse/${ApiConstants.lectures}'),headers: header);
    Logger().w('$token---------${response.statusCode}----///////-------------->${ApiConstants.apiBaseUrl}${ApiConstants.teacherCourses}/$idCourse/${ApiConstants.lectures}');
    if(response.statusCode>=200&&response.statusCode<300){
      final List<dynamic> decodeJson = json.decode(response.body);
      List<LectureModel> listLecture = decodeJson.map((lecture)=>LectureModel.fromJson(lecture)).toList();
      Logger().w('listAdvertisementModel----------------------$listLecture');
      return listLecture;
    }else if(response.statusCode >= 400 && response.statusCode < 500){
      throw InvalidDataException();
    }else{
      throw ServerException();
    }
  }

  @override
  Future<Unit> leaveStudentCourse({required int idCourse, required String token}) async{
    final header = {'Authorization': 'Bearer $token'};
    final response = await client.get(Uri.parse('${ApiConstants.apiBaseUrl}${ApiConstants.studentCourses}/leave/$idCourse'),headers: header);
    if(response.statusCode>=200&&response.statusCode<300){
      return unit;
    }else if(response.statusCode >= 400 && response.statusCode < 500){
      throw InvalidDataException();
    }else{
      throw ServerException();
    }
  }
}