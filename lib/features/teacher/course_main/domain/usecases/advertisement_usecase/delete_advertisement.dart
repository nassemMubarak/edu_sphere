import 'package:dartz/dartz.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/features/teacher/course_main/domain/entities/advertisement.dart';
import 'package:edu_sphere/features/teacher/course_main/domain/repositorises/repository.dart';

class DeleteAdvertisementUseCase{
  final CourseMainRepository repository;
  DeleteAdvertisementUseCase({required this.repository});
  Future<Either<Failure,Unit>> call({required int idAdvertisement,required int idCourse})async{
    return await repository.deleteAdvertisement(idAdvertisement: idAdvertisement, idCourse: idCourse);
  }
}