import 'package:dartz/dartz.dart';
import 'package:edu_sphere/features/student/student_main/domain/repositorises/repository.dart';
import 'package:edu_sphere/features/teacher/course_main/domain/entities/lecture.dart';
import '../../../../../core/error/failure.dart';

class GetAllStudentLectureCourseUseCase{
  final StudentMainRepository repository;
  GetAllStudentLectureCourseUseCase({required this.repository});
  Future<Either<Failure,List<Lecture>>> call({required int idCourse})async{
    return await repository.getAllStudentLecture(idCourse: idCourse);
  }
}