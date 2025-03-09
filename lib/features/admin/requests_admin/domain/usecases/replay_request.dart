import 'package:dartz/dartz.dart';
import 'package:edu_sphere/features/admin/requests_admin/domain/repositorises/request_admin_repository.dart';

import '../../../../../core/error/failure.dart';
import '../../data/model/request_model.dart';

class ReplayRequestUseCase{
  final RequestAdminRepository repository;
  ReplayRequestUseCase({required this.repository});
  Future<Either<Failure,Unit>> call({required bool acceptRequest,required int idRequest})async{
    return await repository.replayRequest(acceptRequest: acceptRequest,idRequest: idRequest);
  }
}