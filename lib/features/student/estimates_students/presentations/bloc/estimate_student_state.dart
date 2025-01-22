part of 'estimate_student_cubit.dart';

@immutable
sealed class EstimateStudentState {}

final class EstimateStudentInitial extends EstimateStudentState {}
class ShowEstimateStudentLoadingState extends EstimateStudentState{}
class ShowEstimateStudentLoadedState extends EstimateStudentState{
  final EstimatesStudent estimatesStudent;
  ShowEstimateStudentLoadedState({required this.estimatesStudent});
}
class ShowEstimateStudentErrorState extends EstimateStudentState{
  final String message;
  ShowEstimateStudentErrorState({required this.message});
}
