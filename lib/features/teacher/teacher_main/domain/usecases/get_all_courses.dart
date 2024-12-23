import 'package:dartz/dartz.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/features/teacher/teacher_main/domain/entities/course.dart';
import 'package:edu_sphere/features/teacher/teacher_main/domain/repository/repository.dart';

class GetAllCoursesUseCase{
  final TeacherMainRepository repository;
  GetAllCoursesUseCase({required this.repository});
  Future<Either<Failure,List<Course>>> call()async{
    return await repository.getAllCourses();
  }
}