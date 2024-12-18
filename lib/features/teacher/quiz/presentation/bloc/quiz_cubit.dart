import 'package:edu_sphere/features/teacher/quiz/domain/entities/question.dart';
import 'package:edu_sphere/features/teacher/quiz/domain/entities/quiz.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'quiz_state.dart';

class QuizCubit extends Cubit<QuizState> {
  QuizCubit() : super(QuizInitial());
  bool isisHideEstimation = false;
  emitIsHideEstimation(bool isHide){
    isisHideEstimation = isHide;
    emit(IsHideEstimation(isHide: isHide));

  }
  final globalQuizKey = GlobalKey<FormState>();
  Quiz? quiz;
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
  List<Quiz> listQuiz = [];
  emitEditQuiz(BuildContext context) {
    listQuiz[indexQuizSelected!].quizTitle =  quizTitleTextEditionController.text;
    listQuiz[indexQuizSelected!].description = quizDescriptionTextEditionController.text;
    listQuiz[indexQuizSelected!].passingScore = int.parse(quizQuizScoreTextEditionController.text);
    listQuiz[indexQuizSelected!].timeLift =  int.parse(quizTimeLiftTextEditionController.text);
    listQuiz[indexQuizSelected!].startDateTime =  startDateTimeQuiz!;
    listQuiz[indexQuizSelected!].endDateTime =  endDateTimeQuiz!;
    context.read<QuizCubit>().emitSelectQuiz(quiz: listQuiz[indexQuizSelected!],indexQuiz: indexQuizSelected!);
    quizTitleTextEditionController = TextEditingController();
    quizTimeLiftTextEditionController = TextEditingController();
    quizQuizScoreTextEditionController = TextEditingController();
    quizDescriptionTextEditionController = TextEditingController();
    selectedStartDateQuiz = null;
    selectedEndDateQuiz = null;
    startDateTimeQuiz = null;
    endDateTimeQuiz = null;
    errorMessageQuiz = null;
    emit(GetAllQuiz(listQuiz: listQuiz));
  }

  emitDeleteQuiz({required Quiz quiz}) {
    listQuiz.remove(quiz);
    emit(GetAllQuiz(listQuiz: listQuiz));
  }
  emitChangShoeOrHidQuiz({required BuildContext context,required Quiz quiz}){
    listQuiz[indexQuizSelected!].isHideQuiz = !listQuiz[indexQuizSelected!].isHideQuiz;
    emit(GetAllQuiz(listQuiz: listQuiz));
    context.read<QuizCubit>().emitSelectQuiz(quiz: listQuiz[indexQuizSelected!],indexQuiz: indexQuizSelected!);
  }
  emitAddQuiz() {
    listQuiz.add(
      Quiz(
          quizTitle: quizTitleTextEditionController.text,
          description: quizDescriptionTextEditionController.text,
          passingScore: int.parse(quizQuizScoreTextEditionController.text),
          timeLift: int.parse(quizTimeLiftTextEditionController.text),
          startDateTime: startDateTimeQuiz!,
          endDateTime: endDateTimeQuiz!,
          isHideQuiz: true
      ),
    );
    quizTitleTextEditionController = TextEditingController();

    quizTimeLiftTextEditionController = TextEditingController();

    quizQuizScoreTextEditionController = TextEditingController();

    quizDescriptionTextEditionController = TextEditingController();

    selectedStartDateQuiz = null;

    selectedEndDateQuiz = null;

    startDateTimeQuiz = null;

    endDateTimeQuiz = null;
    errorMessageQuiz = null;
    emit(GetAllQuiz(listQuiz: listQuiz));
  }
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

  emitDeleteQuestion(
      {required BuildContext context, required Question question}) {
    quiz!.questions!.remove(question);
    listQuiz[indexQuiz!] = quiz!;
    emit(GetAllQuiz(listQuiz: listQuiz));
    emit(QuizSelected(quiz: quiz!));
  }
  emitEditQuestionToQuiz(BuildContext context,int index) {
    Question question = Question(
        questionText: questionTitle.text,
        correctAnswer: correctChoice!,
        questionPathImage: questionPathImage,
        questionScore: questionScore!,
        options: addOrRemoveNumberOption >= 2
            ? [
          firstChoice.text,
          secondChoice.text,
          thirdChoice.text,
          forthChoice.text
        ]
            : addOrRemoveNumberOption == 1
            ? [
          firstChoice.text,
          secondChoice.text,
          thirdChoice.text,
        ]
            : [
          firstChoice.text,
          secondChoice.text,
        ]);
    quiz!.questions == null
        ? quiz!.questions = [question]
        : quiz!.questions![index] = question;
    listQuiz[indexQuiz!] = quiz!;
    emit(GetAllQuiz(listQuiz: listQuiz));
    emit(QuizSelected(quiz: quiz!));
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
  emitAddQuestionToQuiz(BuildContext context) {
    Question question = Question(
        questionText: questionTitle.text,
        correctAnswer: correctChoice!,
        questionPathImage: questionPathImage,
        questionScore: questionScore!,
        options: addOrRemoveNumberOption >= 2
            ? [
                firstChoice.text,
                secondChoice.text,
                thirdChoice.text,
                forthChoice.text
              ]
            : addOrRemoveNumberOption == 1
                ? [
                    firstChoice.text,
                    secondChoice.text,
                    thirdChoice.text,
                  ]
                : [
                    firstChoice.text,
                    secondChoice.text,
                  ]);
    quiz!.questions == null
        ? quiz!.questions = [question]
        : quiz!.questions!.add(question);
    listQuiz[indexQuiz!] = quiz!;
    emit(GetAllQuiz(listQuiz: listQuiz));
    emit(QuizSelected(quiz: quiz!));
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

  emitSelectQuiz({required Quiz quiz, required int indexQuiz}) {
    this.quiz = quiz;
    this.indexQuiz = indexQuiz;
    emit(QuizSelected(quiz: quiz));
  }
}
