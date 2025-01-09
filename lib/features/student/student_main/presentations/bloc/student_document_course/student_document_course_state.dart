part of 'student_document_course_cubit.dart';

@immutable
sealed class StudentDocumentCourseState {}

final class StudentDocumentCourseInitial extends StudentDocumentCourseState {}
class GetAllStudentDocumentToCourseLoadedState extends StudentDocumentCourseState{
  final List<DocumentAssessment> documents;

  GetAllStudentDocumentToCourseLoadedState({required this.documents});

  @override
  List<Object> get props => [documents];
}
class GetAllStudentDocumentToCourseLoadingState extends StudentDocumentCourseState{}
class GetAllStudentDocumentToCourseMessageErrorState extends StudentDocumentCourseState{
  final String message;

  GetAllStudentDocumentToCourseMessageErrorState({required this.message});

  @override
  List<Object> get props => [message];
}