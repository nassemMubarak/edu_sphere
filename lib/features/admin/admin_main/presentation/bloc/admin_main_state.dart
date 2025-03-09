part of 'admin_main_cubit.dart';

@immutable
sealed class AdminMainState {}

final class AdminMainInitial extends AdminMainState {}
 class GetAllTeacherInAdminLoadingState extends AdminMainState{}
 class GetAllTeacherInAdminLoadedState extends AdminMainState{
  final List<User> listTeacher;
  GetAllTeacherInAdminLoadedState({required this.listTeacher});
 }
class ErrorMessageGetAllTeacherInAdminState extends AdminMainState{
  final String message;
  ErrorMessageGetAllTeacherInAdminState({required this.message});
}
