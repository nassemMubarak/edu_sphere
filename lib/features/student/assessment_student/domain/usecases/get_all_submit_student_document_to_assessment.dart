import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:edu_sphere/features/student/assessment_student/domain/entities/document_student_assessment.dart';
import 'package:edu_sphere/features/student/assessment_student/domain/repositorises/student_assessment_repository.dart';
import 'package:edu_sphere/features/teacher/assessments/domain/entities/assessment.dart';
import 'package:edu_sphere/features/teacher/assessments/domain/entities/document_assessment.dart';
import '../../../../../core/error/failure.dart';

class GetAllSubmitStudentDocumentToAssessmentUseCase{
  final StudentAssessmentRepository repository;
  GetAllSubmitStudentDocumentToAssessmentUseCase({required this.repository});
  Future<Either<Failure,DocumentStudentAssessment>> call({required int idCourse,required int idAssessment})async{
    return await repository.getAllSubmitStudentDocumentToAssessment(idCourse: idCourse,idAssessment: idAssessment);
  }
}