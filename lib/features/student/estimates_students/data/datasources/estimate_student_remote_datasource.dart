import 'dart:convert';

import 'package:edu_sphere/core/error/exception.dart';
import 'package:edu_sphere/core/networking/api_constants.dart';
import 'package:edu_sphere/features/student/estimates_students/data/model/estimates_student_model.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

abstract class EstimateStudentRemoteDataSource{
  Future<EstimatesStudentModel> showEstimateStudentToCourse({required String token,required int idCourse});
}
class EstimateStudentRemoteDataSourceImpl implements EstimateStudentRemoteDataSource{
  final http.Client client;
  EstimateStudentRemoteDataSourceImpl({required this.client});
  @override
  Future<EstimatesStudentModel> showEstimateStudentToCourse({required String token, required int idCourse}) async{
    final header = {'Authorization': 'Bearer $token'};
    final response = await client.get(Uri.parse('${ApiConstants.apiBaseUrl}${ApiConstants.studentEstimates}/$idCourse'),headers: header);
    if(response.statusCode>=200&&response.statusCode<300){
      final  decodeJson = json.decode(response.body);
      EstimatesStudentModel estimatesStudentModel = EstimatesStudentModel.fromJson(decodeJson);
      Logger().w('estimatesStudentModel----------------------$estimatesStudentModel');
      return estimatesStudentModel;
    }else if(response.statusCode >= 400 && response.statusCode < 500){
      throw InvalidDataExceptionMessage(message:json.decode(response.body)['message']);
    }else{
      throw ServerException();
    }
  }

}