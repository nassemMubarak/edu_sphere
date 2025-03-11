import 'package:dartz/dartz.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/features/auth/domain/entities/admin.dart';
import 'package:edu_sphere/features/auth/domain/entities/camp.dart';
import 'package:edu_sphere/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure,User>> loginUser({required Map authData});
  Future<Either<Failure,Admin>> loginAdmin({required Map authData});
  Future<Either<Failure,Admin>> registerAdmin({required Map authData});
  Future<Either<Failure,User>> registerUser({required Map authData});
  Future<Either<Failure,Camp>> showCamp();
  Future<Either<Failure,List<Camp>>> getAllCamp();
  Future<Either<Failure,User>> getCurrentUser();
  Future<Either<Failure,Unit>> sendCodeToForgetPassword({required String email});
  Future<Either<Failure,Unit>> codeCheckForgetPassword({required String code});
  Future<Either<Failure,Unit>> updatePassword({required String password});
  Future<Either<Failure,Unit>> logout();
}