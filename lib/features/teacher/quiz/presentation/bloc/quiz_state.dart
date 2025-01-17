part of 'quiz_cubit.dart';

@immutable
sealed class QuizState {}

final class QuizInitial extends QuizState {}
// final class QuizSelected extends QuizState{
//    Quiz quiz;
//   QuizSelected({required this.quiz});
// }
final class QuizeSelected extends QuizState{
   Quiz quiz;
  QuizeSelected({required this.quiz});
}
class GetAllQuizLoadingState extends QuizState{}
class AddOrUpdateOrDeleteLoadingState extends QuizState{}
class GetAllQuizLoadedState extends QuizState{
  final List<Quiz> listQuiz;
  GetAllQuizLoadedState({required this.listQuiz});

  @override
  List<Object> get props => [listQuiz];
}

class GetAllEstimateQuizLoadingState extends QuizState{}

class GetAllEstimateQuizLoadedState extends QuizState{
  final List<EstimateQuiz> listEstimateQuiz;

  GetAllEstimateQuizLoadedState({required this.listEstimateQuiz});

  @override
  List<Object> get props => [listEstimateQuiz];
}
class ShowReviewQuizLoadedState extends QuizState{
  ReviewQuizModel reviewQuizModel;
  ShowReviewQuizLoadedState({required this.reviewQuizModel});
  @override
  List<Object> get props => [reviewQuizModel];

}
class ShowReviewQuizLoadingState extends QuizState{}


class QuizMessageErrorState extends QuizState{
  final String message;

  QuizMessageErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class ErrorMessageAddQuiz extends QuizState{
  final String message;
  ErrorMessageAddQuiz({required this.message});
}
// class GetAllQuiz extends QuizState{
//   List<Quiz> listQuiz;
//   GetAllQuiz({required this.listQuiz});
// }
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