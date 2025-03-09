part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

class AuthLoadingState extends AuthState{}

final class AuthAdminInitial extends AuthState {}
class AuthAdminLoginLoadingState extends AuthState{}
class AuthAdminRegisterLoadingState extends AuthState{}
class AuthAdminLadedState extends AuthState{
  final Admin admin;

  AuthAdminLadedState({required this.admin});

  @override
  List<Object> get props => [admin];

}
class AuthLoadedState extends AuthState{
  final User user;

  AuthLoadedState({required this.user});

  @override
  List<Object> get props => [user];
}
class GetAllCampsLoadedState extends AuthState{
  final List<Camp> camp;

  GetAllCampsLoadedState({required this.camp});

  @override
  List<Object> get props => [camp];
}
class AuthMessageErrorCampState extends AuthState{
  final String message;

  AuthMessageErrorCampState({required this.message});

  @override
  List<Object> get props => [message];
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
}class AuthAdminMessageErrorState extends AuthState{
  final String message;

  AuthAdminMessageErrorState({required this.message});

  @override
  List<Object> get props => [message];
}