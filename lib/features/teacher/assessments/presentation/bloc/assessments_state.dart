part of 'assessments_cubit.dart';

@immutable
sealed class AssessmentsState {}

final class AssessmentsInitial extends AssessmentsState {}
class ErrorMessageAddAssessment extends AssessmentsState{
  final String message;
  ErrorMessageAddAssessment({required this.message});
}
class GetAllAssessment extends AssessmentsState{
  List<Assessment> assessment;
  GetAllAssessment({required this.assessment});
}
class SelectedAssessment extends AssessmentsState{
  Assessment assessment;
  SelectedAssessment({required this.assessment});
}
class IsHideEstimationAssessment extends AssessmentsState{
  bool isHide;
  IsHideEstimationAssessment({required this.isHide});
}
