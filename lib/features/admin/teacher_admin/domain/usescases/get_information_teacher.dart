import 'package:dartz/dartz.dart';
import 'package:edu_sphere/features/admin/teacher_admin/domain/repositorises/teacher_admin_repository.dart';

import '../../../../../core/error/failure.dart';
import '../entities/teacher_informstion.dart';

class GetInformationTeacherUseCase{
  final TeacherAdminRepository repository;
  GetInformationTeacherUseCase({required this.repository});
  Future<Either<Failure,TeacherInformation>> call({required int idTeacher})async{
    return await repository.getInformationTeacher(idTeacher: idTeacher);
  }
}