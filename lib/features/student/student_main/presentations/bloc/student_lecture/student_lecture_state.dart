part of 'student_lecture_cubit.dart';

@immutable
sealed class StudentLectureState {}

final class StudentLectureInitial extends StudentLectureState {}
class GetAllStudentLecturesLoadedState extends StudentLectureState{
  final List<Lecture> lecture;

  GetAllStudentLecturesLoadedState({required this.lecture});

  @override
  List<Object> get props => [lecture];
}
class GetAllStudentLecturesLoadingState extends StudentLectureState{}
class GetAllStudentLecturesMessageErrorState extends StudentLectureState{
  final String message;

  GetAllStudentLecturesMessageErrorState({required this.message});

  @override
  List<Object> get props => [message];
}