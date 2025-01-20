import 'package:dartz/dartz.dart';
import 'package:edu_sphere/features/student/show_studetn_course_teachers/domain/entities/show_student_teacher.dart';
import 'package:edu_sphere/features/student/show_studetn_course_teachers/domain/repositorises/show_repository_student_teature.dart';

import '../../../../../core/error/failure.dart';
import '../../../../auth/domain/entities/user.dart';

class ShowTeacherInformationUseCase {
  final ShowRepositoryStudentTeacher repository;
  ShowTeacherInformationUseCase({required this.repository});
  Future<Either<Failure,ShowStudentTeacher>> call({required int idTeacher})async{
    return await repository.showTeacherInformation(idTeacher: idTeacher);
  }
}