import 'dart:io';

import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/core/string/failure.dart';
import 'package:edu_sphere/features/teacher/assessments/data/models/EstimateAssessmentModel.dart';
import 'package:edu_sphere/features/teacher/assessments/domain/entities/assessment.dart';
import 'package:edu_sphere/features/teacher/assessments/domain/entities/assessment1.dart';
import 'package:edu_sphere/features/teacher/assessments/domain/entities/estimate_assessment.dart';
import 'package:edu_sphere/features/teacher/assessments/domain/usecases/add_assessment.dart';
import 'package:edu_sphere/features/teacher/assessments/domain/usecases/add_document_to_assessment.dart';
import 'package:edu_sphere/features/teacher/assessments/domain/usecases/add_estimate_assessment.dart';
import 'package:edu_sphere/features/teacher/assessments/domain/usecases/delete_assessment.dart';
import 'package:edu_sphere/features/teacher/assessments/domain/usecases/delete_document_to_assessment.dart';
import 'package:edu_sphere/features/teacher/assessments/domain/usecases/download_document_to_assessment.dart';
import 'package:edu_sphere/features/teacher/assessments/domain/usecases/get_all_assessment.dart';
import 'package:edu_sphere/features/teacher/assessments/domain/usecases/get_all_estimate_assessment.dart';
import 'package:edu_sphere/features/teacher/assessments/domain/usecases/update_assessment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

part 'assessments_state.dart';

class AssessmentsCubit extends Cubit<AssessmentsState> {
  final GetAllAssessmentUseCase getAllAssessmentUseCase;
  final AddAssessmentUseCase addAssessmentUseCase;
  final DeleteAssessmentUseCase deleteAssessmentUseCase;
  final UpdateAssessmentUseCase updateAssessmentUseCase;
  final AddDocumentToAssessmentUseCase addDocumentToAssessmentUseCase;
  final DeleteDocumentToAssessmentUseCase deleteDocumentToAssessmentUseCase;
  final DownloadDocumentToAssessmentUseCase downloadDocumentToAssessmentUseCase;
  final GetAllEstimateAssessmentUseCase getAllEstimateAssessmentUseCase;
  final AddEstimateAssessmentUseCase addEstimateAssessmentUseCase;
  AssessmentsCubit({
    required this.updateAssessmentUseCase,
    required this.getAllAssessmentUseCase,
    required this.addAssessmentUseCase,
    required this.deleteAssessmentUseCase,
    required this.addDocumentToAssessmentUseCase,
    required this.deleteDocumentToAssessmentUseCase,
    required this.downloadDocumentToAssessmentUseCase,
    required this.getAllEstimateAssessmentUseCase,
    required this.addEstimateAssessmentUseCase,
}) : super(AssessmentsInitial());
  Assessment? assessment;
  EstimateAssessment? estimateAssessmentSelected;
  int? indexEstimateAssessmentSelected;
  int? indexAssessmentSelected;
  bool isHideEstimationAssessment = false;
  List<Assessment> listAssessment = [];
  List<EstimateAssessment> listEstimateAssessment=[];
  ///  Get All Estimate AssessmentUseCase
  emitGetAllEstimateAssessment({required int idCourse,required int idAssessment})async{
    emit(GetAllEstimateAssessmentLoadingState());
    final failureOrAdvertisement = await getAllEstimateAssessmentUseCase(idAssessment: idAssessment,idCourse: idCourse);
    failureOrAdvertisement.fold((failure)=>emit(ErrorMessageAssessment(message: _mapFailureMessage(failure: failure))),
            (listEstimate){
          Logger().d('listEstimate  list ---->   $listEstimate');
          listEstimateAssessment = listEstimate;
          emit(GetAllEstimateAssessmentLoadedState(listEstimateAssessment: listEstimateAssessment));
        });
  }
  emitAddEstimateAssessment({required int idCourse,required int idAssessment,required int idStudent,required int mark})async{
    emit(AddEstimateAssessmentLoadingState());
    final failureOrAdvertisement = await addEstimateAssessmentUseCase(idCourse: idCourse,idAssessment: idAssessment,idStudent: idStudent,mark:mark );
    failureOrAdvertisement.fold((failure)=>emit(ErrorMessageEstimateAssessment(message: _mapFailureMessage(failure: failure))),
            (unit){
              emitGetAllEstimateAssessment(idCourse: idCourse, idAssessment: idAssessment);
          Logger().d('listEstimsssssssssssdddddddddddddddddddcffffffffffffffffff');
        emit(AddSucssessEstimateAssessmentLoadingState());});

  }
  emitIsHideEstimationAssessment(bool isHide){
    isHideEstimationAssessment = isHide;
    emit(IsHideEstimationAssessment(isHide: isHide));

  }
  /// emit get all assessment
  emitGetAllAssessment({required int idCourse})async{
    emit(GetAllAssessmentLoadingState());
    final failureOrAdvertisement = await getAllAssessmentUseCase(idCourse:idCourse);
    failureOrAdvertisement.fold((failure)=>emit(ErrorMessageAssessment(message: _mapFailureMessage(failure: failure))),
            (assessments){
          Logger().d('assessments  list ---->   $assessments');
          listAssessment = assessments;
          emit(GetAllAssessmentLoadedState(listAssessment: listAssessment));
        });
  }
  /// emit add assessment
  emitAddAssessment({required int idCourse})async{
    emit(AddOrUpdateOrDeleteAssessmentLoadingState());
    final failureOrAdvertisement = await addAssessmentUseCase(idCourse: idCourse,data:{
      'title':assessmentTitleTextEditionController.text,
      'description':assessmentDescriptionTextEditionController.text,
      'degree':assessmentScoreTextEditionController.text,
      'visibility':'0',
      'start_in':startDateTimeAssessment.toString(),
      'end_in':endDateTimeAssessment.toString(),
    } );
    failureOrAdvertisement.fold((failure)=>emit(ErrorMessageAssessment(message: _mapFailureMessage(failure: failure))), (assessment){
      Logger().d('add assessment --> ${assessment}');
      assessmentTitleTextEditionController = TextEditingController();

      assessmentDescriptionTextEditionController = TextEditingController();

      assessmentScoreTextEditionController = TextEditingController();

      selectedStartDateAssessment = null;

      selectedEndDateAssessment = null;

      startDateTimeAssessment = null;
      startTime=null;
      endTime=null;
      endDateTimeAssessment = null;
      errorMessageAssessment = null;
      listAssessment.add(assessment);
      emit(GetAllAssessmentLoadedState(listAssessment: listAssessment));
    }) ;
  }
  emitUpdateAssessment({required int idCourse,required int idAssessment})async{
    emit(AddOrUpdateOrDeleteAssessmentLoadingState());
      Logger().f('=----------------->   $isHideEstimationAssessment');
    final failureOrAdvertisement = await updateAssessmentUseCase(idCourse: idCourse,idAssessment: idAssessment,data:{
      'title':assessmentTitleTextEditionController.text,
      'description':assessmentDescriptionTextEditionController.text,
      'degree':assessmentScoreTextEditionController.text,
      'visibility':isHideEstimationAssessment?'1':'0',
      'start_in':startDateTimeAssessment.toString(),
      'end_in':endDateTimeAssessment.toString(),
    } );
    failureOrAdvertisement.fold((failure)=>emit(ErrorMessageAssessment(message: _mapFailureMessage(failure: failure))), (assessment){
      listAssessment[indexAssessmentSelected!].title=assessmentTitleTextEditionController.text;
      listAssessment[indexAssessmentSelected!].description=assessmentDescriptionTextEditionController.text;
      listAssessment[indexAssessmentSelected!].degree=int.parse(assessmentScoreTextEditionController.text);
      listAssessment[indexAssessmentSelected!].visibility=isHideEstimationAssessment;
      listAssessment[indexAssessmentSelected!].startIn=startDateTimeAssessment!;
      listAssessment[indexAssessmentSelected!].endIn=endDateTimeAssessment!;
      assessmentTitleTextEditionController = TextEditingController();

      assessmentDescriptionTextEditionController = TextEditingController();

      assessmentScoreTextEditionController = TextEditingController();

      selectedStartDateAssessment = null;

      selectedEndDateAssessment = null;

      startDateTimeAssessment = null;
      startTime=null;
      endTime=null;
      endDateTimeAssessment = null;
      errorMessageAssessment = null;
      emitSelectAssessments(assessment: listAssessment[indexAssessmentSelected!], indexAssessments: indexAssessmentSelected!);
      emit(GetAllAssessmentLoadedState(listAssessment: listAssessment));
    }) ;

  }
  emitDeleteAssessment({required Assessment assessment,required int idCourse}) async{
    emit(AddOrUpdateOrDeleteAssessmentLoadingState());
    final failureOrAdvertisement = await deleteAssessmentUseCase(idCourse: idCourse,idAssessment: assessment.id);
    failureOrAdvertisement.fold((failure)=>emit(ErrorMessageAssessment(message: _mapFailureMessage(failure: failure))), (unit){
      listAssessment.remove(assessment);
      emit(GetAllAssessmentLoadedState(listAssessment: listAssessment));
    }) ;
  }

  emitUpdateVisibilityAssessment({required int idCourse,required int idAssessment,required bool visibility})async{
    emit(AddOrUpdateOrDeleteAssessmentLoadingState());
    Logger().e('idCourse: $idCourse},idAssessment: $idAssessment,data: --->visibility---->$visibility');
    final failureOrAdvertisement = await updateAssessmentUseCase(idCourse: idCourse,idAssessment: idAssessment,data:{
      'visibility':visibility
    });
    failureOrAdvertisement.fold((failure)=>emit(QuizMessageErrorState(message: _mapFailureMessage(failure: failure))), (quiz){
      listAssessment[indexAssessmentSelected!].visibility = visibility;
      emitSelectAssessments(assessment: listAssessment[indexAssessmentSelected!], indexAssessments: indexAssessmentSelected!);
      emit(GetAllAssessmentLoadedState(listAssessment: listAssessment));
    }) ;
  }
  /// emit add document to assessment
  emitAddDocumentToAssessment({required int idCourse,required int idAssessment,required List<File> files})async{
      Logger().f('$indexAssessmentSelected   listAssessment[indexAssessmentSelected!].title----------------------------${listAssessment[indexAssessmentSelected!].title}');
    emit(AddOrUpdateOrDeleteAssessmentLoadingState());
    final failureOrDocuments = await addDocumentToAssessmentUseCase(idAssessment: idAssessment,idCourse: idCourse,files: files);
    failureOrDocuments.fold((failure)=>emit(ErrorMessageAssessment(message: _mapFailureMessage(failure: failure))), (documents){
      listAssessment[indexAssessmentSelected!].documents!=null?listAssessment[indexAssessmentSelected!].documents!.addAll(documents):listAssessment[indexAssessmentSelected!].documents=documents;
      Logger().f('$indexAssessmentSelected  2222 listAssessment[indexAssessmentSelected!].title----------------------------${listAssessment[indexAssessmentSelected!].title}=------------documents---------$documents}');
      emit(GetAllAssessmentLoadedState(listAssessment: listAssessment));
      emitSelectAssessments(assessment: listAssessment[indexAssessmentSelected!], indexAssessments: indexAssessmentSelected!);
    });
  }
  emitDeleteDocumentToAssessment({required int idCourse,required int idAssessment,required int idDocument,required int indexDocument})async{
    emit(AddOrUpdateOrDeleteAssessmentLoadingState());
    final failureOrDocuments = await deleteDocumentToAssessmentUseCase(idCourse: idCourse,idAssessment: idAssessment,idDocument: idDocument);
    failureOrDocuments.fold((failure)=>emit(ErrorMessageAssessment(message: _mapFailureMessage(failure: failure))), (unit){
      listAssessment[indexAssessmentSelected!].documents!.remove(listAssessment[indexAssessmentSelected!].documents![indexDocument]);
      emit(GetAllAssessmentLoadedState(listAssessment: listAssessment));
      emitSelectAssessments(assessment: listAssessment[indexAssessmentSelected!], indexAssessments: indexAssessmentSelected!);
    });
  }
  emitDownloadADocumentToAssessment({required int idCourse,required int idAssessment,required int idDocument,required int indexDocument})async{
    Logger().e('-----------------------------');
    emit(AddOrUpdateOrDeleteAssessmentLoadingState());
    final failureOrDocuments = await downloadDocumentToAssessmentUseCase(idCourse: idCourse,idAssessment: idAssessment,idDocument: idDocument);
    failureOrDocuments.fold((failure)=>emit(ErrorMessageAssessment(message: _mapFailureMessage(failure: failure))), (unit){
      Logger().w('Succccccccccccccccccccccccccccccccccccccc');
    //   emitSelectAssessments(assessment: listAssessment[indexAssessmentSelected!], indexAssessments: indexAssessmentSelected!);
    // emit(GetAllAssessmentLoadedState(listAssessment: listAssessment));
    });

  }

  final globalAssessmentKey = GlobalKey<FormState>();
  emitSelectAssessments({required Assessment assessment, required int indexAssessments}) {
    this.assessment = assessment;
    indexAssessmentSelected = indexAssessments;
    emit(SelectedAssessment(assessment: assessment));
  }
  emitAddAssessmentFile({required List<AssessmentFile> listAssessmentFile}){
    listAssessment1[indexAssessmentSelected!].listFilesUrl==null?listAssessment1[indexAssessmentSelected!].listFilesUrl = listAssessmentFile:listAssessment1[indexAssessmentSelected!].listFilesUrl!.addAll(listAssessmentFile);
    assessment = listAssessment[indexAssessmentSelected!];
    emit(GetAllAssessment(assessment: listAssessment1));
    emit(SelectedAssessment(assessment: listAssessment[indexAssessmentSelected!]));
  }
  emitDeleteAssessmentFile({required AssessmentFile assessmentFile}){
    listAssessment1[indexAssessmentSelected!].listFilesUrl!.remove(assessmentFile);
    assessment = listAssessment[indexAssessmentSelected!];
    emit(GetAllAssessment(assessment: listAssessment1));
    emit(SelectedAssessment(assessment: listAssessment[indexAssessmentSelected!]));
  }
  // Assessment
  TextEditingController assessmentTitleTextEditionController = TextEditingController();
  TextEditingController assessmentTimeLiftTextEditionController =
  TextEditingController();
  TextEditingController assessmentScoreTextEditionController =
  TextEditingController();
  TextEditingController assessmentDescriptionTextEditionController =
  TextEditingController();
  DateTime? selectedStartDateAssessment;
  DateTime? selectedEndDateAssessment;
  DateTime? startDateTimeAssessment;
  DateTime? endDateTimeAssessment;
  String? errorMessageAssessment;
  DateTime? startTime;
  DateTime? endTime;

  validateDateTimeAssessment() {
    if (selectedStartDateAssessment == null) {
      emit(ErrorMessageAddAssessment(message: 'Please Enter Start Date'));
      return false;
    } else if (selectedEndDateAssessment == null) {
      emit(ErrorMessageAddAssessment(message: 'Please Enter End Date'));
      return false;
    } else if (startTime == null) {
      emit(ErrorMessageAddAssessment(message: 'Please Enter Start Time'));
      return false;
    } else if (endTime == null) {
      emit(ErrorMessageAddAssessment(message: 'Please Enter End Time'));
      return false;
    }
    else if (selectedStartDateAssessment != null &&
        selectedEndDateAssessment != null &&
        startTime != null &&
        endTime != null) {
      TimeOfDay timeOfDayEnd = TimeOfDay.fromDateTime(endTime!);
      TimeOfDay timeOfDayStart = TimeOfDay.fromDateTime(startTime!);

      return validateEndTime(selectedStartDateAssessment!, timeOfDayStart,
          selectedEndDateAssessment!, timeOfDayEnd);
    } else if (endDateTimeAssessment!.isBefore(startDateTimeAssessment!)) {
      emit(ErrorMessageAddAssessment(
          message:
          'Start time or start date cannot be before the current date or time.'));
      return false;
    } else {
      return true;
    }
  }

// Function to validate the end Time
  bool? validateEndTime(DateTime startDate, TimeOfDay startTime, DateTime endDate,
      TimeOfDay endTime) {
    DateTime startDateTime = DateTime(
      startDate.year,
      startDate.month,
      startDate.day,
      startTime.hour,
      startTime.minute,
    );
    DateTime endDateTime = DateTime(
      endDate.year,
      endDate.month,
      endDate.day,
      endTime.hour,
      endTime.minute,
    );
    startDateTimeAssessment = startDateTime;
    endDateTimeAssessment = endDateTime;
    if (startDateTime.isBefore(DateTime.now()) ||
        startDateTime.isAtSameMomentAs(DateTime.now())) {
      emit(ErrorMessageAddAssessment(
          message: 'Selected Time Start cannot be before the current date.'));
      return false;
    }
    if (endDateTime.isBefore(startDateTime)) {
      emit(ErrorMessageAddAssessment(
          message:
          'End time or end date cannot be before start time or start date.'));
      return false;
    }
    if (endDateTime.isAtSameMomentAs(startDateTime)) {
      emit(ErrorMessageAddAssessment(
          message: 'End time cannot be Same start time.'));
      return false;
    }
    isSuccessSelectDateTime = true;
    return true;
  }

  bool? isSuccessSelectDateTime;
// add Quiz
  List<Assessment1> listAssessment1 = [];

// emitEditQuiz(BuildContext context) {
//   listAssessment[indexQuizSelected!].title = quizTitleTextEditionController.text;
//   listAssessment[indexQuizSelected!].description =
//       quizDescriptionTextEditionController.text;
//   listAssessment[indexQuizSelected!].passingScore =
//       int.parse(quizQuizScoreTextEditionController.text);
//   listAssessment[indexQuizSelected!].timeLift =
//       int.parse(quizTimeLiftTextEditionController.text);
//   listAssessment[indexQuizSelected!].startDateTime = startDateTimeQuiz!;
//   listAssessment[indexQuizSelected!].endDateTime = endDateTimeQuiz!;
//   context.read<QuizCubit>().emitSelectQuiz(
//       quiz: listQuiz[indexQuizSelected!], indexQuiz: indexQuizSelected!);
//   quizTitleTextEditionController = TextEditingController();
//   quizTimeLiftTextEditionController = TextEditingController();
//   quizQuizScoreTextEditionController = TextEditingController();
//   quizDescriptionTextEditionController = TextEditingController();
//   selectedStartDateQuiz = null;
//   selectedEndDateQuiz = null;
//   startDateTimeQuiz = null;
//   endDateTimeQuiz = null;
//   errorMessageQuiz = null;
//   emit(GetAllQuiz(listQuiz: listQuiz));
// }


// emitDeleteQuiz({required Quiz quiz}) {
//   listQuiz.remove(quiz);
//   emit(GetAllQuiz(listQuiz: listQuiz));
// }

// emitChangShoeOrHidQuiz({required BuildContext context, required Quiz quiz}) {
//   listQuiz[indexQuizSelected!].isHideQuiz =
//       !listQuiz[indexQuizSelected!].isHideQuiz;
//   emit(GetAllQuiz(listQuiz: listQuiz));
//   context.read<QuizCubit>().emitSelectQuiz(
//       quiz: listQuiz[indexQuizSelected!], indexQuiz: indexQuizSelected!);
// }
//   emitDeleteAssessment({required Assessment1 assessment}){
//     listAssessment1.remove(assessment);
//     emit(GetAllAssessment(assessment: listAssessment1));
//   }
  emitChangShoeOrHidAssessment({required Assessment1 assessment}) {
    listAssessment1[indexAssessmentSelected!].isHideAssessment= !listAssessment[indexAssessmentSelected!].visibility;
    emit(SelectedAssessment(assessment: listAssessment[indexAssessmentSelected!]));
    emit(GetAllAssessment(assessment: listAssessment1));

  }
  emitEditAssessments() {
    listAssessment1[indexAssessmentSelected!].title= assessmentTitleTextEditionController.text;
    listAssessment1[indexAssessmentSelected!].description= assessmentDescriptionTextEditionController.text;
    listAssessment1[indexAssessmentSelected!].passingScore= int.parse(assessmentScoreTextEditionController.text);
    listAssessment1[indexAssessmentSelected!].startDateTime= startDateTimeAssessment!;
    listAssessment1[indexAssessmentSelected!].endDateTime= endDateTimeAssessment!;
    listAssessment1[indexAssessmentSelected!].isHideAssessment= true;
    emit(SelectedAssessment(assessment: listAssessment[indexAssessmentSelected!]));
    emit(GetAllAssessment(assessment: listAssessment1));
    assessmentTitleTextEditionController = TextEditingController();

    assessmentDescriptionTextEditionController = TextEditingController();

    assessmentScoreTextEditionController = TextEditingController();

    selectedStartDateAssessment = null;

    selectedEndDateAssessment = null;

    startDateTimeAssessment = null;

    endDateTimeAssessment = null;
    errorMessageAssessment = null;

  }

  emitAddAssessments() {
    listAssessment1.add(
      Assessment1(
        title: assessmentTitleTextEditionController.text,
        description: assessmentDescriptionTextEditionController.text,
        passingScore: int.parse(assessmentScoreTextEditionController.text),
        startDateTime: startDateTimeAssessment!,
        endDateTime: endDateTimeAssessment!,
        isHideAssessment: true,
      ),
    );
    emit(GetAllAssessment(assessment: listAssessment1));
    print('---------------------${listAssessment1[0]}');
    assessmentTitleTextEditionController = TextEditingController();

    assessmentDescriptionTextEditionController = TextEditingController();

    assessmentScoreTextEditionController = TextEditingController();

    selectedStartDateAssessment = null;

    selectedEndDateAssessment = null;

    startDateTimeAssessment = null;

    endDateTimeAssessment = null;
    errorMessageAssessment = null;

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

