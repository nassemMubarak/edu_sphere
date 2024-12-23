import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:edu_sphere/core/error/exception.dart';
import 'package:edu_sphere/core/networking/api_constants.dart';
import 'package:edu_sphere/features/auth/data/models/camp_model.dart';
import 'package:edu_sphere/features/auth/data/models/user_model.dart';
import 'package:edu_sphere/features/auth/data/models/user_response_model.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

abstract class AuthRemoteDataSource {
  Future<UserResponseModel> loginUser({required Map authData});

  Future<UserResponseModel> registerUser({required Map authData});

  Future<Unit> sendCodeToForgetPassword({required String email});

  Future<Unit> codeCheckForgetPassword(
      {required String email, required String code});

  Future<Unit> updatePassword(
      {required String token, required String password});
  Future<List<CampModel>> getAllCamp();
}


class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;
  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<UserResponseModel> registerUser({required Map authData}) async {
    final body = authData['level']!=null?{
      "name": authData['name'],
      "email": authData['email'],
      "password": authData['password'],
      "password_confirmation": authData['password_confirmation'],
      "age": authData['age'],
      "sex": authData['sex'],
      "phone_number": authData['phone_number'],
      "camp_id": authData['camp_id'], // Convert to String
      "level": authData['level']
    }:{
      "name": authData['name'],
      "email": authData['email'],
      "password": authData['password'],
      "password_confirmation": authData['password_confirmation'],
      "age": authData['age'],
      "sex": authData['sex'],
      "phone_number": authData['phone_number'],
      "specialization": authData['specialization']
    };

        late var response;
      try{
       response = await client.post(Uri.parse( authData['level']!=null?'${ApiConstants.apiBaseUrl}/student/register':'${ApiConstants.apiBaseUrl}/teacher/register'), body: body);
      }on Exception{
        throw ServerException();
      };
    if (response.statusCode >= 200 && response.statusCode < 300) {
      final decodeJson = json.decode(response.body);
      UserResponseModel userResponseModel = UserResponseModel.fromJson(decodeJson);
      return userResponseModel;
    } else if (response.statusCode >= 400 && response.statusCode < 500) {
      throw InvalidDataException();
    } else {
      throw ServerException();
    }

  }

  @override
  Future<UserResponseModel> loginUser({required Map authData}) async {
    final body = {"email": authData['email'], "password": authData['password']};
    final response =
        await client.post(Uri.parse('${ApiConstants.apiBaseUrl}/login'), body: body);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      final decodeJson = json.decode(response.body);
      UserResponseModel userResponseModel = UserResponseModel.fromJson(decodeJson);
      return userResponseModel;
    }else if (response.statusCode >= 400 && response.statusCode < 500) {
      throw InvalidDataException();
    } else {
      throw ServerException();
    }
  }
  @override
  Future<Unit> sendCodeToForgetPassword({required String email}) async{
    final body = {"email":email};
    final response = await client.post(Uri.parse('${ApiConstants.apiBaseUrl}/student/resit_password/otp'),body: body);
    if(response.statusCode>=200&&response.statusCode<300){
      return Future.value(unit);
    }else if(response.statusCode >= 400 && response.statusCode < 500){
      throw InvalidDataException();
    }else{
      throw ServerException();
    }
  }
  @override
  Future<List<CampModel>> getAllCamp() async{
    final response = await client.get(Uri.parse('${ApiConstants.apiBaseUrl}/camp/getAll'));
    if(response.statusCode>=200&&response.statusCode<300){
      final List<dynamic> decodedJson = json.decode(response.body);
      List<CampModel> listCampModel = decodedJson.map((json) => CampModel.fromJson(json)).toList();
      Logger().w(listCampModel);
      return listCampModel;
    }else if(response.statusCode >= 400 && response.statusCode < 500){
      throw InvalidDataException();
    }else{
      throw ServerException();
    }
   
  }
  @override
  Future<Unit> codeCheckForgetPassword(
      {required String email, required String code})async {
      final body = {
        'email':email,
        'otp':code
      };
      final response = await client.post(Uri.parse('${ApiConstants.apiBaseUrl}/student/resit_password/check_otp'),body: body);
      if(response.statusCode>=200&&response.statusCode<300){
        return Future.value(unit);
      }else if(response.statusCode >= 400 && response.statusCode < 500){
        throw InvalidDataException();
      }else{
        throw ServerException();
      }
  }
  @override
  Future<Unit> updatePassword(
      {required String token, required String password}) {
    // TODO: implement updatePassword
    throw UnimplementedError();
  }

 
}
