import 'package:dartz/dartz.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/features/teacher/course_main/domain/entities/advertisement.dart';
import 'package:edu_sphere/features/teacher/course_main/domain/repositorises/repository.dart';

class DeleteLectureUseCase{
  final CourseMainRepository repository;
  DeleteLectureUseCase({required this.repository});
  Future<Either<Failure,Unit>> call({required int idLecture,required int idCourse})async{
    return await repository.deleteLecture(idLecture: idLecture, idCourse: idCourse);
  }
}