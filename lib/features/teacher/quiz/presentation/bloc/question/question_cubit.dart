import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/core/string/failure.dart';
import 'package:edu_sphere/features/teacher/quiz/domain/entities/question.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';

import '../../../domain/usecases/question_use_cases/add_question.dart';
import '../../../domain/usecases/question_use_cases/delete_question.dart';
import '../../../domain/usecases/question_use_cases/get_all_question.dart';
import '../../../domain/usecases/question_use_cases/update_question.dart';

part 'question_state.dart';

class QuestionCubit extends Cubit<QuestionState> {
  final GetAllQuestionUseCase getAllQuestionUseCase;
  final AddQuestionUseCase addQuestionUseCase;
  final DeleteQuestionUseCase deleteQuestionUseCase;
  final UpdateQuestionUseCase updateQuestionUseCase;
  QuestionCubit({
    required this.getAllQuestionUseCase,
    required this.addQuestionUseCase,
    required this.deleteQuestionUseCase,
    required this.updateQuestionUseCase,
}) : super(QuestionInitial());
  final formQuestionKey = GlobalKey<FormState>();
  final formOption1Key = GlobalKey<FormState>();
  final formOption2Key = GlobalKey<FormState>();
  final formOption3Key = GlobalKey<FormState>();
  final formOption4Key = GlobalKey<FormState>();
  String? correctChoice;
  String? questionScore;
  String? questionPathImage;
  File? questionImage;
  TextEditingController questionTitle = TextEditingController();
  TextEditingController firstChoice = TextEditingController();
  TextEditingController secondChoice = TextEditingController();
  TextEditingController thirdChoice = TextEditingController();
  TextEditingController forthChoice = TextEditingController();
  int addOrRemoveNumberOption = 0;
  emitClearOptions() {
    addOrRemoveNumberOption = 0;
    emit(AddOrRemoveNewOptions(numberOption: addOrRemoveNumberOption));
  }
  List<Question> listOfQuestion = [];

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
  emitAddNewOptions() {
    Logger().t(addOrRemoveNumberOption);
    addOrRemoveNumberOption = addOrRemoveNumberOption == 2
        ? addOrRemoveNumberOption
        : addOrRemoveNumberOption + 1;
    emit(AddOrRemoveNewOptions(numberOption: addOrRemoveNumberOption));
  }
  emitNumberOption(int numberOption){
    addOrRemoveNumberOption = numberOption;
    emit(AddOrRemoveNewOptions(numberOption: addOrRemoveNumberOption));
  }
  emitRemoveOptions() {
    Logger().t(addOrRemoveNumberOption);
    addOrRemoveNumberOption = addOrRemoveNumberOption == 0
        ? addOrRemoveNumberOption
        : addOrRemoveNumberOption - 1;
    emit(AddOrRemoveNewOptions(numberOption: addOrRemoveNumberOption));
  }
  emitGetAllQuestion({required int idQuiz,required int idCourse})async{
    emit(GetAllQuestionLoadingState());
    final failureOrAdvertisement = await getAllQuestionUseCase(idQuiz: idQuiz,idCourse: idCourse);
    failureOrAdvertisement.fold((failure)=>emit(QuestionMessageErrorState(message: _mapFailureMessage(failure: failure))),
            (questions){
          Logger().d('Question  list ---->   $questions');
          listOfQuestion = questions;
          emit(GetAllQuestionLoadedState(listQuestion: questions));
        });
  }
  emitAddQuestion({required int idCourse,required int idQuiz})async{
    Logger().e('questionImage----------->>>>>>>>>>>>>>>$questionImage');
    List<String> option = addOrRemoveNumberOption >= 2
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
    ];
    String correctAnswer = correctChoice=='First Choice'?option[0]:correctChoice=='Second Choice'?option[1]:correctChoice=='Third Choice'?option[2]:option[3];
    Logger().f('correctAnswer --------------->>>>>>    $correctAnswer');
    emit(AddOrUpdateOrDeleteQuestionLoadingState());
    final data = {
      'title':questionTitle.text,
      'type':'choice',
      'options':option,
      'correct_answer':correctAnswer,
      'mark':questionScore,
    };
  Logger().e('-----------********************');
    final failureOrAdvertisement = await addQuestionUseCase(image: questionImage,idCourse: idCourse,idQuiz: idQuiz,data: data);
    failureOrAdvertisement.fold((failure)=>emit(QuestionMessageErrorState(message: _mapFailureMessage(failure: failure))), (question){
      Logger().d('add question --> ${question}');
      emitClearOptions();
      emitClearQuestionInputs();
      Logger().e(listOfQuestion);
      listOfQuestion.add(question);
      Logger().e(listOfQuestion);
      emit(GetAllQuestionLoadedState(listQuestion: listOfQuestion));
    }) ;
  }
  emitEditQuestion({required int idCourse,required int idQuiz,required int idQuestion,required int indexQuestion})async{
    emit(AddOrUpdateOrDeleteQuestionLoadingState());
    Logger().e('questionImage----------->>>>>>>>>>>>>>>$questionImage');
    List<String> option = addOrRemoveNumberOption >= 2
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
    ];

    final data = {
      'title':questionTitle.text,
      'type':'choice',
      'options':option.toString(),
      'correct_answer':correctChoice,
      'mark':questionScore,
    };
    Logger().e('-----------********************');
    final failureOrAdvertisement = await updateQuestionUseCase(image: questionImage,idCourse: idCourse,idQuiz: idQuiz,data: data,idQuestion: idQuestion);
    failureOrAdvertisement.fold((failure)=>emit(QuestionMessageErrorState(message: _mapFailureMessage(failure: failure))), (unit){
      Logger().d('update question --> }');
      Logger().e(listOfQuestion);
      listOfQuestion[indexQuestion].title =questionTitle.text;
      listOfQuestion[indexQuestion].correctAnswer =correctChoice!;
      listOfQuestion[indexQuestion].options =option;
      listOfQuestion[indexQuestion].mark =int.parse(questionScore!);
      Logger().e(listOfQuestion);
      emitClearOptions();
      emitClearQuestionInputs();
      emit(GetAllQuestionLoadedState(listQuestion: listOfQuestion));
    }) ;
  }
  emitDeleteQuestion({required int idCourse,required int idQuiz,required int idQuestion,required int indexQuestion})async{
    emit(AddOrUpdateOrDeleteQuestionLoadingState());

    final failureOrAdvertisement = await deleteQuestionUseCase(idCourse: idCourse,idQuiz: idQuiz,idQuestion: idQuestion);

    failureOrAdvertisement.fold((failure)=>emit(QuestionMessageErrorState(message: _mapFailureMessage(failure: failure))), (unit){
      Logger().e('delete questions succes');
      listOfQuestion.remove(listOfQuestion[indexQuestion]);
      emit(GetAllQuestionLoadedState(listQuestion: listOfQuestion));
    }) ;
  }
  bool emitValidateCorrectChoiceAndQuestionScore() {
    if (correctChoice == null) {
      emit(ErrorAddOptions(error: 'Enter Correct Choice'));
      return false;
    } else if (questionScore == null) {
      emit(ErrorAddOptions(error: 'Enter Question Score'));
      return false;
    } else {
      emit(ErrorAddOptions(error: null));
      return true;
    }
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
