import 'package:dartz/dartz.dart';
import 'package:edu_sphere/features/teacher/assessments/domain/entities/assessment.dart';
import 'package:edu_sphere/features/teacher/assessments/domain/repositorises/assessment_repository.dart';

import '../../../../../core/error/failure.dart';

class UpdateAssessmentUseCase{
  final AssessmentRepository repository;
  UpdateAssessmentUseCase({required this.repository});
  Future<Either<Failure,Unit>> call({required int idAssessment,required int idCourse,required Map data})async{
    return await repository.updateAssessment(idAssessment: idAssessment, idCourse: idCourse, data: data);
  }
}