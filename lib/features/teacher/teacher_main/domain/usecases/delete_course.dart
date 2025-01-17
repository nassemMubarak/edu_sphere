import 'package:dartz/dartz.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/features/teacher/teacher_main/domain/entities/course.dart';
import 'package:edu_sphere/features/teacher/teacher_main/domain/repository/repository.dart';

class DeleteCourseUseCase{
  final TeacherMainRepository repository;
  DeleteCourseUseCase({required this.repository});
  Future<Either<Failure,Unit>> call({required int id})async{
    return await repository.deleteCourse(id: id);
  }
}