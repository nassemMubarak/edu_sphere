import 'package:dartz/dartz.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/features/teacher/course_main/domain/entities/advertisement.dart';
import 'package:edu_sphere/features/teacher/course_main/domain/repositorises/repository.dart';

class UpdateAdvertisementUseCase{
  final CourseMainRepository repository;
  UpdateAdvertisementUseCase({required this.repository});
  Future<Either<Failure,Advertisement>> call({required int idAdvertisement,required int idCourse,required Map data})async{
    return await repository.updateAdvertisement(idAdvertisement: idAdvertisement, idCourse: idCourse, data: data);
  }
}