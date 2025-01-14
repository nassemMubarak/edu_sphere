import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:edu_sphere/features/student/assessment_student/data/models/document_student_assessment_model.dart';
import 'package:edu_sphere/features/student/assessment_student/domain/entities/document_student_assessment.dart';
import 'package:edu_sphere/features/teacher/assessments/domain/entities/assessment.dart';

import '../../../../../core/error/failure.dart';

abstract class StudentAssessmentRepository{
  /// assessment
  Future<Either<Failure,List<Assessment>>> getAllStudentAssessment({required int idCourse});
  Future<Either<Failure,Assessment>> showStudentAssessment({required int idCourse,required int idAssessment});
  /// add Document to assessment
  Future<Either<Failure,DocumentStudentAssessment>> submitStudentDocumentToAssessment({required int idCourse,required int idAssessment,required List<File> files});
  Future<Either<Failure,DocumentStudentAssessment>> getAllSubmitStudentDocumentToAssessment({required int idCourse,required int idAssessment});
  Future<Either<Failure,Unit>> deleteSubmitStudentDocumentToAssessment({required int idCourse,required int idAssessment});
}