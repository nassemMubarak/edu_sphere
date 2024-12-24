import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/core/string/failure.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/bloc/course_main_cubit.dart';
import 'package:edu_sphere/features/teacher/teacher_main/data/model/courses_model.dart';
import 'package:edu_sphere/features/teacher/teacher_main/domain/entities/course.dart';
import 'package:edu_sphere/features/teacher/teacher_main/domain/usecases/add_course.dart';
import 'package:edu_sphere/features/teacher/teacher_main/domain/usecases/delete_course.dart';
import 'package:edu_sphere/features/teacher/teacher_main/domain/usecases/get_all_courses.dart';
import 'package:edu_sphere/features/teacher/teacher_main/domain/usecases/update_course.dart';
import 'package:edu_sphere/features/teacher/teacher_main/presentation/logic/teacher_main_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class TeacherMainCubit extends Cubit<TeacherMainState> {
  final AddCourseUseCase addCourseUseCase;
  final DeleteCourseUseCase deleteCourseUseCase;
  final GetAllCoursesUseCase getAllCoursesUseCase;
  final UpdateCourseUseCase updateCourseUseCase;

  TeacherMainCubit(
      {required this.addCourseUseCase,
      required this.deleteCourseUseCase,
      required this.getAllCoursesUseCase,
      required this.updateCourseUseCase})
      : super(TeacherMainInitial());

  final globalKey = GlobalKey<FormState>();
  TextEditingController courseNameController = TextEditingController();
  TextEditingController courseDescriptionController = TextEditingController();

  List<Course> coursesModelList = [
    // CoursesModel(
    //     title: 'Flutter',
    //     description:
    //         'Flutter is an open-source UI framework by Google for building natively compiled apps across mobile, web, and desktop from a single codebase.',
    //     isPending: false,
    //     isRejected: false,
    // ),
    // CoursesModel(
    //     title: 'Graduation research',
    //     description: 'Graduation research is course graduation research',
    //     isPending: true,
    //     isRejected: false),
    // CoursesModel(
    //     title: 'Software Security',
    //     description: 'software security software security software security',
    //     isPending: false,
    //     isRejected: true),
  ];

  emitChangCourseType(String courseType) {
    // emit(AddCourseState1(coursesModelList));
    emit(ChangCourseType(courseType));
  }

  emitGetAllCourses() async {
    emit(TeacherMainLoadingState());
    final failureOrCourses = await getAllCoursesUseCase();
    emit(failureOrCourses.fold(
        (failure) => TeacherMainMessageErrorState(
            message: _mapFailureMessage(failure: failure)), (courses) {
      Logger().d(courses);
      coursesModelList = courses;
      return GetAllCoursesLoadedState(courses: courses);
    }));
  }

  void emitAddCourse() async {
    emit(AddOrUpdateOrDeleteCourseLoadingState());
    // emit(AddCourseState1(coursesModelList));
    // coursesModelList.add(
    //   Course(
    //     id: 1,
    //     title: courseNameController.text,
    //     description: courseDescriptionController.text,
    //     isPending: true,
    //     isRejected: false,
    //   ),
    // );
    final failureAddCourse = await addCourseUseCase(courseData: {
      'title': courseNameController.text,
      'description': courseDescriptionController.text
    });
    failureAddCourse.fold( (failure) => emit(AddOrUpdateOrDeleteMessageSuccessState(
        message: _mapFailureMessage(failure: failure))), (course){
      coursesModelList.add(course);
      return emit(AddCourseState(coursesModelList));
    });
    courseNameController = TextEditingController();
    courseDescriptionController = TextEditingController();
    // emit(AddCourseState(coursesModelList));
  }

  void emitEditCourse(
      {required int indexCourse, required BuildContext context,required int id}) async{
    // emit(AddCourseState1(coursesModelList));
    // coursesModelList[indexCourse].title = courseNameController.text;
    // coursesModelList[indexCourse].description =
    //     courseDescriptionController.text;
    // context
    //     .read<CourseMainCubit>()
    //     .emitEditCourseDescription(course: coursesModelList[indexCourse]);
    emit(AddOrUpdateOrDeleteCourseLoadingState());
   var body = {
        'title': courseNameController.text,
        'description': courseDescriptionController.text
    };
    Logger().e(body);
    final failureAddCourse = await updateCourseUseCase(courseData: body,id: id);
    failureAddCourse.fold( (failure) => emit(AddOrUpdateOrDeleteMessageSuccessState(
        message: _mapFailureMessage(failure: failure))), (unit){
      coursesModelList[indexCourse].title = courseNameController.text;
      coursesModelList[indexCourse].description = courseDescriptionController.text;
      context
          .read<CourseMainCubit>()
          .emitEditCourseDescription(course: coursesModelList[indexCourse]);
      return emit(AddCourseState(coursesModelList));
    });
    courseNameController = TextEditingController();
    courseDescriptionController = TextEditingController();
    // emit(AddCourseState(coursesModelList));
  }

  void emitDeleteCourse({required int indexCourse,required int courseId}) async{
    // emit(AddCourseState1(coursesModelList));
    //
    // coursesModelList.remove(coursesModelList[indexCourse]);
    //
    // courseNameController = TextEditingController();
    // courseDescriptionController = TextEditingController();
    // emit(AddCourseState(coursesModelList));
    emit(AddOrUpdateOrDeleteCourseLoadingState());
    final failureAddCourse = await deleteCourseUseCase(id: courseId);
    failureAddCourse.fold( (failure) => emit(AddOrUpdateOrDeleteMessageSuccessState(
        message: _mapFailureMessage(failure: failure))), (unit){
      coursesModelList.remove(coursesModelList[indexCourse]);
      return emit(AddCourseState(coursesModelList));
    });
  }

  String _mapFailureMessage({required Failure failure}) {
    switch (failure.runtimeType) {
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      case EmptyCacheFailure:
        return CACHE_FAILURE_MESSAGE;
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case InvalidDataFailure:
        return INVALID_DATA_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error, Please try again later .';
    }
  }
}
