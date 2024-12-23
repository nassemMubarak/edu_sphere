import 'package:dartz/dartz.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/features/teacher/teacher_main/domain/entities/course.dart';
import 'package:edu_sphere/features/teacher/teacher_main/domain/repository/repository.dart';

class AddCourseUseCase{
  final TeacherMainRepository repository;
  AddCourseUseCase({required this.repository});
  Future<Either<Failure,Course>> call({required Map courseData})async{
    return await repository.addCourse(courseData: courseData);
  }
}