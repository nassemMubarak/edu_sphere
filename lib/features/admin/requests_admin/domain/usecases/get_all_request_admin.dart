import 'package:dartz/dartz.dart';
import 'package:edu_sphere/features/admin/requests_admin/domain/repositorises/request_admin_repository.dart';

import '../../../../../core/error/failure.dart';
import '../../data/model/request_model.dart';

class GetAllRequestAdminUseCase{
  final RequestAdminRepository repository;
  GetAllRequestAdminUseCase({required this.repository});
  Future<Either<Failure,List<RequestModel>>> call()async{
    return await repository.getAllRequestAdmin();
  }
}