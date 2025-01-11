import 'package:bloc/bloc.dart';
import 'package:edu_sphere/features/student/student_quiz/domain/entities/estimate_student_quiz.dart';
import 'package:edu_sphere/features/student/student_quiz/domain/entities/question_student_quiz.dart';
import 'package:edu_sphere/features/student/student_quiz/domain/usecases/get_all_student_quiz.dart';
import 'package:edu_sphere/features/student/student_quiz/domain/usecases/get_attempt_student_quiz.dart';
import 'package:edu_sphere/features/student/student_quiz/domain/usecases/show_attempt_quiz.dart';
import 'package:edu_sphere/features/student/student_quiz/domain/usecases/submit_answer_quiz.dart';
import 'package:edu_sphere/features/teacher/quiz/domain/entities/estimate_quiz.dart';
import 'package:edu_sphere/features/teacher/quiz/domain/entities/quiz.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/string/failure.dart';

part 'student_quiz_state.dart';

class StudentQuizCubit extends Cubit<StudentQuizState> {
  final GetAllStudentQuizUseCase getAllStudentQuizUseCase;
  final GetAttemptStudentQuizUseCase getAttemptStudentQuizUseCase;
  final SubmitAnswerQuizUseCase submitAnswerQuizUseCase;
  final ShowAttemptQuizUseCase showAttemptQuizUseCase;
  StudentQuizCubit({
    required this.submitAnswerQuizUseCase,
    required this.getAttemptStudentQuizUseCase,
    required this.getAllStudentQuizUseCase,
    required this.showAttemptQuizUseCase,

}) : super(StudentQuizInitial());
  List<Quiz> listQuiz=[];
  int currentPage = 0;
  emitChangeCurrentPage(int currentPage){
    Logger().f(currentPage);
    this.currentPage = currentPage;
    emit(ChangCurrentPageQuestionState(currentPage: this.currentPage));
  }
  List<QuestionStudentQuiz> listQuestionStudentQuiz=[
    // QuestionStudentQuiz(id: 1, quizId: 1, title: 'Question aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa1', type: 'chois', options: ['hgggggggggggggggggggggggggjtyrbyteyrwvteacsq','fef','dfefg','wewg'], mark: 10, createdAt: DateTime.now(), updatedAt: DateTime.now(), documents: [Document(id: 1, documentableType: 'documentableType', documentableId: 1, type: 'dw', createdAt: DateTime.now()  , updatedAt: DateTime.now(), url: 'url')]),
    // QuestionStudentQuiz(id: 2, quizId: 1, title: 'Question 2', type: 'chois', options: ['sq','fef','dfefg','wewg'], mark: 10, createdAt: DateTime.now(), updatedAt: DateTime.now(), documents: [Document(id: 1, documentableType: 'documentableType', documentableId: 1, type: 'dw', createdAt: DateTime.now()  , updatedAt: DateTime.now(), url: 'url')]),
    // QuestionStudentQuiz(id: 3, quizId: 1, title: 'Question 3', type: 'chois', options: ['sq','fef'], mark: 10, createdAt: DateTime.now(), updatedAt: DateTime.now(), documents: [Document(id: 1, documentableType: 'documentableType', documentableId: 1, type: 'dw', createdAt: DateTime.now()  , updatedAt: DateTime.now(), url: 'url')]),
    // QuestionStudentQuiz(id: 4, quizId: 1, title: 'Question 4', type: 'chois', options: ['true','false'], mark: 10, createdAt: DateTime.now(), updatedAt: DateTime.now(), documents: [Document(id: 1, documentableType: 'documentableType', documentableId: 1, type: 'dw', createdAt: DateTime.now()  , updatedAt: DateTime.now(), url: 'url')]),
    // QuestionStudentQuiz(id: 5, quizId: 1, title: 'Questioggyyyyyhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhjn 5', type: 'chois', options: ['sq','fef','dfefg','wewg'], mark: 10, createdAt: DateTime.now(), updatedAt: DateTime.now(), documents: []),
    // QuestionStudentQuiz(id: 6, quizId: 1, title: 'Question 7', type: 'chois', options: ['sq','fef','dfefg','wewg'], mark: 10, createdAt: DateTime.now(), updatedAt: DateTime.now(), documents: []),
    // QuestionStudentQuiz(id: 7, quizId: 1, title: 'Question 8', type: 'chois', options: ['sq','fef','dfefg','wewg'], mark: 10, createdAt: DateTime.now(), updatedAt: DateTime.now(), documents: []),
    // QuestionStudentQuiz(id: 8, quizId: 1, title: 'Question 9', type: 'chois', options: ['sq','fef','dfefg','wewg'], mark: 10, createdAt: DateTime.now(), updatedAt: DateTime.now(), documents: [Document(id: 1, documentableType: 'documentableType', documentableId: 1, type: 'dw', createdAt: DateTime.now()  , updatedAt: DateTime.now(), url: 'url')]),
    // QuestionStudentQuiz(id: 9, quizId: 1, title: 'Question 10', type: 'chois', options: ['sq','fef','dfefg','wewg'], mark: 10, createdAt: DateTime.now(), updatedAt: DateTime.now(), documents: [Document(id: 1, documentableType: 'documentableType', documentableId: 1, type: 'dw', createdAt: DateTime.now()  , updatedAt: DateTime.now(), url: 'url')]),
    // QuestionStudentQuiz(id: 10, quizId: 1, title: 'Question 11', type: 'chois', options: ['sq','fef','dfefg','wewg'], mark: 10, createdAt: DateTime.now(), updatedAt: DateTime.now(), documents: [Document(id: 1, documentableType: 'documentableType', documentableId: 1, type: 'dw', createdAt: DateTime.now()  , updatedAt: DateTime.now(), url: 'url')]),
    // QuestionStudentQuiz(id: 1, quizId: 1, title: 'Question 12', type: 'chois', options: ['sq','fef','dfefg','wewg'], mark: 10, createdAt: DateTime.now(), updatedAt: DateTime.now(), documents: [Document(id: 1, documentableType: 'documentableType', documentableId: 1, type: 'dw', createdAt: DateTime.now()  , updatedAt: DateTime.now(), url: 'url')]),
    // QuestionStudentQuiz(id: 1, quizId: 1, title: 'Question 13', type: 'chois', options: ['sq','fef','dfefg','wewg'], mark: 10, createdAt: DateTime.now(), updatedAt: DateTime.now(), documents: [Document(id: 1, documentableType: 'documentableType', documentableId: 1, type: 'dw', createdAt: DateTime.now()  , updatedAt: DateTime.now(), url: 'url')]),
    // QuestionStudentQuiz(id: 1, quizId: 1, title: 'Question 14', type: 'chois', options: ['sq','fef','dfefg','wewg'], mark: 10, createdAt: DateTime.now(), updatedAt: DateTime.now(), documents: [Document(id: 1, documentableType: 'documentableType', documentableId: 1, type: 'dw', createdAt: DateTime.now()  , updatedAt: DateTime.now(), url: 'url')]),
    // // QuestionStudentQuiz(id: 1, quizId: 1, title: 'Question 15', type: 'chois', options: ['sq','fef','dfefg','wewg'], mark: 10, createdAt: DateTime.now(), updatedAt: DateTime.now(), documents: [Document(id: 1, documentableType: 'documentableType', documentableId: 1, type: 'dw', createdAt: DateTime.now()  , updatedAt: DateTime.now(), url: 'url')]),
  ];
  Quiz? quizSelected;
  emitGetAllStudentQuiz({required int idCourse})async{
    emit(GetAllStudentQuizLoadingState());
    final failureOrAdvertisement = await getAllStudentQuizUseCase(idCourse: idCourse);
    failureOrAdvertisement.fold((failure)=>emit(StudentQuizMessageErrorState(message: _mapFailureMessage(failure: failure))),
            (quiz){
          Logger().d('Student Quiz  list ---->   $quiz');
          listQuiz = quiz;
          emit(GetAllStudentQuizLoadedState(listQuiz: listQuiz));
        });
  }
  emitSubmitAnswerQuizUseCaseUseCase({required Map<int, String?> data})async{
    emit(SubmitAnswerQuizLoadingState());
    final failureOrAttemptStudentQuiz = await submitAnswerQuizUseCase(idCourse: quizSelected!.courseId,idQuiz: quizSelected!.id,data:data);
    failureOrAttemptStudentQuiz.fold((failure){
      emit(SubmitAnswerQuizErrorState(message: _mapFailureMessage(failure: failure)));
      Logger().e('failureOrAdvertisement-----${_mapFailureMessage(failure: failure)}');
    },
            (unit){
          emit(SubmitAnswerQuizLoadedState());
        },
    );
  }

  emitGetAttemptStudentQuizUseCase({required int idCourse,required int idQuiz})async{
    Logger().e('------------------emitGetAttemptStudentQuizUseCase-------------------');
    emit(GetAttemptStudentQuizLoadingState());
    final failureOrAttemptStudentQuiz = await getAttemptStudentQuizUseCase(idCourse: idCourse,idQuiz: idQuiz);
    failureOrAttemptStudentQuiz.fold((failure){
      emit(StudentQuizMessageErrorState(message: _mapFailureMessage(failure: failure)));
    Logger().e('failureOrAdvertisement-----${_mapFailureMessage(failure: failure)}');

    },
            (questionStudentQuiz){
          Logger().d('questionStudentQuiz  list ---->   $questionStudentQuiz');
          listQuestionStudentQuiz = questionStudentQuiz;
          emit(GetAttemptStudentQuizUseCaseLoadedState(listQuestionStudentQuiz: listQuestionStudentQuiz));
        });
  }
  emitIsShowStudentQuizUseCase({required int idCourse,required int idQuiz})async{
    emit(IsShowStudentQuizLoadingState());
    final failureOrAttemptStudentQuiz = await showAttemptQuizUseCase(idQuiz: idQuiz,idCourse: idCourse);
    failureOrAttemptStudentQuiz.fold((failure){
      emit(IsShowStudentQuizErrorState(message: _mapFailureMessage(failure: failure)));
    Logger().e('failureOrAdvertisement-----${_mapFailureMessage(failure: failure)}');

    },
            (estimate){
          Logger().d('estimate ---->   $estimate');
          emit(IsShowStudentQuizLoadedState(estimateQuiz: estimate));
        });
  }
  emitSelectStudentChoiceQuestionToQuiz({required int indexChoice,required int indexQuestion}){
    listQuestionStudentQuiz[indexQuestion].isSelectedOption = indexChoice;
    Logger().f(listQuestionStudentQuiz[indexQuestion].isSelectedOption);
    emit(SelectStudentChoiceQuestionToQuiz(listQuestionStudentQuiz: listQuestionStudentQuiz));
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
        return INVALID_DATA_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error, Please try again later .';
    }
  }

}
