import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:edu_sphere/features/teacher/assessments/domain/entities/document_assessment.dart';
import 'package:edu_sphere/features/teacher/course_main/domain/repositorises/repository.dart';

import '../../../../../../core/error/failure.dart';


class DeleteDocumentToCourseUseCase{
  final CourseMainRepository repository;
  DeleteDocumentToCourseUseCase({required this.repository});
  Future<Either<Failure,Unit>> call({required int idCourse,required int idDocument})async{
    return await repository.deleteDocumentToCourse(idCourse: idCourse, idDocument: idDocument);
  }
}