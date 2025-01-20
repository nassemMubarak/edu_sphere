import 'package:dartz/dartz.dart';
import 'package:edu_sphere/features/student/show_studetn_course_teachers/domain/repositorises/show_repository_student_teature.dart';

import '../../../../../core/error/failure.dart';
import '../../../../auth/domain/entities/user.dart';

class GetAllStudentTeacherUseCase {
  final ShowRepositoryStudentTeacher repository;
  GetAllStudentTeacherUseCase({required this.repository});
  Future<Either<Failure,List<User>>> call()async{
    return await repository.getAllStudentTeacher();
  }
}