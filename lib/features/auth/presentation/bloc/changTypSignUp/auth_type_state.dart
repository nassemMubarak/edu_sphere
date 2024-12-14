part of 'auth_type_cubit.dart';

@immutable
sealed class AuthTypeState {}

final class AuthInitial extends AuthTypeState {}


class StatusSignUpType extends AuthTypeState{
 final String type;
  StatusSignUpType({required this.type});
 @override
 List<Object> get props => [type];
}
class StatusSignUpTypeOnClickButton extends AuthTypeState{
  final String type;
  StatusSignUpTypeOnClickButton({required this.type});
  @override
  List<Object> get props => [type];
}
