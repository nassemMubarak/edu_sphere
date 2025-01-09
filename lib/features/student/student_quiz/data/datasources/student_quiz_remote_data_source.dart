import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:edu_sphere/core/error/exception.dart';
import 'package:edu_sphere/core/networking/api_constants.dart';
import 'package:edu_sphere/features/student/student_quiz/data/model/question_student_quiz_model.dart';
import 'package:edu_sphere/features/teacher/quiz/data/models/quiz_model.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

abstract class StudentQuizRemoteDataSource{
  Future<List<QuizModel>> getAllStudentQuiz({required int idCourse,required String token});
  Future<List<QuestionStudentQuizModel>> getAttemptStudentQuiz({required int idQuiz, required int idCourse,required String token});
  Future<Unit> submitAnswerQuiz({required int idQuiz, required int idCourse,required String token,required Map data});
}
class StudentQuizRemoteDataSourceImpl implements StudentQuizRemoteDataSource{
  final http.Client client;
  StudentQuizRemoteDataSourceImpl({required this.client});
  @override
  Future<List<QuizModel>> getAllStudentQuiz({required int idCourse, required String token}) async{
    final header = {'Authorization': 'Bearer $token'};
    final response = await client.get(Uri.parse('${ApiConstants.apiBaseUrl}${ApiConstants.studentCourses}/$idCourse/${ApiConstants.quiz}'),headers: header);
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

  @override
  Future<List<QuestionStudentQuizModel>> getAttemptStudentQuiz({required int idQuiz, required int idCourse, required String token}) async{
    final header = {'Authorization': 'Bearer $token'};
    final response = await client.get(Uri.parse('${ApiConstants.apiBaseUrl}${ApiConstants.studentCourses}/$idCourse/${ApiConstants.quiz}/$idQuiz/attempt'),headers: header);
    if(response.statusCode>=200&&response.statusCode<300){
      final List<dynamic> decodeJson = json.decode(response.body);
      List<QuestionStudentQuizModel> listQuestionStudentQuizModel = decodeJson.map((question)=>QuestionStudentQuizModel.fromJson(question)).toList();
      Logger().w('listQuestionStudentQuizModel----------------------$listQuestionStudentQuizModel');
      return listQuestionStudentQuizModel;
    }else if(response.statusCode >= 400 && response.statusCode < 500){
      throw InvalidDataException();
    }else{
      throw ServerException();
    }
  }

  @override
  Future<Unit> submitAnswerQuiz({required int idQuiz, required int idCourse, required String token,required Map data}) async{
    final header = {'Authorization': 'Bearer $token'};
    final response = await client.post(Uri.parse('${ApiConstants.apiBaseUrl}${ApiConstants.studentCourses}/$idCourse/${ApiConstants.quiz}/$idQuiz/attempt'),body: data,headers: header);
    if(response.statusCode>=200&&response.statusCode<300){
      return unit;
    }else if(response.statusCode >= 400 && response.statusCode < 500){
      throw InvalidDataException();
    }else{
      throw ServerException();
    }
  }

}