
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable{
  String? message;
  Failure({this.message = 'Unexpected Error, Please try again later.'});

  @override
  List<Object?> get props => [message];
}

class OfflineFailure extends Failure{}
class EmptyCacheFailure extends Failure{}
class ServerFailure extends Failure{}
class InvalidDataFailure extends Failure{}
class InvalidDataFailureMessage extends Failure{
  InvalidDataFailureMessage({ String? message}) : super(message: message);

}