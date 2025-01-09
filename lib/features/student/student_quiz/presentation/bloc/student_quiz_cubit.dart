import 'package:bloc/bloc.dart';
import 'package:edu_sphere/features/student/student_quiz/domain/entities/question_student_quiz.dart';
import 'package:edu_sphere/features/student/student_quiz/domain/usecases/get_all_student_quiz.dart';
import 'package:edu_sphere/features/student/student_quiz/domain/usecases/get_attempt_student_quiz.dart';
import 'package:edu_sphere/features/student/student_quiz/domain/usecases/submit_answer_quiz.dart';
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
  StudentQuizCubit({
    required this.submitAnswerQuizUseCase,
    required this.getAttemptStudentQuizUseCase,
    required this.getAllStudentQuizUseCase,

}) : super(StudentQuizInitial());
  List<Quiz> listQuiz=[];
  List<QuestionStudentQuiz> listQuestionStudentQuiz=[];
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
  emitGetAttemptStudentQuizUseCase({required int idCourse,required int idQuiz})async{
    emit(GetAttemptStudentQuizLoadingState());
    final failureOrAdvertisement = await getAttemptStudentQuizUseCase(idCourse: idCourse,idQuiz: idQuiz);
    failureOrAdvertisement.fold((failure)=>emit(StudentQuizMessageErrorState(message: _mapFailureMessage(failure: failure))),
            (questionStudentQuiz){
          Logger().d('questionStudentQuiz  list ---->   $questionStudentQuiz');
          listQuestionStudentQuiz = questionStudentQuiz;
          emit(GetAttemptStudentQuizUseCaseLoadedState(listQuestionStudentQuiz: listQuestionStudentQuiz));
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
