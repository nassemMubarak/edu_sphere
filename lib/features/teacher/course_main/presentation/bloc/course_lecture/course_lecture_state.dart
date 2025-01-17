part of 'course_lecture_cubit.dart';

@immutable
sealed class CourseLectureState {}

final class CourseLectureInitial extends CourseLectureState {}
class GetAllLectureLoadingState extends CourseLectureState{}
class AddOrUpdateOrDeleteLectureLoadingState extends CourseLectureState{}
class GetAllLectureLoadedState extends CourseLectureState{
  final List<Lecture> lecture;

  GetAllLectureLoadedState({required this.lecture});

  @override
  List<Object> get props => [lecture];
}
class AddOrUpdateOrDeleteLectureSuccessState extends CourseLectureState{
  final String message;

  AddOrUpdateOrDeleteLectureSuccessState({required this.message});

  @override
  List<Object> get props => [message];
}
class LectureMessageErrorState extends CourseLectureState{
  final String message;

  LectureMessageErrorState({required this.message});

  @override
  List<Object> get props => [message];
}