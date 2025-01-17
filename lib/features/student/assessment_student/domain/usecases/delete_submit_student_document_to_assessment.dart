
import 'package:dartz/dartz.dart';
import 'package:edu_sphere/features/student/assessment_student/domain/repositorises/student_assessment_repository.dart';
import '../../../../../core/error/failure.dart';

class DeleteSubmitStudentDocumentToAssessmentUseCase{
  final StudentAssessmentRepository repository;
  DeleteSubmitStudentDocumentToAssessmentUseCase({required this.repository});
  Future<Either<Failure,Unit>> call({required int idCourse,required int idAssessment})async{
    return await repository.deleteSubmitStudentDocumentToAssessment(idCourse: idCourse,idAssessment: idAssessment);
  }
}