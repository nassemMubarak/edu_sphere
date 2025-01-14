import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:edu_sphere/core/error/exception.dart';
import 'package:edu_sphere/core/networking/api_constants.dart';
import 'package:edu_sphere/features/student/assessment_student/data/models/document_student_assessment_model.dart';
import 'package:edu_sphere/features/teacher/assessments/data/models/assessment_model.dart';
import 'package:edu_sphere/features/teacher/assessments/data/models/document_assessment_model.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

abstract class StudentAssessmentRemoteDataSource{
  Future<List<AssessmentModel>> getAllStudentAssessment({required int idCourse,required String token});
  Future<AssessmentModel> showStudentAssessment({required int idCourse,required String token,required int idAssessment});
  Future<DocumentStudentAssessmentModel> submitStudentDocumentToAssessment({required int idCourse,required String token,required int idAssessment,required List<File> files});
  Future<DocumentStudentAssessmentModel> getAllSubmitStudentDocumentToAssessment({required int idCourse,required String token,required int idAssessment});
  Future<Unit> deleteSubmitStudentDocumentToAssessment({required int idCourse, required int idAssessment,required String token});

}
class StudentAssessmentRemoteDataSourceImpl implements StudentAssessmentRemoteDataSource{
  final http.Client client;
  StudentAssessmentRemoteDataSourceImpl({required this.client});
  @override
  Future<List<AssessmentModel>> getAllStudentAssessment({required int idCourse, required String token}) async{
    final header = {'Authorization': 'Bearer $token'};
    final response = await client.get(Uri.parse('${ApiConstants.apiBaseUrl}${ApiConstants.studentCourses}/$idCourse/${ApiConstants.assignments}'),headers: header);
    Logger().w('$token---------${response.statusCode}----///////-------------->${ApiConstants.apiBaseUrl}${ApiConstants.studentCourses}/$idCourse/${ApiConstants.assignments}');
    if(response.statusCode>=200&&response.statusCode<300){
      final List<dynamic> decodeJson = json.decode(response.body);
      List<AssessmentModel> listAssessment = decodeJson.map((assessment)=>AssessmentModel.fromJson(assessment)).toList();
      Logger().w('list  Assessment----------------------$listAssessment');
      return listAssessment;
    }else if(response.statusCode >= 400 && response.statusCode < 500){
      throw InvalidDataExceptionMessage(message:json.decode(response.body)['message']);
    }else{
      throw ServerException();
    }

  }
  @override
  Future<Unit> deleteSubmitStudentDocumentToAssessment({required int idCourse, required int idAssessment, required String token}) async{
    final header = {'Authorization': 'Bearer $token'};
    final response = await client.delete(Uri.parse('${ApiConstants.apiBaseUrl}${ApiConstants.studentCourses}/$idCourse/${ApiConstants.assignments}/$idAssessment/submit'),headers: header);
    Logger().w('$token---------${response.statusCode}----///////-------------->${ApiConstants.apiBaseUrl}${ApiConstants.studentCourses}/$idCourse/${ApiConstants.assignments}/$idAssessment/submit');
    if(response.statusCode>=200&&response.statusCode<300){
      return unit;
    }else if(response.statusCode >= 400 && response.statusCode < 500){
      throw InvalidDataExceptionMessage(message:json.decode(response.body)['message']);
    }else{
      throw ServerException();
    }
  }



  @override
  Future<AssessmentModel> showStudentAssessment({required int idCourse, required String token, required int idAssessment})async {
    final header = {'Authorization': 'Bearer $token'};
    final response = await client.get(Uri.parse('${ApiConstants.apiBaseUrl}${ApiConstants.studentCourses}/$idCourse/${ApiConstants.assignments}/$idAssessment'),headers: header);
    Logger().w('$token---------${response.body}----///////-------------->${ApiConstants.apiBaseUrl}${ApiConstants.studentCourses}/$idCourse/${ApiConstants.assignments}/$idAssessment');
    if(response.statusCode>=200&&response.statusCode<300){
      final  decodeJson = json.decode(response.body);
      AssessmentModel assessmentModel = AssessmentModel.fromJson(decodeJson);
      return assessmentModel;
    }else if(response.statusCode >= 400 && response.statusCode < 500){
      throw InvalidDataExceptionMessage(message:json.decode(response.body)['message']);
    }else{
      throw ServerException();
    }
  }

  @override
  Future<DocumentStudentAssessmentModel> submitStudentDocumentToAssessment({required int idCourse, required String token, required int idAssessment, required List<File> files}) async{
    final header = {'Authorization': 'Bearer $token',
    };
    String url = '${ApiConstants.apiBaseUrl}${ApiConstants.studentCourses}/$idCourse/${ApiConstants.assignments}/$idAssessment/submit';
    final request = http.MultipartRequest('POST', Uri.parse(url));
    Logger().d('add document url ---> $url');
    request.headers.addAll(header);
    // Add files to the request
    for (var file in files) {
      final fileName = file.path.split('/').last; // Extract the file name
      request.files.add(
        await http.MultipartFile.fromPath(
          'files[]', // Field name for the API
          file.path,
          filename: fileName,
        ),
      );
    }
    final response = await request.send();
      final responseBody = await response.stream.bytesToString();
     final responseJson = jsonDecode(responseBody);

      Logger().d('response.statusCode--------${response.statusCode}-------${responseJson['message']}-----------------Response: }');
    if (response.statusCode>=200&&response.statusCode<300) {

      Logger().d('Response: $responseBody');
      // Convert response JSON to a list of DocumentAssessment objects
      return DocumentStudentAssessmentModel.fromJson(responseJson);
    }else if(response.statusCode >= 400 && response.statusCode <= 500){
      throw InvalidDataExceptionMessage(message:responseJson['message']);
    }else{
      throw ServerException();
    }
  }

  @override
  Future<DocumentStudentAssessmentModel> getAllSubmitStudentDocumentToAssessment({required int idCourse, required String token, required int idAssessment}) async{
    final header = {'Authorization': 'Bearer $token'};
    final response = await client.get(Uri.parse('${ApiConstants.apiBaseUrl}${ApiConstants.studentCourses}/$idCourse/${ApiConstants.assignments}/$idAssessment/submit'),headers: header);
    Logger().w('$token---------${response.statusCode}----///////-------11111111111111111------->${ApiConstants.apiBaseUrl}${ApiConstants.studentCourses}/$idCourse/${ApiConstants.assignments}/$idAssessment/submit');
    if(response.statusCode>=200&&response.statusCode<300){
      try{
        final  decodeJson = json.decode(response.body);
        Logger().w('listDocumentAssessment----------------------${json.decode(response.body)}');
        DocumentStudentAssessmentModel documentAssessment = DocumentStudentAssessmentModel.fromJson(decodeJson);
        return documentAssessment;
      }catch(e){
        Logger().w('$token---------${response.body}----///////--------111111111111------>${ApiConstants.apiBaseUrl}${ApiConstants.studentCourses}/$idCourse/${ApiConstants.assignments}/submit');
        throw InvalidDataException();
      }
    }else if(response.statusCode >= 400 && response.statusCode < 500){
      throw InvalidDataExceptionMessage(message:json.decode(response.body)['message']);
    }else{
      throw ServerException();
    }
  }

}