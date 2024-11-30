import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:edu_sphere/core/error/exception.dart';
import 'package:edu_sphere/features/auth/data/models/user_model.dart';
import 'package:http/http.dart' as http;

abstract class AuthRemoteDataSource {
  Future<UserModel> loginUser({required Map authData});

  Future<UserModel> registerUser({required Map authData});

  Future<Unit> sendCodeToForgetPassword({required String email});

  Future<Unit> codeCheckForgetPassword(
      {required String email, required String code});

  Future<Unit> updatePassword(
      {required String token, required String password});
}

const BASE_URI = 'https://eduspherepal.com/api';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;

  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<UserModel> registerUser({required Map authData}) async {
    final body = {
      "name": authData['name'],
      "email": authData['email'],
      "password": authData['password'],
      "password_confirmation": authData['password_confirmation'],
      "age": authData['age'],
      "sex": authData['sex'],
      "phone_number": authData['phone_number'],
      "camp_id": authData['camp_id'], // Convert to String
      "level": authData['level']
    };
    final response =
        await client.post(Uri.parse('$BASE_URI/auth/signup'), body: body);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      final decodeJson = json.decode(response.body);
      UserModel userModel = UserModel.fromJson(decodeJson['user']);
      return userModel;
    } else if (response.statusCode >= 400 && response.statusCode < 500) {
      throw InvalidDataException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> loginUser({required Map authData}) async {
    final body = {"email": authData['email'], "password": authData['password']};
    final response =
        await client.post(Uri.parse('$BASE_URI/auth/login'), body: body);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      final decodeJson = json.decode(response.body);
      UserModel userModel = UserModel.fromJson(decodeJson['user']);
      return userModel;
    }else if (response.statusCode >= 400 && response.statusCode < 500) {
      throw InvalidDataException();
    } else {
      throw ServerException();
    }
  }
  @override
  Future<Unit> sendCodeToForgetPassword({required String email}) async{
    final body = {"email":email};
    final response = await client.post(Uri.parse('$BASE_URI/student/resit_password/otp'),body: body);
    if(response.statusCode>=200&&response.statusCode<300){
      return Future.value(unit);
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
      final response = await client.post(Uri.parse('$BASE_URI/student/resit_password/check_otp'),body: body);
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
