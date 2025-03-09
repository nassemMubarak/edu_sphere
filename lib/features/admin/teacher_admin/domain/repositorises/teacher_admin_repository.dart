import 'package:dartz/dartz.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/features/admin/teacher_admin/domain/entities/show_teacher_courses.dart';
import 'package:edu_sphere/features/admin/teacher_admin/domain/entities/teacher_informstion.dart';
import 'package:edu_sphere/features/auth/domain/entities/user.dart';

abstract class TeacherAdminRepository{
  Future<Either<Failure,TeacherInformation>> getInformationTeacher({required int idTeacher});
  Future<Either<Failure,ShowCourseTeacher>> showCourseTeacherAdmin({required int idCourse});

}