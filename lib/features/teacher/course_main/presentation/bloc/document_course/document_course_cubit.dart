import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:edu_sphere/features/teacher/assessments/domain/entities/document_assessment.dart';
import 'package:edu_sphere/features/teacher/course_main/domain/usecases/document_to_course/add_document_to_course.dart';
import 'package:edu_sphere/features/teacher/course_main/domain/usecases/document_to_course/delete_document_to_course.dart';
import 'package:edu_sphere/features/teacher/course_main/domain/usecases/document_to_course/dwonload_document_to_course.dart';
import 'package:edu_sphere/features/teacher/course_main/domain/usecases/document_to_course/get_all_document_to_course.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';

import '../../../../../../core/error/failure.dart';
import '../../../../../../core/string/failure.dart';

part 'document_course_state.dart';

class DocumentCourseCubit extends Cubit<DocumentCourseState> {
  final GetAllDocumentToCourseUseCase getAllDocumentToCourseUseCase;
  final AddDocumentToCourseUseCase addDocumentToCourseUseCase;
  final DeleteDocumentToCourseUseCase deleteDocumentToCourseUseCase;
  final DownloadDocumentToCourseUseCase downloadDocumentToCourseUseCase;
  DocumentCourseCubit({
    required this.getAllDocumentToCourseUseCase,
    required this.addDocumentToCourseUseCase,
    required this.downloadDocumentToCourseUseCase,
    required this.deleteDocumentToCourseUseCase,

}) : super(DocumentCourseInitial());
  List<DocumentAssessment> listDocumentToCourse=[];
  /// emit get all document to course
  emitGetAllDocumentToCourse({required int idCourse})async{
    emit(GetAllLectureLoadingState());
    final failureOrDocuments = await getAllDocumentToCourseUseCase(idCourse: idCourse);
    failureOrDocuments.fold((failure)=>emit(DocumentMessageErrorState(message: _mapFailureMessage(failure: failure))), (documents){
      listDocumentToCourse = documents;
      Logger().f('listDocumentToCourse------------------->$listDocumentToCourse');
      emit(GetAllDocumentLoadedState(listDocument: listDocumentToCourse));
    });
  }

  /// emit add document to course
  emitAddDocumentToAssessment({required int idCourse,required List<File> files})async{
    emit(AddOrDeleteDocumentLoadingState());
    final failureOrDocuments = await addDocumentToCourseUseCase(idCourse: idCourse,files: files);
    failureOrDocuments.fold((failure)=>emit(DocumentMessageErrorState(message: _mapFailureMessage(failure: failure))), (documents){
      Logger().f('listDocumentToCourse------------------->$listDocumentToCourse');
      listDocumentToCourse.addAll(documents);
      emit(GetAllDocumentLoadedState(listDocument: listDocumentToCourse));
    });
  }

  /// emit delete document to course
  emitDeleteDocumentToCourse({required int idCourse,required DocumentAssessment document})async{
    emit(AddOrDeleteDocumentLoadingState());
    final failureOrDocuments = await deleteDocumentToCourseUseCase(idCourse: idCourse,idDocument: document.id);
    failureOrDocuments.fold((failure)=>emit(DocumentMessageErrorState(message: _mapFailureMessage(failure: failure))), (unit){
      listDocumentToCourse.remove(document);
      Logger().f('listDocumentToCourse--------Delete Success----------->');
      emit(GetAllDocumentLoadedState(listDocument: listDocumentToCourse));
    });
  }
  /// emit delete document to course
  emitDownloadDocumentToAssessment({required int idCourse,required int idDocument})async{
    emit(AddOrDeleteDocumentLoadingState());
    final failureOrDocuments = await downloadDocumentToCourseUseCase(idCourse: idCourse,idDocument: idDocument);
    failureOrDocuments.fold((failure)=>emit(DocumentMessageErrorState(message: _mapFailureMessage(failure: failure))), (unit){
      Logger().f('listDocumentToCourse--------Downloaded Success----------->');
      emit(GetAllDocumentLoadedState(listDocument: listDocumentToCourse));
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
