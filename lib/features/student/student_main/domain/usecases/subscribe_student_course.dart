import 'package:dartz/dartz.dart';
import 'package:edu_sphere/features/student/student_main/domain/repositorises/repository.dart';
import 'package:edu_sphere/features/teacher/course_main/domain/entities/advertisement.dart';

import '../../../../../core/error/failure.dart';
import '../../../../teacher/teacher_main/domain/entities/course.dart';

class SubscribeStudentCourse{
  final StudentMainRepository repository;
  SubscribeStudentCourse({required this.repository});
  Future<Either<Failure,Unit>> call({required int idCourse})async{
    return await repository.subscribeStudentCourse(idCourse: idCourse);
  }
}