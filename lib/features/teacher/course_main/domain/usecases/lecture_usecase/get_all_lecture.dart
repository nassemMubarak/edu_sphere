import 'package:dartz/dartz.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/features/teacher/course_main/domain/entities/lecture.dart';
import 'package:edu_sphere/features/teacher/course_main/domain/repositorises/repository.dart';

class GetAllLectureUseCase{
  final CourseMainRepository repository;
  GetAllLectureUseCase({required this.repository});
  Future<Either<Failure,List<Lecture>>> call({required int idCourse})async{
    return await repository.getAllLecture(idCourse: idCourse);
  }
}