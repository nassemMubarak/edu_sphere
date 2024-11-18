
import 'package:edu_sphere/features/teacher/teacher_main/data/model/courses_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'teacher_main_state.freezed.dart';

@freezed
class TeacherMainState with _$TeacherMainState {
  const factory TeacherMainState.initial() = _Initial;
  const factory TeacherMainState.addCourse(List<CoursesModel> courses) = addCouseState;
  const factory TeacherMainState.addCourse1(List<CoursesModel> courses) = addCouseState1;
  const factory TeacherMainState.changCourseType(String type) = changCourseType;
}
