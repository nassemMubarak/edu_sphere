import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:edu_sphere/features/teacher/teacher_main/data/models/course_model.dart';
import 'package:logger/logger.dart';

import '../../../../../core/error/exception.dart';
import '../../../../../core/helpers/constants.dart';
import '../../../../../core/helpers/shared_pref_helper.dart';

abstract class StudentMainLocalDataSource {
  Future<List<CourseModel>> getLocalStudentCourses();
  Future<Unit> saveStudentCourses({required List<CourseModel> listCourses});
}
class StudentMainLocalDataSourceImpl implements StudentMainLocalDataSource {
  @override
  Future<List<CourseModel>> getLocalStudentCourses() async{
    try {
      // Ensure you await the result from SharedPrefHelper.getStringList
      List<String>? jsonString = await SharedPrefHelper.getStringList(SharedPrefKeys.cachedCourses);
      Logger().d('Retrieved Courses: $jsonString');
      if (jsonString != null && jsonString.isNotEmpty) {
        // Decode JSON into a list of CourseModel objects
        return _decodeCourses(jsonString);
      } else {
        throw EmptyCacheException();
      }
    } catch (e) {
      Logger().e('Error retrieving courses: $e');
      throw EmptyCacheException();
    }
  }

  @override
  Future<Unit> saveStudentCourses({required List<CourseModel> listCourses}) async{
    try {
      // Encode the list of CourseModel objects to JSON
      List<String> courseJson = _encodeCourses(listCourses);
      Logger().t('Courses to save: $courseJson');

      // Save the JSON list to SharedPreferences
      await SharedPrefHelper.setStringList(SharedPrefKeys.cachedCourses, courseJson);
      return unit;
    } catch (e) {
      Logger().e('Error saving courses: $e');
    }
    return unit;
  }
// Helper method to encode courses to JSON
  List<String> _encodeCourses(List<CourseModel> listCourses) {
    return listCourses.map((course) => json.encode(course.toJson())).toList();
  }

  // Helper method to decode JSON to CourseModel objects
  List<CourseModel> _decodeCourses(List<String> jsonString) {
    return jsonString
        .map((courseJson) => CourseModel.fromJson(json.decode(courseJson)))
        .toList();
  }
}
