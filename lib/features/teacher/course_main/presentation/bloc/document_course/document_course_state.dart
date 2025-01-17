part of 'document_course_cubit.dart';

@immutable
sealed class DocumentCourseState {}

final class DocumentCourseInitial extends DocumentCourseState {}
class GetAllLectureLoadingState extends DocumentCourseState{}
class AddOrDeleteDocumentLoadingState extends DocumentCourseState{}
class GetAllDocumentLoadedState extends DocumentCourseState{
  final List<DocumentAssessment> listDocument;

  GetAllDocumentLoadedState({required this.listDocument});

  @override
  List<Object> get props => [listDocument];
}
class AddOrDeleteDocumentSuccessState extends DocumentCourseState{
  final String message;

  AddOrDeleteDocumentSuccessState({required this.message});

  @override
  List<Object> get props => [message];
}
class DocumentMessageErrorState extends DocumentCourseState{
  final String message;

  DocumentMessageErrorState({required this.message});

  @override
  List<Object> get props => [message];
}