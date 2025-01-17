import 'package:dartz/dartz.dart';
import 'package:edu_sphere/features/student/assessment_student/domain/repositorises/student_assessment_repository.dart';
import 'package:edu_sphere/features/teacher/assessments/domain/entities/assessment.dart';
import '../../../../../core/error/failure.dart';

class ShowStudentAssessmentUseCase{
  final StudentAssessmentRepository repository;
  ShowStudentAssessmentUseCase({required this.repository});
  Future<Either<Failure,Assessment>> call({required int idCourse,required int idAssessment})async{
    return await repository.showStudentAssessment(idCourse: idCourse,idAssessment: idAssessment);
  }
}