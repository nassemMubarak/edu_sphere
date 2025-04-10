import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:edu_sphere/core/error/exception.dart';
import 'package:edu_sphere/core/networking/api_constants.dart';
import 'package:edu_sphere/features/teacher/assessments/data/models/document_assessment_model.dart';
import 'package:edu_sphere/features/teacher/course_main/data/models/advertisement_model.dart';
import 'package:edu_sphere/features/teacher/course_main/data/models/lecture_model.dart';
import 'package:edu_sphere/features/teacher/course_main/domain/entities/lecture.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;
abstract class CourseMainRemoteDataSource {
  /// Advertisement
  Future<List<AdvertisementModel>> getAllAdvertisement({required int idCourse,required String token});
  Future<Unit> deleteAdvertisement({required int idAdvertisement, required int idCourse,required String token});
  Future<AdvertisementModel> addAdvertisement({required String token,required Map data,required int idCourse});
  Future<Unit> updateAdvertisement({required int idAdvertisement, required int idCourse, required Map data,required String token});
  /// Lecture
  Future<List<Lecture>> getAllLecture({required int idCourse,required String token});
  Future<Unit> deleteLecture({required int idLecture, required int idCourse,required String token});
  Future<Lecture> addLecture({required String token,required Map data,required int idCourse});
  Future<Unit> updateLecture({required int idLecture, required int idCourse, required Map data,required String token});
  /// Document Course
  Future<List<DocumentAssessmentModel>> getAllDocumentToCourse({required String token,required int idCourse});
  Future<List<DocumentAssessmentModel>> addDocumentToCourse({required String token,required int idCourse,required List<File> files});
  Future<Unit> deleteDocumentToCourse({required String token,required int idCourse, required int idDocument});
  Future<Unit> downloadDocumentToCourse({required String token,required int idCourse, required int idDocument});

}
class CourseMainRemoteDataSourceImpl implements CourseMainRemoteDataSource{
  final http.Client client;
  CourseMainRemoteDataSourceImpl({required this.client});
  /// Advertisement
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
  Future<Unit> updateAdvertisement({required int idAdvertisement, required int idCourse, required Map data, required String token}) async{
    final header = {'Authorization': 'Bearer $token'};
    final response = await client.put(Uri.parse('${ApiConstants.apiBaseUrl}${ApiConstants.teacherCourses}/$idCourse/${ApiConstants.advertisements}/$idAdvertisement'),body: data,headers: header);
    if(response.statusCode>=200&&response.statusCode<300){
      return unit;
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
  /// Lecture
  /// get all lecture
  @override
  Future<List<Lecture>> getAllLecture({required int idCourse, required String token}) async{
    final header = {'Authorization': 'Bearer $token'};
    final response = await client.get(Uri.parse('${ApiConstants.apiBaseUrl}${ApiConstants.teacherCourses}/$idCourse/${ApiConstants.lectures}'),headers: header);
    Logger().w('$token---------${response.statusCode}----///////-------------->${ApiConstants.apiBaseUrl}${ApiConstants.teacherCourses}/$idCourse/${ApiConstants.lectures}');
    if(response.statusCode>=200&&response.statusCode<300){
      final List<dynamic> decodeJson = json.decode(response.body);
      List<Lecture> listLecture = decodeJson.map((lecture)=>LectureModel.fromJson(lecture)).toList();
      Logger().w('listAdvertisementModel----------------------$listLecture');
      return listLecture;
    }else if(response.statusCode >= 400 && response.statusCode < 500){
      throw InvalidDataException();
    }else{
      throw ServerException();
    }
  }
  /// add lecture
  @override
  Future<Lecture> addLecture({required String token, required Map data, required int idCourse}) async{
    final header = {'Authorization': 'Bearer $token'};
    final response = await client.post(Uri.parse('${ApiConstants.apiBaseUrl}${ApiConstants.teacherCourses}/$idCourse/${ApiConstants.lectures}'),body: data,headers: header);
    if(response.statusCode>=200&&response.statusCode<300){
      var decodeJson = json.decode(response.body);
      LectureModel lectureModel = LectureModel.fromJson(decodeJson);
      Logger().w('lectureModel----------------------$lectureModel');
      return lectureModel;
    }else if(response.statusCode >= 400 && response.statusCode < 500){
      throw InvalidDataException();
    }else{
      throw ServerException();
    }
  }
  /// delete lecture
  @override
  Future<Unit> deleteLecture({required int idLecture, required int idCourse, required String token}) async{
    final header = {'Authorization': 'Bearer $token'};
    final response = await client.delete(Uri.parse('${ApiConstants.apiBaseUrl}${ApiConstants.teacherCourses}/$idCourse/${ApiConstants.lectures}/$idLecture'),headers: header);
    if(response.statusCode>=200&&response.statusCode<300){
      return unit;
    }else if(response.statusCode >= 400 && response.statusCode < 500){
      throw InvalidDataException();
    }else{
      throw ServerException();
    }
  }
  /// update lecture
  @override
  Future<Unit> updateLecture({required int idLecture, required int idCourse, required Map data, required String token}) async{
    final header = {'Authorization': 'Bearer $token'};
    Logger().e('${ApiConstants.apiBaseUrl}${ApiConstants.teacherCourses}/$idCourse/${ApiConstants.lectures}/$idLecture');
    final response = await client.put(Uri.parse('${ApiConstants.apiBaseUrl}${ApiConstants.teacherCourses}/$idCourse/${ApiConstants.lectures}/$idLecture'),body: data,headers: header);
    if(response.statusCode>=200&&response.statusCode<300){
      return unit;
    }else if(response.statusCode >= 400 && response.statusCode < 500){
      throw InvalidDataException();
    }else{
      throw ServerException();
    }
  }
  @override
  Future<List<DocumentAssessmentModel>> getAllDocumentToCourse({required String token, required int idCourse}) async{
    final header = {'Authorization': 'Bearer $token'};
    final response = await client.get(Uri.parse('${ApiConstants.apiBaseUrl}${ApiConstants.teacherCourses}/$idCourse/${ApiConstants.documents}'),headers: header);
    Logger().w('$token---------${response.statusCode}----///////-------------->${ApiConstants.apiBaseUrl}${ApiConstants.teacherCourses}/$idCourse/${ApiConstants.documents}');
    if(response.statusCode>=200&&response.statusCode<300){
      final List<dynamic> decodeJson = json.decode(response.body);
      List<DocumentAssessmentModel> listDocument = decodeJson.map((document)=>DocumentAssessmentModel.fromJson(document)).toList();
      Logger().w('listDocument----------------------$listDocument');
      return listDocument;
    }else if(response.statusCode >= 400 && response.statusCode < 500){
        throw InvalidDataException();
    }else{
      throw ServerException();
    }
  }
  @override
  Future<List<DocumentAssessmentModel>> addDocumentToCourse({required String token, required int idCourse, required List<File> files}) async{
    final header = {'Authorization': 'Bearer $token',};
    String url = '${ApiConstants.apiBaseUrl}${ApiConstants.teacherCourses}/$idCourse/${ApiConstants.documents}';
    final request = http.MultipartRequest('POST', Uri.parse(url));
    Logger().d('add document to course url ---> $url');
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
  Future<Unit> deleteDocumentToCourse({required String token, required int idCourse, required int idDocument}) async{
    final header = {'Authorization': 'Bearer $token'};
    final response = await client.delete(Uri.parse('${ApiConstants.apiBaseUrl}${ApiConstants.teacherCourses}/$idCourse/${ApiConstants.documents}/$idDocument'),headers: header);
    if(response.statusCode>=200&&response.statusCode<300){
      return unit;
    }else if(response.statusCode >= 400 && response.statusCode < 500){
      throw InvalidDataException();
    }else{
      throw ServerException();
    }
  }

  @override
  Future<Unit> downloadDocumentToCourse({required String token, required int idCourse, required int idDocument})async {
    final header = {'Authorization': 'Bearer $token'};

    // Construct the URL
    final url =
        '${ApiConstants.apiBaseUrl}${ApiConstants.teacherCourses}/$idCourse/${ApiConstants.documents}/$idDocument';

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


}