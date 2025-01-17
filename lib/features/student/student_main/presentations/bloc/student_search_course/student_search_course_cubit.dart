import 'package:bloc/bloc.dart';
import 'package:edu_sphere/features/student/student_main/domain/usecases/get_all_student_courses.dart';
import 'package:edu_sphere/features/student/student_main/domain/usecases/subscribe_student_course.dart';
import 'package:edu_sphere/features/teacher/teacher_main/domain/entities/course.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../../../../core/error/failure.dart';
import '../../../../../../core/string/failure.dart';

part 'student_search_course_state.dart';

class StudentSearchCourseCubit extends Cubit<StudentSearchCourseState> {
  final GetAllStudentCoursesUseCase getAllStudentCoursesUseCase;
  final SubscribeStudentCourse subscribeStudentCourse;

  StudentSearchCourseCubit({
    required this.subscribeStudentCourse,
    required this.getAllStudentCoursesUseCase,
  }) : super(StudentSearchCourseInitial());

  List<Course> listCourse = [];
  List<Course> filteredCourses = [];
  final searchCourseKey = GlobalKey<FormState>();
  TextEditingController searchCourseController = TextEditingController();
  emitSubscribeStudentCourse(Course cou)async{
    emit(AddStudentToCourseLoadingState());
    final failureOrCourses = await subscribeStudentCourse(idCourse: cou.id);
    failureOrCourses.fold(
          (failure) => emit(
        GetAllCoursesSearchMessageErrorState(
          message: _mapFailureMessage(failure: failure),
        ),
      ),
          (unit) {
            listCourse.remove(cou);
            filteredCourses.remove(cou);
            emit(GetAllCoursesSearchLoadedState(courses: listCourse));

      },
    );
  }
  emitGetAllCourses() async {
    emit(GetAllCoursesSearchLoadingState());
    final failureOrCourses = await getAllStudentCoursesUseCase();
    failureOrCourses.fold(
          (failure) => emit(
        GetAllCoursesSearchMessageErrorState(
          message: _mapFailureMessage(failure: failure),
        ),
      ),
          (courses) {
        listCourse = courses;
        filteredCourses = courses; // Initialize filteredCourses with all courses
        emit(GetAllCoursesSearchLoadedState(courses: courses));
      },
    );
  }

  emitGetAllSearchCourses() {
    final searchText = searchCourseController.text.trim().toLowerCase();
    if (searchText.isEmpty) {
      filteredCourses = listCourse; // Reset to all courses if the search is empty
    } else {
      filteredCourses = listCourse.where((course) {
        return course.title.toLowerCase().contains(searchText);
      }).toList();
    }
    emit(GetAllSearchCoursesSearchLoadedState(courses: filteredCourses));
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
        return 'Unexpected Error, Please try again later.';
    }
  }
}
