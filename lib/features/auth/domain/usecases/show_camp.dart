
import 'package:dartz/dartz.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/features/auth/domain/entities/camp.dart';
import 'package:edu_sphere/features/auth/domain/repositorises/repository.dart';

class ShowCampUseCase{
  final AuthRepository repository;

  ShowCampUseCase({required this.repository});

  Future<Either<Failure,Camp>> call()async{
    return await repository.showCamp();
  }
}