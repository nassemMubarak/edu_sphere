import 'package:bloc/bloc.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/core/string/failure.dart';
import 'package:edu_sphere/features/admin/admin_main/domain/usecases/get_all_student_in_admin.dart';
import 'package:edu_sphere/features/auth/domain/entities/user.dart';
import 'package:meta/meta.dart';

part 'admin_student_main_state.dart';

class AdminStudentMainCubit extends Cubit<AdminStudentMainState> {
  GetAllStudentInAdminUseCase getAllStudentInAdminUseCase;

  AdminStudentMainCubit({
    required this.getAllStudentInAdminUseCase,
  }) : super(AdminStudentMainInitial());
  List<User> listStudent = [];
  User? selectedStudent;

  emitGetAllStudentInAdmin() async {
    emit(GetAllStudentInAdminLoadingState());
    final failureOrListStudent = await getAllStudentInAdminUseCase();
    failureOrListStudent.fold(
          (failure) => emit(ErrorMessageGetAllStudentInAdminState(
          message: _mapFailureMessage(failure: failure))),
          (listStudent) {
        this.listStudent = listStudent;
        emit(GetAllStudentInAdminLoadedState(listStudent: this.listStudent));
      },
    );
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
        return INVALID_DATA_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error, Please try again later .';
    }
  }
}
