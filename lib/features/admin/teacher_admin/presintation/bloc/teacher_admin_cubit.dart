import 'package:bloc/bloc.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/core/string/failure.dart';
import 'package:edu_sphere/features/admin/teacher_admin/domain/entities/teacher_informstion.dart';
import 'package:edu_sphere/features/admin/teacher_admin/domain/usescases/get_information_teacher.dart';
import 'package:edu_sphere/features/teacher/teacher_main/domain/entities/course.dart';
import 'package:meta/meta.dart';

part 'teacher_admin_state.dart';

class TeacherAdminCubit extends Cubit<TeacherAdminState> {
  GetInformationTeacherUseCase getInformationTeacherUseCase;
  TeacherAdminCubit({
    required this.getInformationTeacherUseCase
}) : super(TeacherAdminInitial());
  TeacherInformation? teacherInformation;
  Course? courseSelected;
  emitGetInformationTeacher({required int idTeacher})async{
    emit(GetInformationTeacherLoadingState());
    final failureOrInformationTeacher = await getInformationTeacherUseCase(idTeacher: idTeacher);
    failureOrInformationTeacher.fold((failure) => emit(ErrorMessageGetInformationTeacherState(message: _mapFailureMessage(failure: failure))), (informationTeacher) {
      teacherInformation = informationTeacher;
      emit(GetInformationTeacherLoadedDataState(teacherInformation: teacherInformation!));
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
