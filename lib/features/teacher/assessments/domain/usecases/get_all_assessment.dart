import 'package:dartz/dartz.dart';
import 'package:edu_sphere/features/teacher/assessments/domain/entities/assessment.dart';
import 'package:edu_sphere/features/teacher/assessments/domain/repositorises/assessment_repository.dart';

import '../../../../../core/error/failure.dart';

class GetAllAssessmentUseCase{
  final AssessmentRepository repository;
  GetAllAssessmentUseCase({required this.repository});
  Future<Either<Failure,List<Assessment>>> call({required int idCourse})async{
    return await repository.getAllAssessment(idCourse: idCourse);
  }
}