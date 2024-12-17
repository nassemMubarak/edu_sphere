part of 'quiz_cubit.dart';

@immutable
sealed class QuizState {}

final class QuizInitial extends QuizState {}
final class QuizSelected extends QuizState{
   Quiz quiz;
  QuizSelected({required this.quiz});
}
final class AddOrRemoveNewOption extends QuizState{
  int numberOption;
  AddOrRemoveNewOption({required this.numberOption});
}
final class ErrorAddOption extends QuizState{
  String? error;
  ErrorAddOption({this.error});
}