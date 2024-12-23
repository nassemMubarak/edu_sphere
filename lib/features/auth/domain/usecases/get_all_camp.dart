
import 'package:dartz/dartz.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/features/auth/domain/entities/camp.dart';
import 'package:edu_sphere/features/auth/domain/repositorises/repository.dart';

class GetAllCampUseCase{
  final AuthRepository repository;

  GetAllCampUseCase({required this.repository});

  Future<Either<Failure,List<Camp>>> call()async{
    return await repository.getAllCamp();
  }
}