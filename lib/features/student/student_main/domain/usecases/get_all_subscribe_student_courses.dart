import 'package:dartz/dartz.dart';
import 'package:edu_sphere/features/student/student_main/domain/repositorises/repository.dart';

import '../../../../../core/error/failure.dart';
import '../../../../teacher/teacher_main/domain/entities/course.dart';

class GetAllSubscribeStudentCoursesUseCase{
  final StudentMainRepository repository;
  GetAllSubscribeStudentCoursesUseCase({required this.repository});
  Future<Either<Failure,List<Course>>> call()async{
    return await repository.getAllSubscribeStudentCourses();
  }
}