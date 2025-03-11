part of 'show_camp_cubit.dart';

@immutable
sealed class ShowCampState {}

final class ShowCampInitial extends ShowCampState {}
class ShowCampLoginLoadingState extends ShowCampState{}

class ShowCampLoadedState extends ShowCampState{
  final Camp camp;

  ShowCampLoadedState({required this.camp});

  @override
  List<Object> get props => [camp];
}
class ShowCampMessageErrorState extends ShowCampState{
  final String message;

  ShowCampMessageErrorState({required this.message});

  @override
  List<Object> get props => [message];
}