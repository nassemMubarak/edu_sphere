import 'package:dartz/dartz.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/features/communication/domain/entities/communication.dart';
import 'package:edu_sphere/features/communication/domain/repositorises/communication_repository.dart';

class GetAllCommunicationUseCase{
  final CommunicationRepository repository;
  GetAllCommunicationUseCase({required this.repository});
  Future<Either<Failure,List<Communication>>> call() async{
    return await repository.getAllCommunication();

  }
}