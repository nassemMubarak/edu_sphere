import 'package:dartz/dartz.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/features/student/estimates_students/data/model/estimates_student_model.dart';
import 'package:edu_sphere/features/student/estimates_students/domain/entities/estimates_student.dart';

abstract class EstimateStudentRepository{
  Future<Either<Failure,EstimatesStudentModel>> showEstimateStudentToCourse({required int idCourse});
}