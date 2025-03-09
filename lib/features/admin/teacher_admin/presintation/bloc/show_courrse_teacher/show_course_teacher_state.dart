part of 'show_course_teacher_cubit.dart';

@immutable
sealed class ShowCourseTeacherState {}

final class ShowCourseTeacherInitial extends ShowCourseTeacherState {}

final class TeacherAdminInitial extends ShowCourseTeacherState {}
final class ShowCourseTeacherLoadingState extends ShowCourseTeacherState{}
final class ShowCourseTeacherLoadedDataState extends ShowCourseTeacherState{
  ShowCourseTeacher showCourseTeacher;
  ShowCourseTeacherLoadedDataState({required this.showCourseTeacher});
}
final class ErrorMessageShowCourseTeacherState extends ShowCourseTeacherState{
  String message;
  ErrorMessageShowCourseTeacherState({required this.message});
}
