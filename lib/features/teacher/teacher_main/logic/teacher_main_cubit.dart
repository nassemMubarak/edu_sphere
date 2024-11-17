import 'package:edu_sphere/features/teacher/teacher_main/data/model/courses_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:edu_sphere/features/teacher/teacher_main/logic/teacher_main_state.dart';

class TeacherMainCubit extends Cubit<TeacherMainState> {
  final globalKey = GlobalKey<FormState>();
  TextEditingController courseNameController = TextEditingController();
  String? courseType = 'Paid';

  List<CoursesModel> coursesModelList = [
    CoursesModel(
      title: 'Graduation research',
      subTitle: 'paid',
    ),
    CoursesModel(
      title: 'Software Security',
      subTitle: 'Free',
    ),
  ];
  TeacherMainCubit() : super(const TeacherMainState.initial());
  void emitAddCourse() {
    emit(addCouseState1(coursesModelList));
    coursesModelList.add(
      CoursesModel(
        title: courseNameController.text,
        subTitle: courseType!,
      ),
    );
    courseNameController = TextEditingController();
    emit(addCouseState(coursesModelList));
  }

  void emitEditCourse({required int indexCourse}) {
    emit(addCouseState1(coursesModelList));

    coursesModelList[indexCourse].title = courseNameController.text;
    coursesModelList[indexCourse].subTitle = courseType!;

    courseNameController = TextEditingController();
    emit(addCouseState(coursesModelList));
  }

  void emitDeleteCourse({required int indexCourse}) {
    emit(addCouseState1(coursesModelList));

    coursesModelList.remove(coursesModelList[indexCourse]);
    

    courseNameController = TextEditingController();
    emit(addCouseState(coursesModelList));
  }
}
