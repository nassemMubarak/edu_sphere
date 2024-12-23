import 'package:dartz/dartz.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/features/teacher/teacher_main/domain/entities/course.dart';
import 'package:edu_sphere/features/teacher/teacher_main/domain/repository/repository.dart';

class UpdateCourseUseCase{
  final TeacherMainRepository repository;
  UpdateCourseUseCase({required this.repository});
  Future<Either<Failure,Unit>> call({required Map courseData,required int id})async{
    return await repository.updateCourse(courseData: courseData,id: id);
  }
}