import 'package:dartz/dartz.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/features/admin/requests_admin/data/model/request_model.dart';

abstract class RequestAdminRepository{
  Future<Either<Failure,List<RequestModel>>> getAllRequestAdmin();
  Future<Either<Failure,Unit>> replayRequest({required bool acceptRequest,required int idRequest});
}