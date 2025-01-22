import 'package:dartz/dartz.dart';
import 'package:edu_sphere/features/student/estimates_students/domain/repositorises/estimates_student_repository.dart';

import '../../../../../core/error/failure.dart';
import '../../data/model/estimates_student_model.dart';

class ShowEstimateStudentToCourseUseCase{
  final EstimateStudentRepository repository;
  ShowEstimateStudentToCourseUseCase({required this.repository});
  Future<Either<Failure,EstimatesStudentModel>> call({required int idCourse})async{
    return await repository.showEstimateStudentToCourse(idCourse: idCourse);
  }
}