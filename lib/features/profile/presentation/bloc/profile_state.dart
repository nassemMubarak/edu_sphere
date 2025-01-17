part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}
final class GetInfoUserLoadingState extends ProfileState{}
final class UpdateUserLoadingState extends ProfileState{}
final class GetInfoUserLoadedDataState extends ProfileState{
  User user;
  GetInfoUserLoadedDataState({required this.user});
}
final class ErrorMessageGetInfoUserState extends ProfileState{
  String message;
  ErrorMessageGetInfoUserState({required this.message});
}