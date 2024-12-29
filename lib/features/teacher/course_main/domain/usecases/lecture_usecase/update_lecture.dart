import 'package:dartz/dartz.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/features/teacher/course_main/domain/entities/advertisement.dart';
import 'package:edu_sphere/features/teacher/course_main/domain/repositorises/repository.dart';

class UpdateLectureUseCase{
  final CourseMainRepository repository;
  UpdateLectureUseCase({required this.repository});
  Future<Either<Failure,Unit>> call({required int idLecture,required int idCourse,required Map data})async{
    return await repository.updateLecture(idLecture: idLecture, idCourse: idCourse, data: data);
  }
}