import 'package:bloc/bloc.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/core/string/failure.dart';
import 'package:edu_sphere/features/student/estimates_students/domain/entities/estimates_student.dart';
import 'package:edu_sphere/features/student/estimates_students/domain/usecases/show_estimate_student_to_course.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';

part 'estimate_student_state.dart';

class EstimateStudentCubit extends Cubit<EstimateStudentState> {
  final ShowEstimateStudentToCourseUseCase showEstimateStudentToCourse;

  EstimateStudentCubit({required this.showEstimateStudentToCourse})
      : super(EstimateStudentInitial());
  EstimatesStudent? estimatesStudent;

  emitShowEstimateStudentToCourse({required int idCourse}) async {
    emit(ShowEstimateStudentLoadingState());
    final failureOrAdvertisement =
        await showEstimateStudentToCourse(idCourse: idCourse);
    failureOrAdvertisement.fold((failure) {
      estimatesStudent = null;
      emit(ShowEstimateStudentErrorState(
          message: _mapFailureMessage(failure: failure)));
    }, (estimatesStudent) {
      Logger().d('estimatesStudent ---->   $estimatesStudent');
      this.estimatesStudent = estimatesStudent;
      emit(ShowEstimateStudentLoadedState(
          estimatesStudent: this.estimatesStudent!));
    });
  }

  String _mapFailureMessage({required Failure failure}) {
    switch (failure.runtimeType) {
      case InvalidDataFailureMessage:
        return failure.message ?? '';
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      case EmptyCacheFailure:
        return CACHE_FAILURE_MESSAGE;
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case InvalidDataFailure:
        Logger().f('failure---------------------------------$failure');
        return INVALID_DATA_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error, Please try again later .';
    }
  }
}
