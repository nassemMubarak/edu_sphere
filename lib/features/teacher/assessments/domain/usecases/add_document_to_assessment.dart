import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:edu_sphere/features/teacher/assessments/domain/entities/assessment.dart';
import 'package:edu_sphere/features/teacher/assessments/domain/entities/document_assessment.dart';
import 'package:edu_sphere/features/teacher/assessments/domain/repositorises/assessment_repository.dart';

import '../../../../../core/error/failure.dart';

class AddDocumentToAssessmentUseCase{
  final AssessmentRepository repository;
  AddDocumentToAssessmentUseCase({required this.repository});
  Future<Either<Failure,List<DocumentAssessment>>> call({required int idCourse,required int idAssessment,required List<File> files})async{
    return await repository.addDocumentToAssessment(idCourse: idCourse, idAssessment: idAssessment, files: files);
  }
}