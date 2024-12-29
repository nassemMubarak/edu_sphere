import 'package:dartz/dartz.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/features/teacher/course_main/domain/entities/lecture.dart';
import 'package:edu_sphere/features/teacher/course_main/domain/repositorises/repository.dart';

class AddLectureUseCase{
  final CourseMainRepository repository;
  AddLectureUseCase({required this.repository});
  Future<Either<Failure,Lecture>> call({required int idCourse,required Map data})async{
    return await repository.addLecture(idCourse: idCourse, data: data);
  }
}