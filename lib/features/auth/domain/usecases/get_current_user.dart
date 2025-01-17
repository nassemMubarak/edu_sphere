
import 'package:dartz/dartz.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/features/auth/domain/repositorises/repository.dart';

import '../entities/user.dart';

class GetCurrentUserUseCase{
  final AuthRepository repository;

  GetCurrentUserUseCase({required this.repository});

  Future<Either<Failure,User>> call()async{
    return await repository.getCurrentUser();
  }
}