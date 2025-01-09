import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:edu_sphere/core/error/exception.dart';
import 'package:edu_sphere/core/networking/api_constants.dart';
import 'package:edu_sphere/features/teacher/quiz/data/models/document_question_model.dart';
import 'package:edu_sphere/features/teacher/quiz/data/models/estimate_quiz_models.dart';
import 'package:edu_sphere/features/teacher/quiz/data/models/review_quiz_model.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../models/question_model.dart';
import '../models/quiz_model.dart';

abstract class QuizRemoteDataSource{
  /// quiz
  Future<List<QuizModel>> getAllQuiz({required int idCourse,required String token});
  Future<QuizModel> addQuiz({required String token,required Map data,required int idCourse});
  Future<Unit> updateQuiz({required int idQuiz, required int idCourse, required Map data,required String token});
  Future<Unit> deleteQuiz({required int idQuiz, required int idCourse,required String token});
  /// quiz question
  Future<List<QuestionModel>> getAllQuestion({required int idCourse,required int idQuiz,required String token});
  Future<QuestionModel> addQuestion({required String token,File? image,required int idQuiz,required Map data,required int idCourse});
  Future<Unit> updateQuestion({File? image,required int idQuestion,required int idQuiz, required int idCourse, required Map data,required String token});
  Future<Unit> deleteQuestion({required int idQuestion,required int idQuiz, required int idCourse,required String token});
  /// Estimate Quiz
  Future<List<EstimateQuizModels>> getAllEstimateQuiz({required int idQuiz,required int idCourse,required String token});
  Future<Unit> updateEstimateQuiz({required int idQuiz,required int grade,required int idCourse,required String token,required int idEstimate});
  Future<ReviewQuizModel> showEstimateQuiz({required int idQuiz, required int idCourse, required int idEstimate,required String token});

}
class QuizRemoteDataSourceImpl implements QuizRemoteDataSource{
  final http.Client client;
  QuizRemoteDataSourceImpl({required this.client});
  /// quiz
  /// get all quiz
  @override
  Future<List<QuizModel>> getAllQuiz({required int idCourse, required String token}) async{
    final header = {'Authorization': 'Bearer $token'};
    final response = await client.get(Uri.parse('${ApiConstants.apiBaseUrl}${ApiConstants.teacherCourses}/$idCourse/${ApiConstants.quiz}'),headers: header);
    Logger().w('$token---------${response.statusCode}----///////-------------->${ApiConstants.apiBaseUrl}${ApiConstants.teacherCourses}/$idCourse/${ApiConstants.quiz}');
    if(response.statusCode>=200&&response.statusCode<300){
      final List<dynamic> decodeJson = json.decode(response.body);
      List<QuizModel> listQuiz = decodeJson.map((course)=>QuizModel.fromJson(course)).toList();
      Logger().w('list quiz----------------------$listQuiz');
      return listQuiz;
    }else if(response.statusCode >= 400 && response.statusCode < 500){
      throw InvalidDataException();
    }else{
      throw ServerException();
    }
  }
  /// add quiz
  @override
  Future<QuizModel> addQuiz({required String token, required Map data, required int idCourse}) async{
    final header = {'Authorization': 'Bearer $token'};
    Logger().e('----------------------->$data');
    final response = await client.post(Uri.parse('${ApiConstants.apiBaseUrl}${ApiConstants.teacherCourses}/$idCourse/${ApiConstants.quiz}'),body: data,headers: header);
    Logger().e(response.body);
    if(response.statusCode>=200&&response.statusCode<300){
      var decodeJson = json.decode(response.body);
      QuizModel quizModel = QuizModel.fromJson(decodeJson);
      Logger().w('quiz----------------------$quizModel');
      return quizModel;
    }else if(response.statusCode >= 400 && response.statusCode < 500){
      throw InvalidDataException();
    }else{
      throw ServerException();
    }
  }
  /// delete quiz
  @override
  Future<Unit> deleteQuiz({required int idQuiz, required int idCourse, required String token}) async{
    final header = {'Authorization': 'Bearer $token'};
    final response = await client.delete(Uri.parse('${ApiConstants.apiBaseUrl}${ApiConstants.teacherCourses}/$idCourse/${ApiConstants.quiz}/$idQuiz'),headers: header);
    if(response.statusCode>=200&&response.statusCode<300){
      return unit;
    }else if(response.statusCode >= 400 && response.statusCode < 500){
      throw InvalidDataException();
    }else{
      throw ServerException();
    }
  }
  /// update quiz
  @override
  Future<Unit> updateQuiz({required int idQuiz, required int idCourse, required Map data, required String token}) async{
    final header = {'Authorization': 'Bearer $token'};
    final response = await client.put(Uri.parse('${ApiConstants.apiBaseUrl}${ApiConstants.teacherCourses}/$idCourse/${ApiConstants.quiz}/$idQuiz'),body: data,headers: header);
    if(response.statusCode>=200&&response.statusCode<300){
      return unit;
    }else if(response.statusCode >= 400 && response.statusCode < 500){
      throw InvalidDataException();
    }else{
      throw ServerException();
    }
  }
  /// get all question quiz
  @override
  Future<List<QuestionModel>> getAllQuestion({required int idCourse,required int idQuiz, required String token}) async{
    final header = {'Authorization': 'Bearer $token'};
    final response = await client.get(Uri.parse('${ApiConstants.apiBaseUrl}${ApiConstants.teacherCourses}/$idCourse/${ApiConstants.quiz}/$idQuiz/${ApiConstants.question}'),headers: header);
    Logger().w('$token---------${response.statusCode}----///////-------------->${ApiConstants.apiBaseUrl}${ApiConstants.teacherCourses}/$idCourse/${ApiConstants.quiz}/$idQuiz/${ApiConstants.question}');
    if(response.statusCode>=200&&response.statusCode<300){
      final List<dynamic> decodeJson = json.decode(response.body);
      List<QuestionModel> listQuestion = decodeJson.map((course)=>QuestionModel.fromJson(course)).toList();
      Logger().w('listQuestion----------------------$listQuestion');
      return listQuestion;
    }else if(response.statusCode >= 400 && response.statusCode < 500){
      throw InvalidDataException();
    }else{
      throw ServerException();
    }
  }
  /// add question quiz
  @override
  Future<QuestionModel> addQuestion({required String token,File? image,required int idQuiz, required Map data, required int idCourse}) async{
    final header = {'Authorization': 'Bearer $token',
    };
    String url = '${ApiConstants.apiBaseUrl}${ApiConstants.teacherCourses}/$idCourse/${ApiConstants.quiz}/$idQuiz/${ApiConstants.question}';
    final request = http.MultipartRequest('POST', Uri.parse(url));
    Logger().d('add question url ---> $url');
    request.headers.addAll(header);
    // Add image file if provided
    if (image != null) {
      final file = await http.MultipartFile.fromPath(
        'files[]', // Key for the image file in the API
        image.path,
      );
      Logger().f('File -> $file');
      request.files.add(file);
    }
    Logger().e(data['options']);
    // Add form fields
    request.fields['title'] = data['title']; // Key for title
    request.fields['type'] = data['type']; // Key for type
    request.fields['options'] = jsonEncode(data['options']); // Key for options
    request.fields['correct_answer'] = data['correct_answer']; // Key for correct answer
    request.fields['mark'] = data['mark']; // Key for mark
    // Send the request
    final response = await request.send();
    QuestionModel questionModel;
    if(response.statusCode>=200&&response.statusCode<300){
      // Parse response
      final responseBody = await response.stream.bytesToString(); // Read the response body
      final decodeJson = json.decode(responseBody);
      Logger().w('decodeJson----------------------$decodeJson');
     if(image!=null){
       final List<String> options = List<String>.from(json.decode(decodeJson['question']['options']));
        questionModel = QuestionModel(
         id: decodeJson['question']['id'],
         quizId: decodeJson['question']['quiz_id'],
         title: decodeJson['question']['title'],
         type: decodeJson['question']['type'],
         options: options,  // Use the parsed list
         correctAnswer: decodeJson['question']['correct_answer'],
         mark: int.parse(decodeJson['question']['mark'].toString()),  // Ensure the mark is an integer
         createdAt: DateTime.parse(decodeJson['question']['created_at']),
         updatedAt: DateTime.parse(decodeJson['question']['updated_at']),
         documents: decodeJson['documents'] != null
             ? (decodeJson['documents'] as List)
             .map((docJson) => DocumentQuestionModel.fromJson(docJson))
             .toList()
             : null,
       );
     }else{

       questionModel = QuestionModel.fromJson(decodeJson);
     }
      return questionModel;
    }else if(response.statusCode >= 400 && response.statusCode < 500){
      throw InvalidDataException();
    }else{
      throw ServerException();
    }
  }
  /// delete question quiz
  @override
  Future<Unit> deleteQuestion({required int idQuestion,required int idQuiz, required int idCourse, required String token})async {
    final header = {'Authorization': 'Bearer $token'};
    String url = '${ApiConstants.apiBaseUrl}${ApiConstants.teacherCourses}/$idCourse/${ApiConstants.quiz}/$idQuiz/${ApiConstants.question}/$idQuestion';

    final response = await client.delete(Uri.parse(url),headers: header);
    if(response.statusCode>=200&&response.statusCode<300){
      return unit;
    }else if(response.statusCode >= 400 && response.statusCode < 500){
      throw InvalidDataException();
    }else{
      throw ServerException();
    }
  }


  @override
  Future<Unit> updateQuestion({File? image,required int idQuestion,required int idQuiz, required int idCourse, required Map data, required String token}) async{
    final header = {'Authorization': 'Bearer $token',
    };
    String url = '${ApiConstants.apiBaseUrl}${ApiConstants.teacherCourses}/$idCourse/${ApiConstants.quiz}/$idQuiz/${ApiConstants.question}/$idQuestion';
    final response = await client.put(Uri.parse(url),body: data,headers: header);
    // final request = http.MultipartRequest('PUT', Uri.parse(url));
    // Logger().d('add question url ---> $url');
    // request.headers.addAll(header);
    // // Add image file if provided
    // if (image != null) {
    //   final file = await http.MultipartFile.fromPath(
    //     'files[]', // Key for the image file in the API
    //     image.path,
    //   );
    //   Logger().f('File -> $file');
    //   request.files.add(file);
    // }
    // Logger().e(data['options']);
    // // Add form fields
    // request.fields['title'] = data['title']; // Key for title
    // request.fields['type'] = data['type']; // Key for type
    // request.fields['options'] = jsonEncode(data['options']); // Key for options
    // request.fields['correct_answer'] = data['correct_answer']; // Key for correct answer
    // request.fields['mark'] = data['mark']; // Key for mark
    // Send the request
    // final response = await request.send();
    if(response.statusCode>=200&&response.statusCode<300){
      return unit;
    }else if(response.statusCode >= 400 && response.statusCode < 500){
      throw InvalidDataException();
    }else{
      throw ServerException();
    }
  }

  @override
  Future<List<EstimateQuizModels>> getAllEstimateQuiz({required int idQuiz, required int idCourse, required String token}) async{
    final header = {'Authorization': 'Bearer $token'};
    final response = await client.get(Uri.parse('${ApiConstants.apiBaseUrl}${ApiConstants.teacherCourses}/$idCourse/${ApiConstants.quiz}/$idQuiz/${ApiConstants.quizAttempt}'),headers: header);
    Logger().w('$token---------${response.statusCode}----///////-------------->${ApiConstants.apiBaseUrl}${ApiConstants.teacherCourses}/$idCourse/${ApiConstants.quiz}/$idQuiz/${ApiConstants.quizAttempt}');
    if(response.statusCode>=200&&response.statusCode<300){
      final List<dynamic> decodeJson = json.decode(response.body);
      List<EstimateQuizModels> estimateQuizModels = decodeJson.map((course)=>EstimateQuizModels.fromJson(course)).toList();
      Logger().w('EstimateQuizModels----------------------$estimateQuizModels');
      return estimateQuizModels;
    }else if(response.statusCode >= 400 && response.statusCode < 500){
      throw InvalidDataException();
    }else{
      throw ServerException();
    }
  }

  @override
  Future<Unit> updateEstimateQuiz({required int idQuiz, required int grade, required int idCourse, required String token,required int idEstimate})async {
    final header = {'Authorization': 'Bearer $token',
    };
    String url = '${ApiConstants.apiBaseUrl}${ApiConstants.teacherCourses}/$idCourse/${ApiConstants.quiz}/$idQuiz/${ApiConstants.quizAttempt}/$idEstimate';
    final response = await client.put(Uri.parse(url),body: {'grade':'$grade'},headers: header);
    if(response.statusCode>=200&&response.statusCode<300){
      return unit;
    }else if(response.statusCode >= 400 && response.statusCode < 500){
      throw InvalidDataException();
    }else{
      throw ServerException();
    }
  }

  @override
  Future<ReviewQuizModel> showEstimateQuiz({required int idQuiz, required int idCourse, required int idEstimate, required String token}) async{
    final header = {'Authorization': 'Bearer $token',
    };
    String url = '${ApiConstants.apiBaseUrl}${ApiConstants.teacherCourses}/$idCourse/${ApiConstants.quiz}/$idQuiz/${ApiConstants.quizAttempt}/$idEstimate';
    final response = await client.get(Uri.parse(url),headers: header);
    if(response.statusCode>=200&&response.statusCode<300){
      var decodeJson = json.decode(response.body);
      ReviewQuizModel reviewQuizModel = ReviewQuizModel.fromJson(decodeJson);
      Logger().w('reviewQuizModel----------------------$reviewQuizModel');
      return reviewQuizModel;
    }else if(response.statusCode >= 400 && response.statusCode < 500){
      throw InvalidDataException();
    }else{
      throw ServerException();
    }
  }

}