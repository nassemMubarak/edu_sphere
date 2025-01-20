part of 'show_student_teacher_cubit.dart';

@immutable
sealed class ShowStudentTeacherState {}

final class ShowStudentTeacherInitial extends ShowStudentTeacherState {}
class GetAllStudentTeacherLoadedState extends ShowStudentTeacherState{
  final List<User> listTeacherToStudent;
  GetAllStudentTeacherLoadedState({required this.listTeacherToStudent});
}
class GetAllStudentTeacherLoadingState extends ShowStudentTeacherState{}
class ShowStudentTeacherLoadedState extends ShowStudentTeacherState{
  final ShowStudentTeacher showStudentTeacher;
  ShowStudentTeacherLoadedState({required this.showStudentTeacher});
}

class ShowStudentTeacherLoadingState extends ShowStudentTeacherState{}
class ErrorStudentTeacherState extends ShowStudentTeacherState{
  final String message;
  ErrorStudentTeacherState({required this.message});
}

