import 'package:dartz/dartz.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/features/auth/domain/entities/user.dart';

abstract class AdminMainRepository{
  Future<Either<Failure,List<User>>> getAllTeacherInAdmin();
  Future<Either<Failure,List<User>>> getAllStudentInAdmin();

}