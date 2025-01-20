import 'package:dartz/dartz.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/features/communication/domain/entities/communication.dart';
import 'package:edu_sphere/features/communication/domain/repositorises/communication_repository.dart';

class AddCommunicationUseCase{
  final CommunicationRepository repository;
  AddCommunicationUseCase({required this.repository});
  Future<Either<Failure,Communication>> call({required Map data}) async{
    return await repository.addCommunication(data: data);

  }
}