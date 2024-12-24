import 'package:dartz/dartz.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/features/teacher/course_main/domain/entities/advertisement.dart';

abstract class CourseMainRepository {
  // add Advertisement
  Future<Either<Failure,List<Advertisement>>> getAllAdvertisement({required int idCourse});
  Future<Either<Failure,Advertisement>> addAdvertisement({required int idCourse,required Map data});
  Future<Either<Failure,Advertisement>> updateAdvertisement({required int idAdvertisement,required int idCourse,required Map data});
  Future<Either<Failure,Unit>> deleteAdvertisement({required int idAdvertisement,required int idCourse});
  // add lecture course

}