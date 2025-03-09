import 'package:dartz/dartz.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/features/admin/student_main/data/model/student_information_model.dart';
import 'package:edu_sphere/features/admin/teacher_admin/domain/entities/show_teacher_courses.dart';
import 'package:edu_sphere/features/admin/teacher_admin/domain/entities/teacher_informstion.dart';
import 'package:edu_sphere/features/auth/domain/entities/user.dart';

abstract class StudentAdminRepository{
  Future<Either<Failure,StudentInformationModel>> getInformationStudent({required int idStudent});

}