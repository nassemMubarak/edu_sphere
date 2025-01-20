import 'package:dartz/dartz.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/features/communication/domain/entities/communication.dart';

abstract class CommunicationRepository{

  Future<Either<Failure,List<Communication>>> getAllCommunication();
  Future<Either<Failure,Communication>> addCommunication({required Map data});
  Future<Either<Failure,Unit>> updateCommunication({required Map data,required int id});
}