import 'package:bloc/bloc.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/bloc/course_main_cubit.dart';
import 'package:edu_sphere/features/teacher/quiz/domain/entities/question.dart';
import 'package:edu_sphere/features/teacher/quiz/domain/entities/quiz.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'quiz_state.dart';

class QuizCubit extends Cubit<QuizState> {
  QuizCubit() : super(QuizInitial());
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

  emitRemoveOptions() {
    Logger().t(addOrRemoveNumberOption);
    addOrRemoveNumberOption = addOrRemoveNumberOption == 0
        ? addOrRemoveNumberOption
        : addOrRemoveNumberOption - 1;
    emit(AddOrRemoveNewOption(numberOption: addOrRemoveNumberOption));
  }

  emitAddQuestionToQuiz(BuildContext context) {
    Question question = Question(
        questionText: questionTitle.text,
        correctAnswer: correctChoice!,
        questionPathImage: questionPathImage,
        questionScore:questionScore!,
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
    quiz!.questions==null?quiz!.questions=[question]:
    quiz!.questions!.add(question);
    Logger().w(question);
    context.read<CourseMainCubit>().listQuiz[indexQuiz!] = quiz!;
    context.read<CourseMainCubit>().emitAddQuestionToQuiz(
        quizList: context.read<CourseMainCubit>().listQuiz);
    Logger().w(context.read<CourseMainCubit>().listQuiz[indexQuiz!].questions);
    emit(QuizSelected(quiz: quiz!));
    questionTitle = TextEditingController();
    firstChoice = TextEditingController();
    secondChoice = TextEditingController();
    thirdChoice = TextEditingController();
    forthChoice = TextEditingController();
    correctChoice=null;
    questionScore=null;
    questionPathImage=null;
    addOrRemoveNumberOption = 0;
  }

  emitClearOptions() {
    Logger().t(addOrRemoveNumberOption);
    addOrRemoveNumberOption = 0;
    emit(AddOrRemoveNewOption(numberOption: addOrRemoveNumberOption));
  }

  emitSelectQuiz({required Quiz quiz, required int indexQuiz}) {
    this.quiz = quiz;
    this.indexQuiz = indexQuiz;
    emit(QuizSelected(quiz: quiz));
  }
}
