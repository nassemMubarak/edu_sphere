
import 'package:dartz/dartz.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/features/auth/domain/entities/user.dart';
import 'package:edu_sphere/features/auth/domain/repositorises/repository.dart';


class LoginUserUseCase{
  final AuthRepository repository;

  LoginUserUseCase({required this.repository});

  Future<Either<Failure,User>> call({required Map authData})async{
    return await repository.loginUser(authData: authData);
  }
}