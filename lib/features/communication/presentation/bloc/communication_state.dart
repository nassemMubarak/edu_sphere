part of 'communication_cubit.dart';

@immutable
sealed class CommunicationState {}

final class CommunicationInitial extends CommunicationState {}
final class GetAllCommunicationLoadingState extends CommunicationState{}
final class AddOrUpdateCommunicationLoadingState extends CommunicationState{}
final class GetAllCommunicationLoadedDataState extends CommunicationState{
  List<Communication> communication;
  GetAllCommunicationLoadedDataState({required this.communication});
}
final class ErrorMessageCommunicationUserState extends CommunicationState{
  String message;
  ErrorMessageCommunicationUserState({required this.message});
}