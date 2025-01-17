import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:edu_sphere/features/student/assessment_student/domain/entities/document_student_assessment.dart';
import 'package:edu_sphere/features/student/assessment_student/domain/repositorises/student_assessment_repository.dart';
import 'package:edu_sphere/features/teacher/assessments/domain/entities/document_assessment.dart';
import '../../../../../core/error/failure.dart';

class SubmitStudentDocumentToAssessmentUseCase{
  final StudentAssessmentRepository repository;
  SubmitStudentDocumentToAssessmentUseCase({required this.repository});
  Future<Either<Failure,DocumentStudentAssessment>> call({required int idCourse,required int idAssessment,required List<File> files})async{
    return await repository.submitStudentDocumentToAssessment(idCourse: idCourse,idAssessment: idAssessment,files: files);
  }
}