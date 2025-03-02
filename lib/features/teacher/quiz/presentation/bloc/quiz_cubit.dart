import 'package:edu_sphere/features/teacher/quiz/data/models/review_quiz_model.dart';
import 'package:edu_sphere/features/teacher/quiz/domain/entities/estimate_quiz.dart';
import 'package:edu_sphere/features/teacher/quiz/domain/entities/quiz.dart';
import 'package:edu_sphere/features/teacher/quiz/domain/usecases/add_quiz.dart';
import 'package:edu_sphere/features/teacher/quiz/domain/usecases/delete_quiz.dart';
import 'package:edu_sphere/features/teacher/quiz/domain/usecases/get_all_estimate_quiz.dart';
import 'package:edu_sphere/features/teacher/quiz/domain/usecases/get_all_quiz.dart';
import 'package:edu_sphere/features/teacher/quiz/domain/usecases/show_estimate_quiz.dart';
import 'package:edu_sphere/features/teacher/quiz/domain/usecases/update_estimate_quiz.dart';
import 'package:edu_sphere/features/teacher/quiz/domain/usecases/update_quiz.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/string/failure.dart';

part 'quiz_state.dart';

class QuizCubit extends Cubit<QuizState> {
  final GetAllQuizUseCase getAllQuizUseCase;
  final AddQuizUseCase addQuizUseCase;
  final UpdateQuizUseCase updateQuizUseCase;
  final DeleteQuizUseCase deleteQuizUseCase;
  final GetAllEstimateQuizUseCase getAllEstimateQuizUseCase;
  final UpdateEstimateQuizUseCase updateEstimateQuizUseCase;
  final ShowEstimateQuizUseCase showEstimateQuizUseCase;
  QuizCubit({
    required this.getAllQuizUseCase,
    required this.addQuizUseCase,
    required this.updateQuizUseCase,
    required this.deleteQuizUseCase,
    required this.updateEstimateQuizUseCase,
    required this.getAllEstimateQuizUseCase,
    required this.showEstimateQuizUseCase
}) : super(QuizInitial());
  List<Quiz> listQuize = [];
  List<EstimateQuiz> listEstimateQuiz= [];
  int selectedEstimateQuiz = 0;
   ReviewQuizModel? reviewQuizModel;
  /// emit get all Estimate Quiz
  emitGetAllEstimateQuiz({required int idCourse,required int idQuiz})async{
    emit(GetAllEstimateQuizLoadingState());
    final failureOrAdvertisement = await getAllEstimateQuizUseCase(idCourse: idCourse,idQuiz: idQuiz);
    failureOrAdvertisement.fold((failure)=>emit(QuizMessageErrorState(message: _mapFailureMessage(failure: failure))),
            (estimateQuiz){
          Logger().d('Estimate Quiz  list ---->   $estimateQuiz');
          listEstimateQuiz = estimateQuiz;
          emit(GetAllEstimateQuizLoadedState(listEstimateQuiz:listEstimateQuiz ));
        });
  }
  /// emit show Estimate Quiz
  emitShowEstimateQuiz({required int idCourse,required int idQuiz,required int idEstimate})async{
    Logger().f('.....1................................................00');
    emit(ShowReviewQuizLoadingState());
    final failureOrAdvertisement = await showEstimateQuizUseCase(idCourse: idCourse,idQuiz: idQuiz,idEstimate: idEstimate);
    failureOrAdvertisement.fold((failure){
    Logger().f('....2.................................................00');
      emit(QuizMessageErrorState(message: _mapFailureMessage(failure: failure)));
    },
            (reviewQuiz){
          Logger().d('reviewQuiz  ---->   $reviewQuiz');
          reviewQuizModel = reviewQuiz;
          emit(ShowReviewQuizLoadedState(reviewQuizModel: reviewQuiz ));
        });
  }
  /// emit update Estimate Quiz
  emitUpdateEstimateQuiz({required int idCourse,required int idQuiz,required int grade,required int idEstimate,required int indexEstimateQuiz})async{
    emit(AddOrUpdateOrDeleteLoadingState());
    final failureOrAdvertisement = await updateEstimateQuizUseCase(idCourse:idCourse ,idQuiz: idQuiz,grade: grade,idEstimate:idEstimate );
    failureOrAdvertisement.fold((failure)=>emit(QuizMessageErrorState(message: _mapFailureMessage(failure: failure))),
            (unit){
          listEstimateQuiz[indexEstimateQuiz].grade!.result= grade;
          Logger().d('Estimate Quiz  list ---->   ${listEstimateQuiz[indexEstimateQuiz].grade!.result}');
          emit(GetAllEstimateQuizLoadedState(listEstimateQuiz:listEstimateQuiz ));
        });
  }
  ///emit get all quiz from api
  emitGetAllQuiz({required int idCourse})async{
    Logger().e('id Course $idCourse');
    emit(GetAllQuizLoadingState());
    final failureOrAdvertisement = await getAllQuizUseCase(idCourse:idCourse);
    failureOrAdvertisement.fold((failure)=>emit(QuizMessageErrorState(message: _mapFailureMessage(failure: failure))),
    (quizes){
      Logger().d('Quiz  list ---->   $quizes');
      listQuize = quizes;
      emit(GetAllQuizLoadedState(listQuiz: listQuize));
  });
  }
  emitAddQuize({required int idCourse})async{
    emit(AddOrUpdateOrDeleteLoadingState());
    final failureOrAdvertisement = await addQuizUseCase(idCourse: idCourse,data:{
      'title':quizTitleTextEditionController.text,
      'description':quizDescriptionTextEditionController.text,
      'degree':quizQuizScoreTextEditionController.text,
      'visibility':'$quizVisibility',
      'start_in':startDateTimeQuiz.toString(),
      'end_in':endDateTimeQuiz.toString(),
      'time':quizTimeLiftTextEditionController.text,
    } );
    failureOrAdvertisement.fold((failure)=>emit(QuizMessageErrorState(message: _mapFailureMessage(failure: failure))), (quiz){
      Logger().d('add quiz --> ${quiz}');
      quizTitleTextEditionController = TextEditingController();

      quizTimeLiftTextEditionController = TextEditingController();

      quizQuizScoreTextEditionController = TextEditingController();

      quizDescriptionTextEditionController = TextEditingController();

      selectedStartDateQuiz = null;

      selectedEndDateQuiz = null;

      startDateTimeQuiz = null;
      startTime=null;
      endTime=null;
      endDateTimeQuiz = null;
      errorMessageQuiz = null;
      listQuize.add(quiz);
      emit(GetAllQuizLoadedState(listQuiz: listQuize));
    }) ;
  }
  emitUpdateQuize({required int idCourse,required int idQuiz})async{
    emit(AddOrUpdateOrDeleteLoadingState());
    final failureOrAdvertisement = await updateQuizUseCase(idCourse: idCourse,idQuiz: idQuiz,data:{
      'title':quizTitleTextEditionController.text,
      'description':quizDescriptionTextEditionController.text,
      'degree':quizQuizScoreTextEditionController.text,
      'visibility':'$quizVisibility',
      'start_in':startDateTimeQuiz.toString(),
      'end_in':endDateTimeQuiz.toString(),
      'time':quizTimeLiftTextEditionController.text,
    });
    failureOrAdvertisement.fold((failure)=>emit(QuizMessageErrorState(message: _mapFailureMessage(failure: failure))), (quiz){
      listQuize[indexQuiz!].title=quizTitleTextEditionController.text;
      listQuize[indexQuiz!].description=quizDescriptionTextEditionController.text;
      listQuize[indexQuiz!].degree=quizQuizScoreTextEditionController.text;
      listQuize[indexQuiz!].visibility=quizVisibility;
      listQuize[indexQuiz!].startIn=startDateTimeQuiz!;
      listQuize[indexQuiz!].endIn=endDateTimeQuiz!;
      listQuize[indexQuiz!].time=quizTimeLiftTextEditionController.text;
      quizTitleTextEditionController = TextEditingController();
      quizTimeLiftTextEditionController = TextEditingController();
      quizQuizScoreTextEditionController = TextEditingController();
      quizDescriptionTextEditionController = TextEditingController();
      selectedStartDateQuiz = null;
      selectedEndDateQuiz = null;
      quizVisibility = 0;
      startDateTimeQuiz = null;
      endDateTimeQuiz = null;
      errorMessageQuiz = null;
      startTime=null;
      endTime=null;
      quize=listQuize[indexQuiz!];
      emit(QuizeSelected(quiz: listQuize[indexQuiz!]));
      emit(GetAllQuizLoadedState(listQuiz: listQuize));
    }) ;
  }
  emitUpdateVisibilityQuiz({required int idCourse,required int idQuiz,required int visibility})async{
    Logger().w('quiz.visibility -----------> ${visibility}');
    Logger().w('quiz.visibility -----------> ${visibility==0?1:0}');

    emit(AddOrUpdateOrDeleteLoadingState());
    final failureOrAdvertisement = await updateQuizUseCase(idCourse: idCourse,idQuiz: idQuiz,data:{
      'visibility':'${visibility==0?1:0}',
    });
    failureOrAdvertisement.fold((failure)=>emit(QuizMessageErrorState(message: _mapFailureMessage(failure: failure))), (quiz){
      listQuize[indexQuiz!].visibility = visibility==0?1:0;
      quize = listQuize[indexQuiz!];
      emit(QuizeSelected(quiz: listQuize[indexQuiz!]));
      emit(GetAllQuizLoadedState(listQuiz: listQuize));
    }) ;
  }
  emitDeleteQuize({required Quiz quiz,required int idCourse}) async{
    Logger().d('course id ----->    $idCourse');
    emit(AddOrUpdateOrDeleteLoadingState());
    final failureOrAdvertisement = await deleteQuizUseCase(idCourse: idCourse,idQuiz: quiz.id);
    failureOrAdvertisement.fold((failure)=>emit(QuizMessageErrorState(message: _mapFailureMessage(failure: failure))), (unit){
      listQuize.remove(quiz);
      emit(GetAllQuizLoadedState(listQuiz: listQuize));
    }) ;
  }
  emitUpdateVisibilityEstimateQuiz({required int idCourse,required int idQuiz,required int visibility})async{
    Logger().e('-------------------------------------------$visibility');
    Logger().w('emitUpdateVisibilityEstimateQuiz -----------> ${visibility}');
    Logger().w('emitUpdateVisibilityEstimateQuiz -----------> ${visibility==0?1:0}');

    emit(AddOrUpdateOrDeleteLoadingState());
    final failureOrAdvertisement = await updateQuizUseCase(idCourse: idCourse,idQuiz: idQuiz,data:{
      'result_visible':'${visibility}',
    });
    failureOrAdvertisement.fold((failure)=>emit(QuizMessageErrorState(message: _mapFailureMessage(failure: failure))), (quiz){
      listQuize[indexQuiz!].resultVisible = visibility;
      quize = listQuize[indexQuiz!];
      emit(GetAllQuizLoadedState(listQuiz: listQuize));
      emit(QuizeSelected(quiz: listQuize[indexQuiz!]));
    }) ;
  }

  emitSelectQuize({required Quiz quiz, required int indexQuiz}) {
    this.quize = quiz;
    this.indexQuiz = indexQuiz;
    emit(QuizeSelected(quiz: quiz));
  }
  bool isisHideEstimation = false;
  emitIsHideEstimation(bool isHide){
    isisHideEstimation = isHide;
    emit(IsHideEstimation(isHide: isHide));

  }
  final globalQuizKey = GlobalKey<FormState>();
  Quiz? quize;
  int? indexQuiz;
  final formQuestionKey = GlobalKey<FormState>();
  final formOption1Key = GlobalKey<FormState>();
  final formOption2Key = GlobalKey<FormState>();
  final formOption3Key = GlobalKey<FormState>();
  final formOption4Key = GlobalKey<FormState>();
  String? correctChoice;
  String? questionScore;
  String? questionPathImage;
  TextEditingController questionTitle = TextEditingController();
  TextEditingController firstChoice = TextEditingController();
  TextEditingController secondChoice = TextEditingController();
  TextEditingController thirdChoice = TextEditingController();
  TextEditingController forthChoice = TextEditingController();
  int addOrRemoveNumberOption = 0;

  // Quize
  TextEditingController quizTitleTextEditionController =
  TextEditingController();
  TextEditingController quizTimeLiftTextEditionController =
  TextEditingController();
  TextEditingController quizQuizScoreTextEditionController =
  TextEditingController();
  TextEditingController quizDescriptionTextEditionController =
  TextEditingController();
  DateTime? selectedStartDateQuiz;
  DateTime? selectedEndDateQuiz;
  DateTime? startDateTimeQuiz;
  DateTime? endDateTimeQuiz;
  String? errorMessageQuiz;
  DateTime? startTime;
  DateTime? endTime;
  int quizVisibility= 0;
  validateDateTimeQuiz() {
    if (selectedStartDateQuiz == null) {
      emit(ErrorMessageAddQuiz(message: 'Please Enter Start Date'));
      return false;
    }
    else if (selectedEndDateQuiz == null) {
      emit(ErrorMessageAddQuiz(message: 'Please Enter End Date'));
      return false;
    }
    else if (startTime == null) {
      Logger().e(startTime);
      emit(ErrorMessageAddQuiz(message: 'Please Enter Start Time'));
      return false;
    } else if (endTime == null) {
      emit(ErrorMessageAddQuiz(message: 'Please Enter End Time'));
      return false;
    }
    // else if(selectedStartDateQuiz!.isBefore(DateTime.now())){
    //   emit(ErrorMessageAddQuiz(message: 'Selected date cannot be before the current date.'));
    //   return false;
    // }
    // else if(selectedEndDateQuiz!.isBefore(selectedStartDateQuiz!)){
    //   emit(ErrorMessageAddQuiz(message: 'end date cannot be before the start date'));
    //   return false;
    // }
    else if(selectedStartDateQuiz != null&&selectedEndDateQuiz != null&&startTime != null&&endTime != null){
      TimeOfDay timeOfDayEnd = TimeOfDay.fromDateTime(endTime!);
      TimeOfDay timeOfDayStart = TimeOfDay.fromDateTime(startTime!);

      return validateEndTime(selectedStartDateQuiz!, timeOfDayStart, selectedEndDateQuiz!, timeOfDayEnd);
    } else if(endDateTimeQuiz!.isBefore(startDateTimeQuiz!)){
      emit(ErrorMessageAddQuiz(message: 'Start time or start date cannot be before the current date or time.'));
      return false;
    }else{
      return true;
    }
  }
// Function to validate the end Time
  bool? validateEndTime(DateTime startDate, TimeOfDay startTime, DateTime endDate, TimeOfDay endTime) {
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
    startDateTimeQuiz = startDateTime;
    endDateTimeQuiz = endDateTime;
    if(startDateTime.isBefore(DateTime.now())||startDateTime.isAtSameMomentAs(DateTime.now())){
      emit(ErrorMessageAddQuiz(message: 'Selected Time Start cannot be before the current date.'));
      return false;
    }
    if (endDateTime.isBefore(startDateTime)) {
      emit(ErrorMessageAddQuiz(
          message: 'End time or end date cannot be before start time or start date.'));
      return false;
    }
    if (endDateTime.isAtSameMomentAs(startDateTime)) {
      emit(ErrorMessageAddQuiz(
          message: 'End time cannot be Same start time.'));
      return false;
    }
    isSuccessSelectDateTime = true;
    return true;
  }
  bool? isSuccessSelectDateTime;
  int? indexQuizSelected;
// add Quiz
//   List<Quiz> listQuiz = [];
  // emitEditQuiz(BuildContext context) {
  //   listQuiz[indexQuizSelected!].quizTitle =  quizTitleTextEditionController.text;
  //   listQuiz[indexQuizSelected!].description = quizDescriptionTextEditionController.text;
  //   listQuiz[indexQuizSelected!].passingScore = int.parse(quizQuizScoreTextEditionController.text);
  //   listQuiz[indexQuizSelected!].timeLift =  int.parse(quizTimeLiftTextEditionController.text);
  //   listQuiz[indexQuizSelected!].startDateTime =  startDateTimeQuiz!;
  //   listQuiz[indexQuizSelected!].endDateTime =  endDateTimeQuiz!;
  //   context.read<QuizCubit>().emitSelectQuiz(quiz: listQuiz[indexQuizSelected!],indexQuiz: indexQuizSelected!);
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
  // emitChangShoeOrHidQuiz({required BuildContext context,required Quiz quiz}){
  //   listQuiz[indexQuizSelected!].isHideQuiz = !listQuiz[indexQuizSelected!].isHideQuiz;
  //   emit(GetAllQuiz(listQuiz: listQuiz));
  //   context.read<QuizCubit>().emitSelectQuiz(quiz: listQuiz[indexQuizSelected!],indexQuiz: indexQuizSelected!);
  // }
  // emitAddQuiz() {
  //   listQuiz.add(
  //     Quiz(
  //         quizTitle: quizTitleTextEditionController.text,
  //         description: quizDescriptionTextEditionController.text,
  //         passingScore: int.parse(quizQuizScoreTextEditionController.text),
  //         timeLift: int.parse(quizTimeLiftTextEditionController.text),
  //         startDateTime: startDateTimeQuiz!,
  //         endDateTime: endDateTimeQuiz!,
  //         isHideQuiz: true
  //     ),
  //   );
  //   quizTitleTextEditionController = TextEditingController();
  //
  //   quizTimeLiftTextEditionController = TextEditingController();
  //
  //   quizQuizScoreTextEditionController = TextEditingController();
  //
  //   quizDescriptionTextEditionController = TextEditingController();
  //
  //   selectedStartDateQuiz = null;
  //
  //   selectedEndDateQuiz = null;
  //
  //   startDateTimeQuiz = null;
  //
  //   endDateTimeQuiz = null;
  //   errorMessageQuiz = null;
  //   emit(GetAllQuiz(listQuiz: listQuiz));
  // }
// question
  bool emitValidateCorrectChoiceAndQuestionScore() {
    if (correctChoice == null) {
      emit(ErrorAddOption(error: 'Enter Correct Choice'));
      return false;
    } else if (questionScore == null) {
      emit(ErrorAddOption(error: 'Enter Question Score'));
      return false;
    } else {
      emit(ErrorAddOption(error: null));
      return true;
    }
  }

  emitAddNewOptions() {
    Logger().t(addOrRemoveNumberOption);
    addOrRemoveNumberOption = addOrRemoveNumberOption == 2
        ? addOrRemoveNumberOption
        : addOrRemoveNumberOption + 1;
    emit(AddOrRemoveNewOption(numberOption: addOrRemoveNumberOption));
  }
  emitNumberOption(int numberOption){
    addOrRemoveNumberOption = numberOption;
    emit(AddOrRemoveNewOption(numberOption: addOrRemoveNumberOption));
  }
  emitRemoveOptions() {
    Logger().t(addOrRemoveNumberOption);
    addOrRemoveNumberOption = addOrRemoveNumberOption == 0
        ? addOrRemoveNumberOption
        : addOrRemoveNumberOption - 1;
    emit(AddOrRemoveNewOption(numberOption: addOrRemoveNumberOption));
  }

  // emitDeleteQuestion(
  //     {required BuildContext context, required Question1 question}) {
  //   quiz!.questions!.remove(question);
  //   listQuiz[indexQuiz!] = quiz!;
  //   emit(GetAllQuiz(listQuiz: listQuiz));
  //   emit(QuizSelected(quiz: quiz!));
  // }
  // emitEditQuestionToQuiz(BuildContext context,int index) {
  //   Question1 question = Question1(
  //       questionText: questionTitle.text,
  //       correctAnswer: correctChoice!,
  //       questionPathImage: questionPathImage,
  //       questionScore: questionScore!,
  //       options: addOrRemoveNumberOption >= 2
  //           ? [
  //         firstChoice.text,
  //         secondChoice.text,
  //         thirdChoice.text,
  //         forthChoice.text
  //       ]
  //           : addOrRemoveNumberOption == 1
  //           ? [
  //         firstChoice.text,
  //         secondChoice.text,
  //         thirdChoice.text,
  //       ]
  //           : [
  //         firstChoice.text,
  //         secondChoice.text,
  //       ]);
  //   quiz!.questions == null
  //       ? quiz!.questions = [question]
  //       : quiz!.questions![index] = question;
  //   listQuiz[indexQuiz!] = quiz!;
  //   emit(GetAllQuiz(listQuiz: listQuiz));
  //   emit(QuizSelected(quiz: quiz!));
  //   questionTitle = TextEditingController();
  //   firstChoice = TextEditingController();
  //   secondChoice = TextEditingController();
  //   thirdChoice = TextEditingController();
  //   forthChoice = TextEditingController();
  //   correctChoice = null;
  //   questionScore = null;
  //   questionPathImage = null;
  //   addOrRemoveNumberOption = 0;
  // }
  // emitAddQuestionToQuiz(BuildContext context) {
  //   Question1 question = Question1(
  //       questionText: questionTitle.text,
  //       correctAnswer: correctChoice!,
  //       questionPathImage: questionPathImage,
  //       questionScore: questionScore!,
  //       options: addOrRemoveNumberOption >= 2
  //           ? [
  //               firstChoice.text,
  //               secondChoice.text,
  //               thirdChoice.text,
  //               forthChoice.text
  //             ]
  //           : addOrRemoveNumberOption == 1
  //               ? [
  //                   firstChoice.text,
  //                   secondChoice.text,
  //                   thirdChoice.text,
  //                 ]
  //               : [
  //                   firstChoice.text,
  //                   secondChoice.text,
  //                 ]);
  //   quiz!.questions == null
  //       ? quiz!.questions = [question]
  //       : quiz!.questions!.add(question);
  //   listQuiz[indexQuiz!] = quiz!;
  //   emit(GetAllQuiz(listQuiz: listQuiz));
  //   emit(QuizSelected(quiz: quiz!));
  //   questionTitle = TextEditingController();
  //   firstChoice = TextEditingController();
  //   secondChoice = TextEditingController();
  //   thirdChoice = TextEditingController();
  //   forthChoice = TextEditingController();
  //   correctChoice = null;
  //   questionScore = null;
  //   questionPathImage = null;
  //   addOrRemoveNumberOption = 0;
  // }

  emitClearOptions() {
    addOrRemoveNumberOption = 0;
    emit(AddOrRemoveNewOption(numberOption: addOrRemoveNumberOption));
  }
  emitClearQuestionInputs(){
    questionTitle = TextEditingController();
    firstChoice = TextEditingController();
    secondChoice = TextEditingController();
    thirdChoice = TextEditingController();
    forthChoice = TextEditingController();
    correctChoice = null;
    questionScore = null;
    questionPathImage = null;
    addOrRemoveNumberOption = 0;
  }

  // emitSelectQuiz({required Quiz quiz, required int indexQuiz}) {
  //   this.quiz = quiz;
  //   this.indexQuiz = indexQuiz;
  //   emit(QuizSelected(quiz: quiz));
  // }
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
