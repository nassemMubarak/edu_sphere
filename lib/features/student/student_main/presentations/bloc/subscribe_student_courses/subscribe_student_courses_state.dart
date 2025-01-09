part of 'subscribe_student_courses_cubit.dart';

@immutable
sealed class SubscribeStudentCoursesState {}

final class SubscribeStudentCoursesInitial extends SubscribeStudentCoursesState {}
class GetAllStudentSubscribeCoursesLoadedState extends SubscribeStudentCoursesState{
  final List<Course> courses;

  GetAllStudentSubscribeCoursesLoadedState({required this.courses});

  @override
  List<Object> get props => [courses];
}
class GetAllStudentSubscribeCoursesLoadingState extends SubscribeStudentCoursesState{}
class LeaveStudentSubscribeCoursesLoadingState extends SubscribeStudentCoursesState{}
class GetAllStudentSubscribeCoursesMessageErrorState extends SubscribeStudentCoursesState{
  final String message;
  GetAllStudentSubscribeCoursesMessageErrorState({required this.message});
  @override
  List<Object> get props => [message];
}