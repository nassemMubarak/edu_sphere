import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:edu_sphere/core/error/exception.dart';
import 'package:edu_sphere/core/networking/api_constants.dart';
import 'package:edu_sphere/features/teacher/assessments/data/models/EstimateAssessmentModel.dart';
import 'package:edu_sphere/features/teacher/assessments/data/models/assessment_model.dart';
import 'package:edu_sphere/features/teacher/assessments/data/models/document_assessment_model.dart';
import 'package:edu_sphere/features/teacher/assessments/domain/entities/document_assessment.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
// import 'package:path/path.dart' as path;
// import 'package:path_provider/path_provider.dart';

abstract class AssessmentRemoteDataSource{
  Future<List<AssessmentModel>> getAllAssessment({required int idCourse,required String token});
  Future<AssessmentModel> addAssessment({required String token,required Map data,required int idCourse});
  Future<Unit> updateAssessment({required int idAssessment, required int idCourse, required Map data,required String token});
  Future<Unit> deleteAssessment({required int idAssessment, required int idCourse,required String token});
  Future<List<DocumentAssessment>> addDocumentToAssessment({required int idCourse, required int idAssessment, required List<File> files,required String token});
  Future<Unit> deleteDocumentToAssessment({required int idCourse, required int idAssessment, required int idDocument,required String token});
  Future<Unit> downloadDocumentToAssessment({required int idCourse, required int idAssessment, required int idDocument,required String token});
  Future<List<EstimateAssessmentModel>> getAllEstimateAssessment({required int idCourse, required int idAssessment,required String token});
  Future<Unit> addEstimateAssessment({required int mark,required int idCourse, required int idAssessment, required int idStudent,required String token});

}
class AssessmentRemoteDataSourceImpl implements AssessmentRemoteDataSource{
    final http.Client client;
    AssessmentRemoteDataSourceImpl({required this.client});
    ///get all assessment
  @override
  Future<List<AssessmentModel>> getAllAssessment({required int idCourse, required String token}) async{
    final header = {'Authorization': 'Bearer $token'};
    final response = await client.get(Uri.parse('${ApiConstants.apiBaseUrl}${ApiConstants.teacherCourses}/$idCourse/${ApiConstants.assignments}'),headers: header);
    Logger().w('$token---------${response.statusCode}----///////-------------->${ApiConstants.apiBaseUrl}${ApiConstants.teacherCourses}/$idCourse/${ApiConstants.assignments}');
    if(response.statusCode>=200&&response.statusCode<300){
      final List<dynamic> decodeJson = json.decode(response.body);
      List<AssessmentModel> listAssessment = decodeJson.map((assessment)=>AssessmentModel.fromJson(assessment)).toList();
      Logger().w('list  Assessment----------------------$listAssessment');
      return listAssessment;
    }else if(response.statusCode >= 400 && response.statusCode < 500){
      throw InvalidDataException();
    }else{
      throw ServerException();
    }
  }
  //// add assessment
  @override
  Future<AssessmentModel> addAssessment({required String token, required Map data, required int idCourse}) async{
    final header = {'Authorization': 'Bearer $token'};
    Logger().e('----------------------->$data');

    final response = await client.post(Uri.parse('${ApiConstants.apiBaseUrl}${ApiConstants.teacherCourses}/$idCourse/${ApiConstants.assignments}'),body: data,headers: header);
    Logger().e(response.body);
    if(response.statusCode>=200&&response.statusCode<300){
      var decodeJson = json.decode(response.body);
      AssessmentModel assessmentModel = AssessmentModel.fromJson(decodeJson);
      Logger().w('assessmentModel----------------------$assessmentModel');
      return assessmentModel;
    }else if(response.statusCode >= 400 && response.statusCode < 500){
      throw InvalidDataException();
    }else{
      throw ServerException();
    }
  }
  /// delete assessment
  @override
  Future<Unit> deleteAssessment({required int idAssessment, required int idCourse, required String token}) async{
    final header = {'Authorization': 'Bearer $token'};
    final response = await client.delete(Uri.parse('${ApiConstants.apiBaseUrl}${ApiConstants.teacherCourses}/$idCourse/${ApiConstants.assignments}/$idAssessment'),headers: header);
    if(response.statusCode>=200&&response.statusCode<300){
      return unit;
    }else if(response.statusCode >= 400 && response.statusCode < 500){
      throw InvalidDataException();
    }else{
      throw ServerException();
    }
  }



  @override
  Future<Unit> updateAssessment({required int idAssessment, required int idCourse, required Map data, required String token}) async{
    final header = {'Authorization': 'Bearer $token','Content-Type':'application/json'};
    Logger().e('${ApiConstants.apiBaseUrl}${ApiConstants.teacherCourses}/$idCourse/${ApiConstants.assignments}/$idAssessment');
    final response = await client.put(Uri.parse('${ApiConstants.apiBaseUrl}${ApiConstants.teacherCourses}/$idCourse/${ApiConstants.assignments}/$idAssessment'),body: json.encode(data),headers: header);
    Logger().e('json.encode(data)--------?${json.encode(data)}');
    Logger().e('response--------?${response.statusCode}');
    if(response.statusCode>=200&&response.statusCode<300){
      return unit;
    }else if(response.statusCode >= 400 && response.statusCode < 500){
      throw InvalidDataException();
    }else{
      throw ServerException();
    }
  }

  @override
  Future<List<DocumentAssessment>> addDocumentToAssessment({required int idCourse, required int idAssessment, required List<File> files, required String token}) async{
    final header = {'Authorization': 'Bearer $token',
    };
    String url = '${ApiConstants.apiBaseUrl}${ApiConstants.teacherCourses}/$idCourse/${ApiConstants.assignments}/$idAssessment/${ApiConstants.documents}';
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

      if (response.statusCode>=200&&response.statusCode<300) {
        final responseBody = await response.stream.bytesToString();
        Logger().d('Response: $responseBody');

        final List<dynamic> responseJson = jsonDecode(responseBody);

        // Convert response JSON to a list of DocumentAssessment objects
        return responseJson.map((json) => DocumentAssessmentModel.fromJson(json)).toList();
      } else if(response.statusCode >= 400 && response.statusCode < 500){
        throw InvalidDataException();
      }else{
        throw ServerException();
      }
  }

  @override
  Future<Unit> deleteDocumentToAssessment({required int idCourse, required int idAssessment, required int idDocument, required String token})async {
    final header = {'Authorization': 'Bearer $token'};
    final response = await client.delete(Uri.parse('${ApiConstants.apiBaseUrl}${ApiConstants.teacherCourses}/$idCourse/${ApiConstants.assignments}/$idAssessment/${ApiConstants.documents}/$idDocument'),headers: header);
    if(response.statusCode>=200&&response.statusCode<300){
      return unit;
    }else if(response.statusCode >= 400 && response.statusCode < 500){
      throw InvalidDataException();
    }else{
      throw ServerException();
    }
  }

    @override
    Future<Unit> downloadDocumentToAssessment({
      required int idCourse,
      required int idAssessment,
      required int idDocument,
      required String token,
    }) async {
      final header = {'Authorization': 'Bearer $token'};

      // Construct the URL
      final url =
          '${ApiConstants.apiBaseUrl}${ApiConstants.teacherCourses}/$idCourse/${ApiConstants.assignments}/$idAssessment/${ApiConstants.documents}/$idDocument';

      final response = await client.get(Uri.parse(url), headers: header);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        // final directory = await getApplicationDocumentsDirectory();
        //
        // // Extract the filename from the URL
        // final fileName = 'document_$idDocument.pdf'; // Use a cleaner, descriptive name
        //
        // // Create the file path
        // final filePath = path.join(directory.path, fileName);
        //
        // // Write the file to disk
        // final file = File(filePath);
        // await file.writeAsBytes(response.bodyBytes);

        return unit; // Assuming this is from the dartz package
      } else if (response.statusCode >= 400 && response.statusCode < 500) {
        throw InvalidDataException();
      } else {
        throw ServerException();
      }
    }

  @override
  Future<List<EstimateAssessmentModel>> getAllEstimateAssessment({required int idCourse, required int idAssessment, required String token})async {
    final header = {'Authorization': 'Bearer $token'};
    final response = await client.get(Uri.parse('${ApiConstants.apiBaseUrl}${ApiConstants.teacherCourses}/$idCourse/${ApiConstants.assignments}/$idAssessment/submits'),headers: header);
    Logger().w('${ApiConstants.apiBaseUrl}${ApiConstants.teacherCourses}/$idCourse/${ApiConstants.assignments}/$idAssessment/submits');
    if(response.statusCode>=200&&response.statusCode<300){
      Logger().w('list  Estimate----------------------${json.decode(response.body)}');
      final List<dynamic> decodeJson = json.decode(response.body);
      List<EstimateAssessmentModel> listEstimate = decodeJson.map((assessment)=>EstimateAssessmentModel.fromJson(assessment)).toList();
      return listEstimate;
    }else if(response.statusCode >= 400 && response.statusCode < 500){
      throw InvalidDataException();
    }else{
      throw ServerException();
    }
  }

  @override
  Future<Unit> addEstimateAssessment({required int idCourse, required int idAssessment, required int idStudent,required String token,required int mark}) async{
    final header = {'Authorization': 'Bearer $token','Content-Type':'application/json'};
    Logger().e('----------------------->$mark');
  final data = {
    'mark':mark
  };
    final response = await client.post(Uri.parse('${ApiConstants.apiBaseUrl}${ApiConstants.teacherCourses}/$idCourse/${ApiConstants.assignments}/$idAssessment/submits/students/$idStudent'),body: json.encode(data),headers: header);
    Logger().e('--------------------------${response.body}');
    if(response.statusCode>=200&&response.statusCode<300){
      return unit;
    }else if(response.statusCode >= 400 && response.statusCode < 500){
      throw InvalidDataException();
    }else{
      throw ServerException();
    }
  }

}