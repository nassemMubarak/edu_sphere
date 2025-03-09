part of 'request_admin_cubit.dart';

@immutable
sealed class RequestAdminState {}

final class RequestAdminInitial extends RequestAdminState {}
class GetAllRequestAdminLoadedState extends RequestAdminState{
  final List<RequestModel> listRequest;
  GetAllRequestAdminLoadedState({required this.listRequest});
}
class GetAllRequestAdminLoadingState extends RequestAdminState{}
class ErrorRequestAdminState extends RequestAdminState{
  final String message;
  ErrorRequestAdminState({required this.message});
}