import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:edu_sphere/features/teacher/assessments/domain/entities/document_assessment.dart';
import 'package:edu_sphere/features/teacher/course_main/domain/repositorises/repository.dart';

import '../../../../../../core/error/failure.dart';


class GetAllDocumentToCourseUseCase{
  final CourseMainRepository repository;
  GetAllDocumentToCourseUseCase({required this.repository});
  Future<Either<Failure,List<DocumentAssessment>>> call({required int idCourse})async{
    return await repository.getAllDocumentToCourse(idCourse: idCourse);
  }
}