import 'package:dartz/dartz.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/features/teacher/course_main/domain/entities/advertisement.dart';
import 'package:edu_sphere/features/teacher/course_main/domain/repositorises/repository.dart';

class GetAllAdvertisementUseCase{
  final CourseMainRepository repository;
  GetAllAdvertisementUseCase({required this.repository});
  Future<Either<Failure,List<Advertisement>>> call({required int idCourse})async{
    return await repository.getAllAdvertisement(idCourse: idCourse);
  }
}