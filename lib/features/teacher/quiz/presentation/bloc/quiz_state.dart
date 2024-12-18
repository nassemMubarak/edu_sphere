part of 'quiz_cubit.dart';

@immutable
sealed class QuizState {}

final class QuizInitial extends QuizState {}
final class QuizSelected extends QuizState{
   Quiz quiz;
  QuizSelected({required this.quiz});
}
class ErrorMessageAddQuiz extends QuizState{
  final String message;
  ErrorMessageAddQuiz({required this.message});
}
class GetAllQuiz extends QuizState{
  List<Quiz> listQuiz;
  GetAllQuiz({required this.listQuiz});
}
final class AddOrRemoveNewOption extends QuizState{
  int numberOption;
  AddOrRemoveNewOption({required this.numberOption});
}
final class ErrorAddOption extends QuizState{
  String? error;
  ErrorAddOption({this.error});
}
final class IsHideEstimation extends QuizState{
  bool isHide;
  IsHideEstimation({required this.isHide});
}