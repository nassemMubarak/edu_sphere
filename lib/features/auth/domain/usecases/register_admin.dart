
import 'package:dartz/dartz.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/features/auth/domain/entities/admin.dart';
import 'package:edu_sphere/features/auth/domain/entities/user.dart';
import 'package:edu_sphere/features/auth/domain/repositorises/repository.dart';
class RegisterAdminUseCase{
  final AuthRepository repository;

  RegisterAdminUseCase({required this.repository});

  Future<Either<Failure,Admin>> call({required Map authData})async{
    return await repository.registerAdmin(authData: authData);
  }
}