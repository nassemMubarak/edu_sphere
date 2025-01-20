import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:edu_sphere/core/error/exception.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/core/networking/api_constants.dart';
import 'package:edu_sphere/features/communication/data/domain/communication_model.dart';
import 'package:edu_sphere/features/communication/domain/entities/communication.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

abstract class CommunicationRemoteDataSource{
  Future<List<CommunicationModel>> getAllCommunication({required String token,required bool isStudent});
  Future<CommunicationModel> addCommunication({required String token,required Map data,required bool isStudent});
  Future<Unit> updateCommunication({required String token,required Map data,required int id,required bool isStudent});

}
class CommunicationRemoteDataSourceImpl implements CommunicationRemoteDataSource{
  final http.Client client;
  CommunicationRemoteDataSourceImpl({required this.client});
  @override
  Future<List<CommunicationModel>> getAllCommunication({required String token,required bool isStudent}) async{
    final header = {'Authorization': 'Bearer $token'};
    final response = await client.get(Uri.parse('${ApiConstants.apiBaseUrl}${isStudent?ApiConstants.studentCommunications:ApiConstants.teacherCommunications}'),headers: header);
    if(response.statusCode>=200&&response.statusCode<300){
      final List<dynamic> decodeJson = json.decode(response.body);
      List<CommunicationModel> listCommunication = decodeJson.map((communication)=>CommunicationModel.fromJson(communication)).toList();
      Logger().w('listCommunication----------------------$listCommunication');
      return listCommunication;
    }else if(response.statusCode >= 400 && response.statusCode < 500){
      throw InvalidDataExceptionMessage(message:json.decode(response.body)['message']);
    }else{
      throw ServerException();
    }
  }
  @override
  Future<CommunicationModel> addCommunication({required String token, required Map data,required bool isStudent}) async{
    Logger().e('${ApiConstants.apiBaseUrl}${isStudent?ApiConstants.studentCommunications:ApiConstants.teacherCommunications}');

    final header = {'Authorization': 'Bearer $token'};
    final response = await client.post(Uri.parse('${ApiConstants.apiBaseUrl}${isStudent?ApiConstants.studentCommunications:ApiConstants.teacherCommunications}'),body: data,headers: header);
    if(response.statusCode>=200&&response.statusCode<300){
      final decodeJson = json.decode(response.body);
      CommunicationModel communication = CommunicationModel.fromJson(decodeJson);
      Logger().w('communication----------------------$communication');
      return communication;
    }else if(response.statusCode >= 400 && response.statusCode < 500){
      throw InvalidDataExceptionMessage(message:json.decode(response.body)['message']);
    }else{
      throw ServerException();
    }
  }


  @override
  Future<Unit> updateCommunication({required String token, required Map data,required int id,required bool isStudent}) async{
    final header = {'Authorization': 'Bearer $token'};
    final response = await client.put(Uri.parse('${ApiConstants.apiBaseUrl}${isStudent?ApiConstants.studentCommunications:ApiConstants.teacherCommunications}/$id'),body: data,headers: header);
    if(response.statusCode>=200&&response.statusCode<300){
      return unit;
    }else if(response.statusCode >= 400 && response.statusCode < 500){
      throw InvalidDataExceptionMessage(message:json.decode(response.body)['message']);
    }else{
      throw ServerException();
    }
  }

}