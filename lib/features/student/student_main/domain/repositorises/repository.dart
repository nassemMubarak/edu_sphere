import 'package:dartz/dartz.dart';
import 'package:edu_sphere/features/teacher/assessments/domain/entities/document_assessment.dart';
import 'package:edu_sphere/features/teacher/course_main/domain/entities/advertisement.dart';
import 'package:edu_sphere/features/teacher/course_main/domain/entities/lecture.dart';

import '../../../../../core/error/failure.dart';
import '../../../../teacher/teacher_main/domain/entities/course.dart';

abstract class StudentMainRepository{
  Future<Either<Failure,List<Course>>> getAllStudentCourses();
  Future<Either<Failure,List<Course>>> getAllSubscribeStudentCourses();
  Future<Either<Failure,Unit>> subscribeStudentCourse({required int idCourse});
  Future<Either<Failure,List<Advertisement>>> getAllStudentAdvertisement({required int idCourse});
  Future<Either<Failure,List<Lecture>>> getAllStudentLecture({required int idCourse});
  Future<Either<Failure,List<DocumentAssessment>>> getAllStudentDocumentCourse({required int idCourse});
  Future<Either<Failure,Unit>> leaveStudentCourse({required int idCourse});
}