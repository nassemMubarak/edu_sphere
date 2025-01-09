part of 'student_quiz_cubit.dart';

@immutable
sealed class StudentQuizState {}

final class StudentQuizInitial extends StudentQuizState {}
class GetAllStudentQuizLoadingState extends StudentQuizState{}
class GetAttemptStudentQuizLoadingState extends StudentQuizState{}
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
