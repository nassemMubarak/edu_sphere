
import 'package:edu_sphere/features/teacher/teacher_main/data/model/courses_model.dart';
import 'package:edu_sphere/features/teacher/teacher_main/domain/entities/course.dart';
import 'package:freezed_annotation/freezed_annotation.dart';


// @freezed
// class TeacherMainState {
//   const factory TeacherMainState.initial() = _Initial;
//   const factory TeacherMainState.addCourse(List<CoursesModel> courses) = addCouseState;
//   const factory TeacherMainState.addCourse1(List<CoursesModel> courses) = addCouseState1;
//   const factory TeacherMainState.changCourseType(String type) = changCourseType;
// }

@immutable
sealed class TeacherMainState {}

final class TeacherMainInitial extends TeacherMainState {}
final class AddCourseState extends TeacherMainState {
  List<Course> courses;
  AddCourseState(this.courses);
}
final class AddCourseState1 extends TeacherMainState {
  List<Course> courses;
  AddCourseState1(this.courses);
}
final class ChangCourseType extends TeacherMainState {
  String type;
  ChangCourseType(this.type);
}
class GetAllCoursesLoadedState extends TeacherMainState{
  final List<Course> courses;

  GetAllCoursesLoadedState({required this.courses});

  @override
  List<Object> get props => [courses];
}
class TeacherMainLoadingState extends TeacherMainState{}
class AddOrUpdateOrDeleteCourseLoadingState extends TeacherMainState{}
class TeacherMainMessageSuccessState extends TeacherMainState{
  final String message;

  TeacherMainMessageSuccessState({required this.message});

  @override
  List<Object> get props => [message];
}
class AddOrUpdateOrDeleteMessageSuccessState extends TeacherMainState{
  final String message;

  AddOrUpdateOrDeleteMessageSuccessState({required this.message});

  @override
  List<Object> get props => [message];
}
class TeacherMainMessageErrorState extends TeacherMainState{
  final String message;

  TeacherMainMessageErrorState({required this.message});

  @override
  List<Object> get props => [message];
}



