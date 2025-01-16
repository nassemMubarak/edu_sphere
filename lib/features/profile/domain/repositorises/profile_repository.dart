import 'package:dartz/dartz.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/features/auth/domain/entities/user.dart';

abstract class ProfileRepository{
  Future<Either<Failure,User>> getInfoUser();
  Future<Either<Failure,User>> updateUser({required Map data,required String type});
}