import 'package:dartz/dartz.dart';
import 'package:edu_sphere/features/admin/teacher_admin/domain/entities/show_teacher_courses.dart';
import 'package:edu_sphere/features/admin/teacher_admin/domain/repositorises/teacher_admin_repository.dart';

import '../../../../../core/error/failure.dart';
import '../entities/teacher_informstion.dart';

class ShowCourseTeacherAdminUseCase{
  final TeacherAdminRepository repository;
  ShowCourseTeacherAdminUseCase({required this.repository});
  Future<Either<Failure,ShowCourseTeacher>> call({required int idCourse})async{
    return await repository.showCourseTeacherAdmin(idCourse: idCourse);
  }
}