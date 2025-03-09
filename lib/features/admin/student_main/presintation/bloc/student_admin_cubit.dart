import 'package:bloc/bloc.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/core/string/failure.dart';
import 'package:edu_sphere/features/admin/student_main/data/model/student_information_model.dart';
import 'package:edu_sphere/features/admin/student_main/domain/usecase/get_information_student.dart';
import 'package:edu_sphere/features/admin/teacher_admin/domain/entities/teacher_informstion.dart';
import 'package:meta/meta.dart';

part 'student_admin_state.dart';

class StudentAdminCubit extends Cubit<StudentAdminState> {
  GetInformationStudentUseCase getInformationStudentUseCase;
  StudentAdminCubit({required this.getInformationStudentUseCase}) : super(StudentAdminInitial());
  StudentInformationModel? studentInformation;
  emitGetInformationStudent({required int idStudent})async{
    emit(GetInformationStudentLoadingState());
    final failureOrInformationTeacher = await getInformationStudentUseCase(idStudent: idStudent );
    failureOrInformationTeacher.fold((failure) => emit(ErrorMessageGetInformationStudentState(message: _mapFailureMessage(failure: failure))), (informationTeacher) {
      studentInformation = informationTeacher;
      emit(GetInformationStudentLoadedDataState(studentInformation: studentInformation!));
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
