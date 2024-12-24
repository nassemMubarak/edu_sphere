import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:edu_sphere/core/error/exception.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/core/helpers/constants.dart';
import 'package:edu_sphere/core/helpers/shared_pref_helper.dart';
import 'package:edu_sphere/core/networking/api_constants.dart';
import 'package:edu_sphere/features/teacher/course_main/data/models/advertisement_model.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;
abstract class CourseMainRemoteDataSource {
  Future<List<AdvertisementModel>> getAllAdvertisement({required int idCourse,required String token});
  Future<Unit> deleteAdvertisement({required int idAdvertisement, required int idCourse,required String token});
  Future<AdvertisementModel> addAdvertisement({required String token,required Map data,required int idCourse});
  Future<AdvertisementModel> updateAdvertisement({required int idAdvertisement, required int idCourse, required Map data,required String token});


}
class CourseMainRemoteDataSourceImpl implements CourseMainRemoteDataSource{
  final http.Client client;
  CourseMainRemoteDataSourceImpl({required this.client});
  @override
  Future<List<AdvertisementModel>> getAllAdvertisement({required int idCourse, required String token}) async{
    final header = {'Authorization': 'Bearer $token'};
    final response = await client.get(Uri.parse('${ApiConstants.apiBaseUrl}${ApiConstants.teacherCourses}/$idCourse/${ApiConstants.advertisements}'),headers: header);
      Logger().w('$token---------${response.statusCode}----///////-------------->${ApiConstants.apiBaseUrl}${ApiConstants.teacherCourses}/$idCourse/${ApiConstants.advertisements}');
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
  Future<AdvertisementModel> addAdvertisement({required String token, required Map data, required int idCourse}) async{
    final header = {'Authorization': 'Bearer $token'};
    final response = await client.post(Uri.parse('${ApiConstants.apiBaseUrl}${ApiConstants.teacherCourses}/$idCourse/${ApiConstants.advertisements}'),body: data,headers: header);
    if(response.statusCode>=200&&response.statusCode<300){
      var decodeJson = json.decode(response.body);
      AdvertisementModel advertisementModel = AdvertisementModel.fromJson(decodeJson);
      Logger().w('advertisementModel----------------------$advertisementModel');
      return advertisementModel;
    }else if(response.statusCode >= 400 && response.statusCode < 500){
      throw InvalidDataException();
    }else{
      throw ServerException();
    }
  }


  @override
  Future<AdvertisementModel> updateAdvertisement({required int idAdvertisement, required int idCourse, required Map data, required String token}) async{
    final header = {'Authorization': 'Bearer $token'};
    final response = await client.put(Uri.parse('${ApiConstants.apiBaseUrl}${ApiConstants.teacherCourses}/$idCourse/${ApiConstants.advertisements}/$idAdvertisement'),body: data,headers: header);
    if(response.statusCode>=200&&response.statusCode<300){
      var decodeJson = json.decode(response.body);
      AdvertisementModel advertisementModel = AdvertisementModel.fromJson(decodeJson);
      Logger().w('advertisementModel----------------------$advertisementModel');
      return advertisementModel;
    }else if(response.statusCode >= 400 && response.statusCode < 500){
      throw InvalidDataException();
    }else{
      throw ServerException();
    }
  }

  @override
  Future<Unit> deleteAdvertisement({required int idAdvertisement, required int idCourse, required String token}) async{
    final header = {'Authorization': 'Bearer $token'};
    final response = await client.delete(Uri.parse('${ApiConstants.apiBaseUrl}${ApiConstants.teacherCourses}/$idCourse/${ApiConstants.advertisements}/$idAdvertisement'),headers: header);
    if(response.statusCode>=200&&response.statusCode<300){
      return unit;
    }else if(response.statusCode >= 400 && response.statusCode < 500){
      throw InvalidDataException();
    }else{
      throw ServerException();
    }
  }
}