part of 'student_advertisements_cubit.dart';

@immutable
sealed class StudentAdvertisementsState {}

final class StudentAdvertisementsInitial extends StudentAdvertisementsState {}
class GetAllStudentAdvertisementsLoadedState extends StudentAdvertisementsState{
  final List<Advertisement> advertmints;

  GetAllStudentAdvertisementsLoadedState({required this.advertmints});

  @override
  List<Object> get props => [advertmints];
}
class GetAllStudentAdvertisementsLoadingState extends StudentAdvertisementsState{}
class GetAllStudentAdvertisementsMessageErrorState extends StudentAdvertisementsState{
  final String message;

  GetAllStudentAdvertisementsMessageErrorState({required this.message});

  @override
  List<Object> get props => [message];
}