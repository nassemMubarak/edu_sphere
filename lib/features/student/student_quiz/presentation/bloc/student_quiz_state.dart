part of 'student_quiz_cubit.dart';

@immutable
sealed class StudentQuizState {}

final class StudentQuizInitial extends StudentQuizState {}
class GetAllStudentQuizLoadingState extends StudentQuizState{}
class GetAttemptStudentQuizLoadingState extends StudentQuizState{}
class IsShowStudentQuizLoadingState extends StudentQuizState{}
class SubmitAnswerQuizLoadingState extends StudentQuizState{}
class ReviewStudentQuizLoadingState extends StudentQuizState{}
class SubmitAnswerQuizLoadedState extends StudentQuizState{}
class IsShowStudentQuizErrorState extends StudentQuizState{
  final String message;
  IsShowStudentQuizErrorState({required this.message});
}
class SubmitAnswerQuizErrorState extends StudentQuizState{
  final String message;
  SubmitAnswerQuizErrorState({required this.message});
}
class IsShowStudentQuizLoadedState extends StudentQuizState{
  final EstimateStudentQuiz estimateQuiz;
  IsShowStudentQuizLoadedState({required this.estimateQuiz});
}
class ReviewStudentQuizLoadedState extends StudentQuizState{
  final ReviewQuiz reviewQuiz;
  ReviewStudentQuizLoadedState({required this.reviewQuiz});
}
class GetAttemptStudentQuizUseCaseLoadedState extends StudentQuizState{
  final List<QuestionStudentQuiz> listQuestionStudentQuiz;
  GetAttemptStudentQuizUseCaseLoadedState({required this.listQuestionStudentQuiz});

  @override
  List<Object> get props => [listQuestionStudentQuiz];
}
class GetAllStudentQuizLoadedState extends StudentQuizState{
  final List<Quiz> listQuiz;
  GetAllStudentQuizLoadedState({required this.listQuiz});

  @override
  List<Object> get props => [listQuiz];
}
class StudentQuizMessageErrorState extends StudentQuizState{
  final String message;

  StudentQuizMessageErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
class ReviewStudentQuizMessageErrorState extends StudentQuizState{
  final String message;

  ReviewStudentQuizMessageErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
class SelectStudentChoiceQuestionToQuiz extends StudentQuizState{
  final List<QuestionStudentQuiz> listQuestionStudentQuiz;
  SelectStudentChoiceQuestionToQuiz({required this.listQuestionStudentQuiz});

  @override
  List<Object> get props => [listQuestionStudentQuiz];
}
class ChangCurrentPageQuestionState extends StudentQuizState{
  int currentPage;
  ChangCurrentPageQuestionState({required this.currentPage});
}
