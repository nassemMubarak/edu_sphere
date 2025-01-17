part of 'assessments_cubit.dart';

@immutable
sealed class AssessmentsState {}

final class AssessmentsInitial extends AssessmentsState {}
class ErrorMessageAddAssessment extends AssessmentsState{
  final String message;
  ErrorMessageAddAssessment({required this.message});
}
///
class GetAllAssessmentLoadingState extends AssessmentsState{}
class AddOrUpdateOrDeleteAssessmentLoadingState extends AssessmentsState{}
class GetAllAssessmentLoadedState extends AssessmentsState{
  final List<Assessment> listAssessment;

  GetAllAssessmentLoadedState({required this.listAssessment});

  @override
  List<Object> get props => [listAssessment];
}
class AddSucssessEstimateAssessmentLoadingState extends AssessmentsState{}

class GetAllEstimateAssessmentLoadedState extends AssessmentsState{
  final List<EstimateAssessment> listEstimateAssessment;

  GetAllEstimateAssessmentLoadedState({required this.listEstimateAssessment});

  @override
  List<Object> get props => [listEstimateAssessment];
}
class GetAllEstimateAssessmentLoadingState extends AssessmentsState{}
class AddEstimateAssessmentLoadingState extends AssessmentsState{}
class ErrorMessageAssessment extends AssessmentsState{
  final String message;
  ErrorMessageAssessment({required this.message});
}

class ErrorMessageEstimateAssessment extends AssessmentsState{
  final String message;
  ErrorMessageEstimateAssessment({required this.message});
}

class QuizMessageErrorState extends AssessmentsState{
  final String message;

  QuizMessageErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class SelectedAssessment extends AssessmentsState{
  Assessment assessment;
  SelectedAssessment({required this.assessment});
}
class IsHideEstimationAssessment extends AssessmentsState{
  bool isHide;
  IsHideEstimationAssessment({required this.isHide});
}
