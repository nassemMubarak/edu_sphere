import 'package:bloc/bloc.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/core/string/failure.dart';
import 'package:edu_sphere/features/admin/admin_main/domain/usecases/get_all_student_in_admin.dart';
import 'package:edu_sphere/features/admin/admin_main/domain/usecases/get_all_teacher_in_admin.dart';
import 'package:edu_sphere/features/auth/domain/entities/user.dart';
import 'package:meta/meta.dart';

part 'admin_main_state.dart';

class AdminMainCubit extends Cubit<AdminMainState> {
  GetAllTeacherInAdminUseCase getAllTeacherInAdminUseCase;

  AdminMainCubit({
    required this.getAllTeacherInAdminUseCase,
  }) : super(AdminMainInitial());
  List<User> listTeacher = [];
  User? selectedTeacher;
  User? selectedStudent;
  emitGetAllTeacherInAdmin() async {
    emit(GetAllTeacherInAdminLoadingState());
    final failureOrListTeacher = await getAllTeacherInAdminUseCase();
    failureOrListTeacher.fold(
      (failure) => emit(ErrorMessageGetAllTeacherInAdminState(
          message: _mapFailureMessage(failure: failure))),
      (listTeacher) {
        this.listTeacher = listTeacher;
        emit(GetAllTeacherInAdminLoadedState(listTeacher: this.listTeacher));
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
