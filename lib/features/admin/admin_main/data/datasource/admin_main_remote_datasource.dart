import 'dart:convert';

import 'package:edu_sphere/core/error/exception.dart';
import 'package:edu_sphere/core/networking/api_constants.dart';
import 'package:edu_sphere/features/auth/data/models/user_model.dart';
import 'package:edu_sphere/features/auth/domain/entities/user.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

abstract class AdminMainRemoteDataSource{
  Future<List<User>> getAllTeacherInAdmin({required String token});
  Future<List<User>> getAllStudentInAdmin({required String token});
}
class AdminMainDataRemoteSourceImpl implements AdminMainRemoteDataSource{
  final http.Client client;
  AdminMainDataRemoteSourceImpl({required this.client});
  @override
  Future<List<User>> getAllTeacherInAdmin({required String token}) async{
    final header = {'Authorization': 'Bearer $token'};
    final response =await client.get(Uri.parse('${ApiConstants.apiBaseUrl}${ApiConstants.adminCampTeacher}'),headers: header);
    if(response.statusCode>=200&&response.statusCode<300){
      final List<dynamic> decodeJson = json.decode(response.body);
      Logger().w('user decodeJson----------------------$decodeJson');
      List<UserModel> listTeacher = decodeJson.map((user)=>UserModel.fromJsonUpdate(user)).toList();
      Logger().w('user teacher----------------------$listTeacher');
      return listTeacher;
    }else if(response.statusCode >= 400 && response.statusCode < 500){
      throw InvalidDataExceptionMessage(message:json.decode(response.body)['message']);
    }else{
      throw ServerException();
    }
  }

  @override
  Future<List<User>> getAllStudentInAdmin({required String token}) async{
    final header = {'Authorization': 'Bearer $token'};
    final response =await client.get(Uri.parse('${ApiConstants.apiBaseUrl}${ApiConstants.adminCampStudent}'),headers: header);
    if(response.statusCode>=200&&response.statusCode<300){
      final List<dynamic> decodeJson = json.decode(response.body);
      List<UserModel> listStudent = decodeJson.map((user)=>UserModel.fromJsonUpdate(user)).toList();
      Logger().w('user student----------------------$listStudent');
      return listStudent;
    }else if(response.statusCode >= 400 && response.statusCode < 500){
      throw InvalidDataExceptionMessage(message:json.decode(response.body)['message']);
    }else{
      throw ServerException();
    }
  }
  
}