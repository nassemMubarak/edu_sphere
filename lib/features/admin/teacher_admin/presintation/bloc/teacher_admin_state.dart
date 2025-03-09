part of 'teacher_admin_cubit.dart';

@immutable
sealed class TeacherAdminState {}

final class TeacherAdminInitial extends TeacherAdminState {}
final class GetInformationTeacherLoadingState extends TeacherAdminState{}
final class GetInformationTeacherLoadedDataState extends TeacherAdminState{
  TeacherInformation teacherInformation;
  GetInformationTeacherLoadedDataState({required this.teacherInformation});
}
final class ErrorMessageGetInformationTeacherState extends TeacherAdminState{
  String message;
  ErrorMessageGetInformationTeacherState({required this.message});
}
