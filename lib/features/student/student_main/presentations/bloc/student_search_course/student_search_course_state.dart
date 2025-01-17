part of 'student_search_course_cubit.dart';

@immutable
sealed class StudentSearchCourseState {}

final class StudentSearchCourseInitial extends StudentSearchCourseState {}
class GetAllCoursesSearchLoadedState extends StudentSearchCourseState{
  final List<Course> courses;

  GetAllCoursesSearchLoadedState({required this.courses});

  @override
  List<Object> get props => [courses];
}
class GetAllSearchCoursesSearchLoadedState extends StudentSearchCourseState{
  final List<Course> courses;

  GetAllSearchCoursesSearchLoadedState({required this.courses});

  @override
  List<Object> get props => [courses];
}
class AddStudentToCourseLoadingState extends StudentSearchCourseState{}
class GetAllCoursesSearchLoadingState extends StudentSearchCourseState{}
class GetAllCoursesSearchMessageErrorState extends StudentSearchCourseState{
  final String message;

  GetAllCoursesSearchMessageErrorState({required this.message});

  @override
  List<Object> get props => [message];
}