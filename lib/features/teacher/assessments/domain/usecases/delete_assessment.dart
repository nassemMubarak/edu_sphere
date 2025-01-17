import 'package:dartz/dartz.dart';
import 'package:edu_sphere/features/teacher/assessments/domain/entities/assessment.dart';
import 'package:edu_sphere/features/teacher/assessments/domain/repositorises/assessment_repository.dart';

import '../../../../../core/error/failure.dart';

class DeleteAssessmentUseCase{
  final AssessmentRepository repository;
  DeleteAssessmentUseCase({required this.repository});
  Future<Either<Failure,Unit>> call({required int idAssessment,required int idCourse})async{
    return await repository.deleteAssessment(idAssessment: idAssessment, idCourse: idCourse);
  }
}