import 'package:bloc/bloc.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/core/string/failure.dart';
import 'package:edu_sphere/features/auth/domain/entities/user.dart';
import 'package:edu_sphere/features/student/show_studetn_course_teachers/domain/entities/show_student_teacher.dart';
import 'package:edu_sphere/features/student/show_studetn_course_teachers/domain/usecases/get_all_student_teacher.dart';
import 'package:edu_sphere/features/student/show_studetn_course_teachers/domain/usecases/show_teacher_information.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';

part 'show_student_teacher_state.dart';

class ShowStudentTeacherCubit extends Cubit<ShowStudentTeacherState> {
  final GetAllStudentTeacherUseCase getAllStudentTeacherUseCase;
  final ShowTeacherInformationUseCase showTeacherInformationUseCase;

  ShowStudentTeacherCubit(
      {required this.showTeacherInformationUseCase,
      required this.getAllStudentTeacherUseCase})
      : super(ShowStudentTeacherInitial());

  List<User> listTeacherToStudent = [];
  ShowStudentTeacher? showStudentTeacher;
  emitGetAllStudentTeacher()async{
    emit(GetAllStudentTeacherLoadingState());
    final failureOrAdvertisement = await getAllStudentTeacherUseCase();
    failureOrAdvertisement.fold((failure)=>emit(ErrorStudentTeacherState(message: _mapFailureMessage(failure: failure))),
            (userTeacher){
          Logger().d('userTeacher  list ---->   $userTeacher');
          listTeacherToStudent = userTeacher;
          emit(GetAllStudentTeacherLoadedState(listTeacherToStudent: listTeacherToStudent));
        });
  }
  int? idTeacher;
  emitShowTeacherInformationUse({required int idTeacher})async{
    emit(ShowStudentTeacherLoadingState());
    final failureOrAdvertisement = await showTeacherInformationUseCase(idTeacher: idTeacher);
    failureOrAdvertisement.fold((failure){
      showStudentTeacher = null;
      emit(ErrorStudentTeacherState(message: _mapFailureMessage(failure: failure)));
    },
            (userTeacher){
          Logger().d('userTeacher  list ---->   $userTeacher');
          showStudentTeacher = userTeacher;
          emit(ShowStudentTeacherLoadedState(showStudentTeacher: showStudentTeacher!));
        });
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
        Logger().f('failure---------------------------------$failure');
        return INVALID_DATA_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error, Please try again later .';
    }
  }
}
