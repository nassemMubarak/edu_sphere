import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:edu_sphere/features/teacher/assessments/domain/entities/assessment.dart';
import 'package:edu_sphere/features/teacher/assessments/domain/entities/document_assessment.dart';
import 'package:edu_sphere/features/teacher/assessments/domain/entities/estimate_assessment.dart';

import '../../../../../core/error/failure.dart';

abstract class AssessmentRepository{
  /// assessment
  Future<Either<Failure,List<Assessment>>> getAllAssessment({required int idCourse});
  Future<Either<Failure,Assessment>> addAssessment({required int idCourse,required Map data});
  Future<Either<Failure,Unit>> updateAssessment({required int idAssessment,required int idCourse,required Map data});
  Future<Either<Failure,Unit>> deleteAssessment({required int idAssessment,required int idCourse});
  /// add Document to assessment
  Future<Either<Failure,List<DocumentAssessment>>> addDocumentToAssessment({required int idCourse,required int idAssessment,required List<File> files});
  Future<Either<Failure,Unit>> deleteDocumentToAssessment({required int idCourse,required int idAssessment,required int idDocument});
  Future<Either<Failure,Unit>> downloadDocumentToAssessment({required int idCourse,required int idAssessment,required int idDocument});
  /// get all estimate assessment
  Future<Either<Failure,List<EstimateAssessment>>> getAllEstimateAssessment({required int idCourse,required int idAssessment});
  Future<Either<Failure,Unit>> addEstimateAssessment({required int idCourse,required int idAssessment,required int idStudent,required int mark});

}