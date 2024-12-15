part of 'quiz_cubit.dart';

@immutable
sealed class QuizState {}

final class QuizInitial extends QuizState {}
final class QuizSelected extends QuizState{
   Quiz quiz;
  QuizSelected({required this.quiz});
}