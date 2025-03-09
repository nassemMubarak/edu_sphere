part of 'accept_or_reject_request_cubit.dart';

@immutable
sealed class AcceptOrRejectRequestState {}

final class AcceptOrRejectRequestInitial extends AcceptOrRejectRequestState {}
final class ReplayRequestLoadingState extends AcceptOrRejectRequestState{}
final class ReplayRequestLoadedDataState extends AcceptOrRejectRequestState{}
final class ErrorMessageReplayRequestState extends AcceptOrRejectRequestState{
  String message;
  ErrorMessageReplayRequestState({required this.message});
}
