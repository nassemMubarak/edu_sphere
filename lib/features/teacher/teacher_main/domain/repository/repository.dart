import 'package:dartz/dartz.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/features/auth/domain/entities/camp.dart';
import 'package:edu_sphere/features/auth/domain/entities/user.dart';
import 'package:edu_sphere/features/teacher/teacher_main/domain/entities/course.dart';

abstract class TeacherMainRepository {
  Future<Either<Failure,List<Course>>> getAllCourses();
  Future<Either<Failure,Course>> addCourse({required Map courseData});
  Future<Either<Failure,Unit>> updateCourse({required Map courseData,required int id});
  Future<Either<Failure,Unit>> deleteCourse({required int id});

}