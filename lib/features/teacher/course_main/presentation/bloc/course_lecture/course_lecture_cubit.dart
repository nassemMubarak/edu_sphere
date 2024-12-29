import 'package:bloc/bloc.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/core/string/failure.dart';
import 'package:edu_sphere/features/teacher/course_main/domain/entities/lecture.dart';
import 'package:edu_sphere/features/teacher/course_main/domain/usecases/lecture_usecase/add_lecture.dart';
import 'package:edu_sphere/features/teacher/course_main/domain/usecases/lecture_usecase/delete_lecture.dart';
import 'package:edu_sphere/features/teacher/course_main/domain/usecases/lecture_usecase/get_all_lecture.dart';
import 'package:edu_sphere/features/teacher/course_main/domain/usecases/lecture_usecase/update_lecture.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';

part 'course_lecture_state.dart';

class CourseLectureCubit extends Cubit<CourseLectureState> {
  final GetAllLectureUseCase getAllLectureUseCase;
  final AddLectureUseCase addLectureUseCase;
  final DeleteLectureUseCase deleteLectureUseCase;
  final UpdateLectureUseCase updateLectureUseCase;
  CourseLectureCubit({required this.getAllLectureUseCase,required this.updateLectureUseCase,required this.deleteLectureUseCase,required this.addLectureUseCase}) : super(CourseLectureInitial());
  TextEditingController lectureTitleTextEditionController =
  TextEditingController();
  TextEditingController lectureLinkTextEditionController =
  TextEditingController();
  TextEditingController lectureDescriptionTextEditionController =
  TextEditingController();
  final globalLectureKey = GlobalKey<FormState>();
  List<Lecture> lectureList=[];
 late String linkVideo;
  /// get all lecture
  emitGetAllLecture({required int idCourse})async{
    emit(GetAllLectureLoadingState());
    final failureOrAdvertisement = await getAllLectureUseCase(idCourse:idCourse);
    failureOrAdvertisement.fold((failure)=>emit(LectureMessageErrorState(message: _mapFailureMessage(failure: failure))), (lectures){
      Logger().d(lectures);
      lectureList = lectures;
      emit(GetAllLectureLoadedState(lecture: lectureList));
    }) ;
  }
  /// add lecture
  emitAddLecture({required int idCourse})async{
    emit(AddOrUpdateOrDeleteLectureLoadingState());
    final failureOrAdvertisement = await addLectureUseCase(idCourse: idCourse,data:{
      'title':lectureTitleTextEditionController.text,
      'content':lectureLinkTextEditionController.text,
      'description':lectureDescriptionTextEditionController.text,
    } );
    failureOrAdvertisement.fold((failure)=>emit(LectureMessageErrorState(message: _mapFailureMessage(failure: failure))), (lecture){
      Logger().d(lecture);
      lectureList.add(lecture);
      lectureTitleTextEditionController = TextEditingController();
      lectureLinkTextEditionController = TextEditingController();
      lectureDescriptionTextEditionController = TextEditingController();
      emit(GetAllLectureLoadedState(lecture: lectureList));
    }) ;
  }
  /// update lecture
  emitUpdateLecture({required int idCourse,required int idLecture,required int indexLecture})async{
    emit(AddOrUpdateOrDeleteLectureLoadingState());
    final failureOrAdvertisement = await updateLectureUseCase(idLecture: idLecture,idCourse:idCourse ,data:{
      'title':lectureTitleTextEditionController.text,
      'content':lectureLinkTextEditionController.text,
      'description':lectureDescriptionTextEditionController.text,
    });
    failureOrAdvertisement.fold((failure)=>emit(LectureMessageErrorState(message: _mapFailureMessage(failure: failure))), (unit){
      lectureList[indexLecture].title = lectureTitleTextEditionController.text;
      lectureList[indexLecture].link = lectureLinkTextEditionController.text;
      lectureList[indexLecture].description = lectureDescriptionTextEditionController.text;
      lectureTitleTextEditionController = TextEditingController();
      lectureLinkTextEditionController = TextEditingController();
      lectureDescriptionTextEditionController = TextEditingController();
      emit(GetAllLectureLoadedState(lecture: lectureList));
    }) ;
  }
  /// Delete Lecture
  emitDeleteLecture({required int idCourse,required int idLecture,required int indexLecture})async{
    emit(AddOrUpdateOrDeleteLectureLoadingState());
    final failureOrAdvertisement = await deleteLectureUseCase(idCourse: idCourse,idLecture: idLecture);
    failureOrAdvertisement.fold((failure)=>emit(LectureMessageErrorState(message: _mapFailureMessage(failure: failure))), (unit){
      lectureList.remove(lectureList[indexLecture]);
      emit(GetAllLectureLoadedState(lecture: lectureList));
    }) ;

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
