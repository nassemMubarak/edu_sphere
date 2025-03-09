import 'package:dartz/dartz.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/features/admin/admin_main/domain/repositorises/admin_main_repository.dart';
import 'package:edu_sphere/features/auth/domain/entities/user.dart';

class GetAllStudentInAdminUseCase{
  final AdminMainRepository repository;
  GetAllStudentInAdminUseCase({required this.repository});
  Future<Either<Failure,List<User>>> call()async{
    return await repository.getAllStudentInAdmin();
  }
}