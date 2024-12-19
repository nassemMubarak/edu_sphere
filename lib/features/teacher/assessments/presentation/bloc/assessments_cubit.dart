import 'package:edu_sphere/features/teacher/assessments/domain/entities/assessment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

part 'assessments_state.dart';

class AssessmentsCubit extends Cubit<AssessmentsState> {
  AssessmentsCubit() : super(AssessmentsInitial());
  Assessment? assessment;
  int? indexAssessmentSelected;
  bool isHideEstimationAssessment = false;
  emitIsHideEstimationAssessment(bool isHide){
    isHideEstimationAssessment = isHide;
    emit(IsHideEstimationAssessment(isHide: isHide));

  }

  final globalAssessmentKey = GlobalKey<FormState>();
  emitSelectAssessments({required Assessment assessment, required int indexAssessments}) {
    this.assessment = assessment;
    indexAssessmentSelected = indexAssessments;
    emit(SelectedAssessment(assessment: assessment));
  }
  emitAddAssessmentFile({required List<AssessmentFile> listAssessmentFile}){
    listAssessment[indexAssessmentSelected!].listFilesUrl==null?listAssessment[indexAssessmentSelected!].listFilesUrl = listAssessmentFile:listAssessment[indexAssessmentSelected!].listFilesUrl!.addAll(listAssessmentFile);
    assessment = listAssessment[indexAssessmentSelected!];
    emit(GetAllAssessment(assessment: listAssessment));
    emit(SelectedAssessment(assessment: listAssessment[indexAssessmentSelected!]));
  }
  emitDeleteAssessmentFile({required AssessmentFile assessmentFile}){
    listAssessment[indexAssessmentSelected!].listFilesUrl!.remove(assessmentFile);
    assessment = listAssessment[indexAssessmentSelected!];
    emit(GetAllAssessment(assessment: listAssessment));
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
  List<Assessment> listAssessment = [];

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
  emitDeleteAssessment({required Assessment assessment}){
    listAssessment.remove(assessment);
    emit(GetAllAssessment(assessment: listAssessment));
  }
  emitChangShoeOrHidAssessment({required Assessment assessment}) {
    listAssessment[indexAssessmentSelected!].isHideAssessment= !listAssessment[indexAssessmentSelected!].isHideAssessment;
    emit(SelectedAssessment(assessment: listAssessment[indexAssessmentSelected!]));
    emit(GetAllAssessment(assessment: listAssessment));

  }
  emitEditAssessments() {
    listAssessment[indexAssessmentSelected!].title= assessmentTitleTextEditionController.text;
    listAssessment[indexAssessmentSelected!].description= assessmentDescriptionTextEditionController.text;
    listAssessment[indexAssessmentSelected!].passingScore= int.parse(assessmentScoreTextEditionController.text);
    listAssessment[indexAssessmentSelected!].startDateTime= startDateTimeAssessment!;
    listAssessment[indexAssessmentSelected!].endDateTime= endDateTimeAssessment!;
    listAssessment[indexAssessmentSelected!].isHideAssessment= true;
    emit(SelectedAssessment(assessment: listAssessment[indexAssessmentSelected!]));
    emit(GetAllAssessment(assessment: listAssessment));
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
    listAssessment.add(
      Assessment(
        title: assessmentTitleTextEditionController.text,
        description: assessmentDescriptionTextEditionController.text,
        passingScore: int.parse(assessmentScoreTextEditionController.text),
        startDateTime: startDateTimeAssessment!,
        endDateTime: endDateTimeAssessment!,
        isHideAssessment: true,
      ),
    );
    emit(GetAllAssessment(assessment: listAssessment));
    print('---------------------${listAssessment[0]}');
    assessmentTitleTextEditionController = TextEditingController();

    assessmentDescriptionTextEditionController = TextEditingController();

    assessmentScoreTextEditionController = TextEditingController();

    selectedStartDateAssessment = null;

    selectedEndDateAssessment = null;

    startDateTimeAssessment = null;

    endDateTimeAssessment = null;
    errorMessageAssessment = null;

  }

}

