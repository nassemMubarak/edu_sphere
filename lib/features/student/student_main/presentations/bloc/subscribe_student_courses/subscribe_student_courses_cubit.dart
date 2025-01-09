import 'package:bloc/bloc.dart';
import 'package:edu_sphere/features/student/student_main/domain/usecases/get_all_subscribe_student_courses.dart';
import 'package:edu_sphere/features/student/student_main/domain/usecases/leave_student_course.dart';
import 'package:edu_sphere/features/teacher/teacher_main/domain/entities/course.dart';
import 'package:meta/meta.dart';

import '../../../../../../core/error/failure.dart';
import '../../../../../../core/string/failure.dart';

part 'subscribe_student_courses_state.dart';

class SubscribeStudentCoursesCubit extends Cubit<SubscribeStudentCoursesState> {
  final GetAllSubscribeStudentCoursesUseCase getAllSubscribeStudentCoursesUseCase;
  final LeaveStudentCourseUseCase leaveStudentCourseUseCase;
  Course? courseSelected;
  SubscribeStudentCoursesCubit({required this.leaveStudentCourseUseCase,required this.getAllSubscribeStudentCoursesUseCase}) : super(SubscribeStudentCoursesInitial());
    List<Course> listStudentCourse = [];
  emitGetAllSubscribeStudentCourses()async{
    emit(GetAllStudentSubscribeCoursesLoadingState());
    final failureOrCourses = await getAllSubscribeStudentCoursesUseCase();
    failureOrCourses.fold((failure)=>emit(GetAllStudentSubscribeCoursesMessageErrorState(message: _mapFailureMessage(failure: failure))), (courses){
      listStudentCourse = courses;
      emit(GetAllStudentSubscribeCoursesLoadedState(courses: listStudentCourse));
    });
  }
  emitLeaveSubscribeStudentCourses({required Course course})async{
    emit(LeaveStudentSubscribeCoursesLoadingState());
    final failureOrCourses = await leaveStudentCourseUseCase(idCourse: course.id);
    failureOrCourses.fold((failure)=>emit(GetAllStudentSubscribeCoursesMessageErrorState(message: _mapFailureMessage(failure: failure))), (unit){
      listStudentCourse.remove(course);
      emit(GetAllStudentSubscribeCoursesLoadedState(courses: listStudentCourse));
    });
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
