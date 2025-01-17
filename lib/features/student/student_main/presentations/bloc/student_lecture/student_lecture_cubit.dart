import 'package:bloc/bloc.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/core/string/failure.dart';
import 'package:edu_sphere/features/student/student_main/domain/usecases/get_all_student_lecture_course.dart';
import 'package:edu_sphere/features/teacher/course_main/domain/entities/lecture.dart';
import 'package:meta/meta.dart';

part 'student_lecture_state.dart';

class StudentLectureCubit extends Cubit<StudentLectureState> {
  final GetAllStudentLectureCourseUseCase getAllStudentLectureCourseUseCase;
  StudentLectureCubit({
    required this.getAllStudentLectureCourseUseCase
}) : super(StudentLectureInitial());
  List<Lecture> lectureList=[];
  emitGetAllStudentLecturesLoadingState({required int idCourse})async{
    emit(GetAllStudentLecturesLoadingState());
    final failureOrAdvertisement = await getAllStudentLectureCourseUseCase(idCourse:idCourse);
    failureOrAdvertisement.fold((failure)=>emit(GetAllStudentLecturesMessageErrorState(message: _mapFailureMessage(failure: failure))), (lectures){
      lectureList = lectures;
      emit(GetAllStudentLecturesLoadedState(lecture: lectureList));
    }) ;
  }
  String _mapFailureMessage({required Failure failure}) {
    switch (failure.runtimeType) {
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
