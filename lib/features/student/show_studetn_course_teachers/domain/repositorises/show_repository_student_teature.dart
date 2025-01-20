import 'package:dartz/dartz.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/features/auth/domain/entities/user.dart';
import 'package:edu_sphere/features/student/show_studetn_course_teachers/domain/entities/show_student_teacher.dart';

abstract class ShowRepositoryStudentTeacher{
  Future<Either<Failure,List<User>>> getAllStudentTeacher();
  Future<Either<Failure,ShowStudentTeacher>> showTeacherInformation({required int idTeacher});

}