part of 'student_assessment_cubit.dart';

@immutable
sealed class StudentAssessmentState {}

final class StudentAssessmentInitial extends StudentAssessmentState {}
class GetAllStudentAssessmentLoadingState extends StudentAssessmentState{}
class GetDocumentSubmitAssessmentLoadingState extends StudentAssessmentState{}
class GetDocumentSubmitAssessmentLoadedState extends StudentAssessmentState{
  final DocumentStudentAssessment? documentAssessment;
  GetDocumentSubmitAssessmentLoadedState({required this.documentAssessment});
}
class AddOrDeleteDocumentSubmitAssessmentLoadingState extends StudentAssessmentState{}
class GetAllStudentAssessmentLoadedState extends StudentAssessmentState{
  final List<Assessment> listAssessment;

  GetAllStudentAssessmentLoadedState({required this.listAssessment});

  @override
  List<Object> get props => [listAssessment];
}
class ShowStudentAssessmentLoadingState extends StudentAssessmentState{}
class ShowStudentAssessmentLoadedState extends StudentAssessmentState{
  final Assessment assessment;

  ShowStudentAssessmentLoadedState({required this.assessment});

  @override
  List<Object> get props => [assessment];
}
class ErrorMessageGetDocumentSubmitAssessmentState extends StudentAssessmentState{
  final String message;
  ErrorMessageGetDocumentSubmitAssessmentState({required this.message});
}
class ErrorMessageStudentAssessment extends StudentAssessmentState{
  final String message;
  ErrorMessageStudentAssessment({required this.message});
}