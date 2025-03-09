import 'package:dartz/dartz.dart';
import 'package:edu_sphere/features/admin/student_main/data/model/student_information_model.dart';
import 'package:edu_sphere/features/admin/student_main/domain/repositorises/student_admin_repository.dart';
import 'package:edu_sphere/features/admin/teacher_admin/domain/entities/teacher_informstion.dart';
import 'package:edu_sphere/features/admin/teacher_admin/domain/repositorises/teacher_admin_repository.dart';

import '../../../../../core/error/failure.dart';

class GetInformationStudentUseCase{
  final StudentAdminRepository repository;
  GetInformationStudentUseCase({required this.repository});
  Future<Either<Failure,StudentInformationModel>> call({required int idStudent})async{
    return await repository.getInformationStudent(idStudent: idStudent);
  }
}