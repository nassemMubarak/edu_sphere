import 'package:edu_sphere/features/teacher/course_main/presentation/bloc/course_main_cubit.dart';
import 'package:edu_sphere/features/teacher/teacher_main/data/model/courses_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:edu_sphere/features/teacher/teacher_main/logic/teacher_main_state.dart';

class TeacherMainCubit extends Cubit<TeacherMainState> {
  final globalKey = GlobalKey<FormState>();
  TextEditingController courseNameController = TextEditingController();
  TextEditingController courseDescriptionController = TextEditingController();

  List<CoursesModel> coursesModelList = [
    CoursesModel(
        title: 'Flutter',
        description: 'Flutter is an open-source UI framework by Google for building natively compiled apps across mobile, web, and desktop from a single codebase.',
        isPending: false,
        isRejected: false
    ),
    CoursesModel(
      title: 'Graduation research',
      description: 'Graduation research is course graduation research',
      isPending: true,
      isRejected: false
    ),
    CoursesModel(
      title: 'Software Security',
      description: 'software security software security software security',
      isPending: false,
      isRejected: true
    ),
  ];
  emitChangCourseType(String courseType){
    emit(addCouseState1(coursesModelList));
    emit(changCourseType(courseType));
  }
  TeacherMainCubit() : super(const TeacherMainState.initial());
  void emitAddCourse() {
    emit(addCouseState1(coursesModelList));
    coursesModelList.add(
      CoursesModel(
        title: courseNameController.text,
        description: courseDescriptionController.text,
        isPending: true,
        isRejected: false
      ),
    );
    courseNameController = TextEditingController();
    courseDescriptionController = TextEditingController();
    emit(addCouseState(coursesModelList));
  }

  void emitEditCourse({required int indexCourse,required BuildContext context}) {
    emit(addCouseState1(coursesModelList));
    coursesModelList[indexCourse].title = courseNameController.text;
    coursesModelList[indexCourse].description = courseDescriptionController.text;
    context.read<CourseMainCubit>().emitEditCourseDescription(course: coursesModelList[indexCourse]);

    courseNameController = TextEditingController();
    courseDescriptionController = TextEditingController();
    emit(addCouseState(coursesModelList));
  }

  void emitDeleteCourse({required int indexCourse}) {
    emit(addCouseState1(coursesModelList));

    coursesModelList.remove(coursesModelList[indexCourse]);
    

    courseNameController = TextEditingController();
    courseDescriptionController = TextEditingController();
    emit(addCouseState(coursesModelList));
  }
}
