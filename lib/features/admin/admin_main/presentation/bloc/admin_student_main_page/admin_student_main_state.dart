part of 'admin_student_main_cubit.dart';

@immutable
sealed class AdminStudentMainState {}

final class AdminStudentMainInitial extends AdminStudentMainState {}
class GetAllStudentInAdminLoadingState extends AdminStudentMainState{}
class GetAllStudentInAdminLoadedState extends AdminStudentMainState{
  final List<User> listStudent;
  GetAllStudentInAdminLoadedState({required this.listStudent});
}
class ErrorMessageGetAllStudentInAdminState extends AdminStudentMainState{
  final String message;
  ErrorMessageGetAllStudentInAdminState({required this.message});
}