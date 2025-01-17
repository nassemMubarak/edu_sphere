import 'package:dartz/dartz.dart';
import 'package:edu_sphere/features/student/assessment_student/domain/repositorises/student_assessment_repository.dart';
import 'package:edu_sphere/features/teacher/assessments/domain/entities/assessment.dart';
import '../../../../../core/error/failure.dart';

class GetAllStudentAssessmentUseCase{
  final StudentAssessmentRepository repository;
  GetAllStudentAssessmentUseCase({required this.repository});
  Future<Either<Failure,List<Assessment>>> call({required int idCourse})async{
    return await repository.getAllStudentAssessment(idCourse: idCourse);
  }
}