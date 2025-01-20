import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/core/string/failure.dart';
import 'package:edu_sphere/features/student/assessment_student/domain/entities/document_student_assessment.dart';
import 'package:edu_sphere/features/student/assessment_student/domain/usecases/delete_submit_student_document_to_assessment.dart';
import 'package:edu_sphere/features/student/assessment_student/domain/usecases/get_all_student_assessment.dart';
import 'package:edu_sphere/features/student/assessment_student/domain/usecases/get_all_submit_student_document_to_assessment.dart';
import 'package:edu_sphere/features/student/assessment_student/domain/usecases/show_student_assessment.dart';
import 'package:edu_sphere/features/student/assessment_student/domain/usecases/submit_student_document_to_assessment.dart';
import 'package:edu_sphere/features/teacher/assessments/domain/entities/assessment.dart';
import 'package:edu_sphere/features/teacher/assessments/domain/entities/document_assessment.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';

part 'student_assessment_state.dart';

class StudentAssessmentCubit extends Cubit<StudentAssessmentState> {
  final DeleteSubmitStudentDocumentToAssessmentUseCase deleteSubmitStudentDocumentToAssessmentUseCase;
  final GetAllStudentAssessmentUseCase getAllStudentAssessmentUseCase;
  final  ShowStudentAssessmentUseCase showStudentAssessmentUseCase;
  final SubmitStudentDocumentToAssessmentUseCase submitStudentDocumentToAssessmentUseCase;
  final GetAllSubmitStudentDocumentToAssessmentUseCase getAllSubmitStudentDocumentToAssessmentUseCase;
  StudentAssessmentCubit({
    required this.deleteSubmitStudentDocumentToAssessmentUseCase,
    required this.getAllStudentAssessmentUseCase,
    required this.submitStudentDocumentToAssessmentUseCase,
    required this.showStudentAssessmentUseCase,
    required this.getAllSubmitStudentDocumentToAssessmentUseCase,
}) : super(StudentAssessmentInitial());
  List<Assessment> listAssessment = [];
  int indexAssessmentSelected = 0;
  Assessment? selectedAssessment;
  /// emit get all assessment
  emitGetAllAssessment({required int idCourse})async{
    emit(GetAllStudentAssessmentLoadingState());
    final failureOrAdvertisement = await getAllStudentAssessmentUseCase(idCourse:idCourse);
    failureOrAdvertisement.fold((failure)=>emit(ErrorMessageStudentAssessment(message: _mapFailureMessage(failure: failure))),
            (assessments){
          Logger().d('assessments  list ---->   $assessments');
          listAssessment = assessments;
          emit(GetAllStudentAssessmentLoadedState(listAssessment: listAssessment));
        });
  }
  emitShowAssessment({required int idCourse,required int idAssessment})async{
    emit(ShowStudentAssessmentLoadingState());
    final failureOrAdvertisement = await showStudentAssessmentUseCase(idCourse:idCourse,idAssessment: idAssessment);
    failureOrAdvertisement.fold((failure)=>emit(ErrorMessageStudentAssessment(message: _mapFailureMessage(failure: failure))),
            (assessments){
          Logger().d('assessments  list ---->   $assessments');
          selectedAssessment = assessments;
          emit(ShowStudentAssessmentLoadedState(assessment: selectedAssessment!));
        });
  }
  DocumentStudentAssessment? documentAssessment;
  emitGetAllSubmitStudentAssessment({required int idCourse,required int idAssessment})async{
    emit(GetDocumentSubmitAssessmentLoadingState());
    final failureOrAdvertisement = await getAllSubmitStudentDocumentToAssessmentUseCase(idCourse:idCourse,idAssessment: idAssessment);
    failureOrAdvertisement.fold((failure){
          Logger().e('documentAssessment==-----------------------');
          documentAssessment=null;
      emit(ErrorMessageGetDocumentSubmitAssessmentState(message: _mapFailureMessage(failure: failure)));
    },
            (document){
          Logger().d('assessments  list ---->   $document');
          documentAssessment = document;
          Logger().e('documentAssessment==-----------------------$document');
          emit(GetDocumentSubmitAssessmentLoadedState(documentAssessment: documentAssessment!));
        });
  }
  emitSubmitStudentAssessment({required int idCourse,required int idAssessment,required List<File> files})async{
    emit(AddOrDeleteDocumentSubmitAssessmentLoadingState());
    final failureOrDocuments = await submitStudentDocumentToAssessmentUseCase(idAssessment: idAssessment,idCourse: idCourse,files: files);
    failureOrDocuments.fold((failure)=>emit(ErrorMessageGetDocumentSubmitAssessmentState(message: _mapFailureMessage(failure: failure))), (documents){
      documentAssessment = documents;
      emit(GetDocumentSubmitAssessmentLoadedState(documentAssessment: documentAssessment!));

    }
    );
  }
  emitDeleteSubmitStudentAssessment({required int idCourse,required int idAssessment})async{
    emit(AddOrDeleteDocumentSubmitAssessmentLoadingState());
    final failureOrDocuments = await deleteSubmitStudentDocumentToAssessmentUseCase(idAssessment: idAssessment,idCourse: idCourse);
      failureOrDocuments.fold((failure)=>emit(ErrorMessageGetDocumentSubmitAssessmentState(message: _mapFailureMessage(failure: failure))), (unit){
        documentAssessment = null;
      emit(GetDocumentSubmitAssessmentLoadedState(documentAssessment: documentAssessment));
    }
    );
  }

  String _mapFailureMessage({required Failure failure}) {
    switch (failure.runtimeType) {
      case InvalidDataFailureMessage:
        return failure.message??'';
       case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      case EmptyCacheFailure:
        return CACHE_FAILURE_MESSAGE;
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case InvalidDataFailure:
        Logger().f('failure---------------------------------$failure');
        return INVALID_DATA_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error, Please try again later .';
    }
  }
}
