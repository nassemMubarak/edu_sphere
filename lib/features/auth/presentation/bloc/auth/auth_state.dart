part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

class AuthLoadingState extends AuthState{}
class AuthLoadedState extends AuthState{
  final User user;

  AuthLoadedState({required this.user});

  @override
  List<Object> get props => [user];
}
class AuthMessageSuccessState extends AuthState{
  final String message;

  AuthMessageSuccessState({required this.message});

  @override
  List<Object> get props => [message];
}
class AuthMessageErrorState extends AuthState{
  final String message;

  AuthMessageErrorState({required this.message});

  @override
  List<Object> get props => [message];
}