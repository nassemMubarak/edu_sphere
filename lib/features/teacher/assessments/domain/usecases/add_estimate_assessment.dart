import 'package:dartz/dartz.dart';
import 'package:edu_sphere/features/teacher/assessments/domain/entities/assessment.dart';
import 'package:edu_sphere/features/teacher/assessments/domain/repositorises/assessment_repository.dart';

import '../../../../../core/error/failure.dart';

class AddEstimateAssessmentUseCase{
  final AssessmentRepository repository;
  AddEstimateAssessmentUseCase({required this.repository});
  Future<Either<Failure,Unit>> call({required int idCourse,required int idAssessment,required int idStudent,required int mark})async{
    return await repository.addEstimateAssessment(idCourse: idCourse, idAssessment: idAssessment,idStudent: idStudent,mark: mark);
  }
}