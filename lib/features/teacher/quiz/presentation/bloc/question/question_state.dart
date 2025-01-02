part of 'question_cubit.dart';

@immutable
sealed class QuestionState {}

final class QuestionInitial extends QuestionState {}
class GetAllQuestionLoadingState extends QuestionState{}
class AddOrUpdateOrDeleteQuestionLoadingState extends QuestionState{}
class GetAllQuestionLoadedState extends QuestionState{
  final List<Question> listQuestion;

  GetAllQuestionLoadedState({required this.listQuestion});

  @override
  List<Object> get props => [listQuestion];
}
final class ErrorAddOptions extends QuestionState{
  String? error;
  ErrorAddOptions({this.error});
}
final class AddOrRemoveNewOptions extends QuestionState{
  int numberOption;
  AddOrRemoveNewOptions({required this.numberOption});
}

class QuestionMessageErrorState extends QuestionState{
  final String message;

  QuestionMessageErrorState({required this.message});

  @override
  List<Object> get props => [message];
}