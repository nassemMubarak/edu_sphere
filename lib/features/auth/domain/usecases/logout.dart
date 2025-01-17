import 'package:dartz/dartz.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/features/auth/domain/repositorises/repository.dart';


class LogoutUseCase{
  final AuthRepository repository;

  LogoutUseCase({required this.repository});

  Future<Either<Failure,Unit>> call()async{
    return await repository.logout();
  }
}