import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:edu_sphere/features/teacher/assessments/domain/entities/document_assessment.dart';
import 'package:edu_sphere/features/teacher/course_main/domain/repositorises/repository.dart';

import '../../../../../../core/error/failure.dart';


class AddDocumentToCourseUseCase{
  final CourseMainRepository repository;
  AddDocumentToCourseUseCase({required this.repository});
  Future<Either<Failure,List<DocumentAssessment>>> call({required int idCourse,required List<File> files})async{
    return await repository.addDocumentToCourse(idCourse: idCourse, files: files);
  }
}