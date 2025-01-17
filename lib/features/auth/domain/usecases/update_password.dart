
import 'package:dartz/dartz.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/features/auth/domain/repositorises/repository.dart';

class UpdatePasswordUseCase {
  final AuthRepository repository;

  UpdatePasswordUseCase({required this.repository});

  Future<Either<Failure,Unit>> call({required String password})async{
    return await repository.updatePassword(password: password);
  }
}