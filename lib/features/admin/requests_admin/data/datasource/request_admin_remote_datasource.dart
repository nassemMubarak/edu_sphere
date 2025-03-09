import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:edu_sphere/core/error/exception.dart';
import 'package:edu_sphere/core/networking/api_constants.dart';
import 'package:edu_sphere/features/admin/requests_admin/data/model/request_model.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

abstract class RequestAdminRemoteDataSource{
  Future<List<RequestModel>> getAllRequestAdmin({required String token});
  Future<Unit> replayRequest({required bool acceptRequest,required String token,required int idRequest});
}
class RequestAdminRemoteDataSourceImpl implements RequestAdminRemoteDataSource{
  final http.Client client;
  RequestAdminRemoteDataSourceImpl({required this.client});
  @override
  Future<List<RequestModel>> getAllRequestAdmin({required String token})async {
    final header = {'Authorization': 'Bearer $token'};
    final response = await client.get(Uri.parse('${ApiConstants.apiBaseUrl}${ApiConstants.adminCampsRequests}'),headers: header);
    if(response.statusCode>=200&&response.statusCode<300){
      final List<dynamic> decodeJson = json.decode(response.body);
      Logger().w('response.body----------------------${response.body}');
      List<RequestModel> requestModel = decodeJson.map((course)=>RequestModel.fromJson(course)).toList();
      Logger().w('requestModel----------------------$requestModel');
      return requestModel;
    }else if(response.statusCode >= 400 && response.statusCode < 500){
      throw InvalidDataExceptionMessage(message:json.decode(response.body)['message']);
    }else{
      throw ServerException();
    }
  }

  @override
  Future<Unit> replayRequest({required bool acceptRequest, required String token,required int idRequest})async {
    final header = {'Authorization': 'Bearer $token'};
    final response = await client.get(Uri.parse('${ApiConstants.apiBaseUrl}${ApiConstants.adminCampsRequestsReply}$idRequest/$acceptRequest'),headers: header);
    if(response.statusCode>=200&&response.statusCode<300){
      Logger().w('response.body----------------------${response.body}');
      return unit;
    }else if(response.statusCode >= 400 && response.statusCode < 500){
      throw InvalidDataExceptionMessage(message:json.decode(response.body)['message']);
    }else{
      throw ServerException();
    }
  }

}