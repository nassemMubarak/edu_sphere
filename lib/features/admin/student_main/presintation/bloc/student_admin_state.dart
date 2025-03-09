part of 'student_admin_cubit.dart';

@immutable
sealed class StudentAdminState {}

final class StudentAdminInitial extends StudentAdminState {}
final class GetInformationStudentLoadingState extends StudentAdminState{}
final class GetInformationStudentLoadedDataState extends StudentAdminState{
  StudentInformationModel studentInformation;
  GetInformationStudentLoadedDataState({required this.studentInformation});
}
final class ErrorMessageGetInformationStudentState extends StudentAdminState{
  String message;
  ErrorMessageGetInformationStudentState({required this.message});
}
