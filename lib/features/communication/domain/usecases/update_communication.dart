import 'package:dartz/dartz.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/features/communication/domain/entities/communication.dart';
import 'package:edu_sphere/features/communication/domain/repositorises/communication_repository.dart';

class UpdateCommunicationUseCase{
  final CommunicationRepository repository;
  UpdateCommunicationUseCase({required this.repository});
  Future<Either<Failure,Unit>> call({required Map data,required int id}) async{
    return await repository.updateCommunication(data: data,id:id);

  }
}