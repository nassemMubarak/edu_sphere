import 'package:dartz/dartz.dart';
import 'package:edu_sphere/features/student/student_main/domain/repositorises/repository.dart';
import 'package:edu_sphere/features/teacher/assessments/domain/entities/document_assessment.dart';
import 'package:edu_sphere/features/teacher/course_main/domain/entities/lecture.dart';
import '../../../../../core/error/failure.dart';

class GetAllStudentDocumentCourseUseCase{
  final StudentMainRepository repository;
  GetAllStudentDocumentCourseUseCase({required this.repository});
  Future<Either<Failure,List<DocumentAssessment>>> call({required int idCourse})async{
    return await repository.getAllStudentDocumentCourse(idCourse: idCourse);
  }
}