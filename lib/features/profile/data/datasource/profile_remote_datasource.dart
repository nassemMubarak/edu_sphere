import 'dart:convert';

import 'package:edu_sphere/core/error/exception.dart';
import 'package:edu_sphere/core/networking/api_constants.dart';
import 'package:edu_sphere/features/auth/data/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

abstract class ProfileRemoteDataSource{
  Future<UserModel> getInfoUser({required String token});
  Future<UserModel> updateUser({required Map data, required String token,required bool isStudent});
}
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource{
  final http.Client client;
  ProfileRemoteDataSourceImpl({required this.client});

  @override
  Future<UserModel> getInfoUser({required String token}) async{
    final header = {'Authorization': 'Bearer $token'};
    final response = await client.get(Uri.parse('${ApiConstants.apiBaseUrl}/${ApiConstants.authInfo}'),headers: header);
    if(response.statusCode>=200&&response.statusCode<300){
      final  decodeJson = json.decode(response.body);
      UserModel user = UserModel.fromJson(decodeJson);
      Logger().w('get info user----------------------$user');
      return user;
    }else if(response.statusCode >= 400 && response.statusCode < 500){
      throw InvalidDataExceptionMessage(message:json.decode(response.body)['message']);
    }else{
      throw ServerException();
    }
  }

  @override
  Future<UserModel> updateUser({required Map data, required String token,required bool isStudent}) async{
    final header = {'Authorization': 'Bearer $token'};
    Logger().e('----------------------$data');
    final response = await client.post(Uri.parse('${ApiConstants.apiBaseUrl}${isStudent?ApiConstants.studentUpdate:ApiConstants.teacherUpdate}'),body: data,headers: header);
    if(response.statusCode>=200&&response.statusCode<300){
      final  decodeJson = json.decode(response.body);
      UserModel user = UserModel.fromJsonUpdate(decodeJson);
      Logger().w('update user----------------------$user');
      return user;
    }else if(response.statusCode >= 400 && response.statusCode < 500){
      throw InvalidDataExceptionMessage(message:json.decode(response.body)['message']);
    }else{
      throw ServerException();
    }
  }



}