import 'package:bloc/bloc.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/core/string/failure.dart';
import 'package:edu_sphere/features/admin/teacher_admin/domain/entities/show_teacher_courses.dart';
import 'package:edu_sphere/features/admin/teacher_admin/domain/usescases/show_course_teacher_admin.dart';
import 'package:meta/meta.dart';

part 'show_course_teacher_state.dart';

class ShowCourseTeacherCubit extends Cubit<ShowCourseTeacherState> {
  ShowCourseTeacherAdminUseCase showCourseTeacherAdminUseCase;
  ShowCourseTeacherCubit({
    required this.showCourseTeacherAdminUseCase
}) : super(ShowCourseTeacherInitial());
  ShowCourseTeacher? showCourseTeacher;
  emitShowCourseTeacher({required int idCourse})async{
    emit(ShowCourseTeacherLoadingState());
    final failureOrInformationTeacher = await showCourseTeacherAdminUseCase(idCourse:idCourse );
    failureOrInformationTeacher.fold((failure) => emit(ErrorMessageShowCourseTeacherState(message: _mapFailureMessage(failure: failure))), (courseTeacher) {
      showCourseTeacher = courseTeacher;
      emit(ShowCourseTeacherLoadedDataState(showCourseTeacher: showCourseTeacher!));
    },);
  }
  String _mapFailureMessage({required Failure failure}) {
    switch (failure.runtimeType) {
      case InvalidDataFailureMessage:
        return failure.message??'';
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      case EmptyCacheFailure:
        return CACHE_FAILURE_MESSAGE;
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case InvalidDataFailure:
        return INVALID_DATA_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error, Please try again later .';
    }
  }

}
