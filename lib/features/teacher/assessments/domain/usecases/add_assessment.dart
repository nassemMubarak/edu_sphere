import 'package:dartz/dartz.dart';
import 'package:edu_sphere/features/teacher/assessments/domain/entities/assessment.dart';
import 'package:edu_sphere/features/teacher/assessments/domain/repositorises/assessment_repository.dart';

import '../../../../../core/error/failure.dart';

class AddAssessmentUseCase{
  final AssessmentRepository repository;
  AddAssessmentUseCase({required this.repository});
  Future<Either<Failure,Assessment>> call({required int idCourse,required Map data})async{
    return await repository.addAssessment(idCourse: idCourse, data: data);
  }
}