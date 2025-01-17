import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:edu_sphere/features/teacher/assessments/domain/entities/assessment.dart';
import 'package:edu_sphere/features/teacher/assessments/domain/entities/document_assessment.dart';
import 'package:edu_sphere/features/teacher/assessments/domain/repositorises/assessment_repository.dart';

import '../../../../../core/error/failure.dart';

class DownloadDocumentToAssessmentUseCase{
  final AssessmentRepository repository;
  DownloadDocumentToAssessmentUseCase({required this.repository});
  Future<Either<Failure,Unit>> call({required int idCourse,required int idAssessment,required int idDocument})async{
    return await repository.downloadDocumentToAssessment(idCourse: idCourse, idAssessment: idAssessment, idDocument: idDocument);
  }
}