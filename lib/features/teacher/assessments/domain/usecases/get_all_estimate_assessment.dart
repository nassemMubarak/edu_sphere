import 'package:dartz/dartz.dart';
import 'package:edu_sphere/features/teacher/assessments/domain/entities/assessment.dart';
import 'package:edu_sphere/features/teacher/assessments/domain/entities/estimate_assessment.dart';
import 'package:edu_sphere/features/teacher/assessments/domain/repositorises/assessment_repository.dart';

import '../../../../../core/error/failure.dart';

class GetAllEstimateAssessmentUseCase{
  final AssessmentRepository repository;
  GetAllEstimateAssessmentUseCase({required this.repository});
  Future<Either<Failure,List<EstimateAssessment>>> call({required int idCourse,required int idAssessment})async{
    return await repository.getAllEstimateAssessment(idCourse: idCourse,idAssessment: idAssessment);
  }
}