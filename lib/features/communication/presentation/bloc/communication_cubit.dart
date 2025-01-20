import 'package:bloc/bloc.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/core/string/failure.dart';
import 'package:edu_sphere/features/communication/domain/entities/communication.dart';
import 'package:edu_sphere/features/communication/domain/usecases/add_communication.dart';
import 'package:edu_sphere/features/communication/domain/usecases/get_all_communication.dart';
import 'package:edu_sphere/features/communication/domain/usecases/update_communication.dart';
import 'package:meta/meta.dart';

part 'communication_state.dart';

class CommunicationCubit extends Cubit<CommunicationState> {
  final GetAllCommunicationUseCase getAllCommunicationUseCase;
  final AddCommunicationUseCase addCommunicationUseCase;
  final UpdateCommunicationUseCase updateCommunicationUseCase;
  CommunicationCubit({
    required this.updateCommunicationUseCase,
    required this.addCommunicationUseCase,
    required this.getAllCommunicationUseCase
}) : super(CommunicationInitial());
  List<Communication> communicationList = [];
  emitGetAllCommunicationUseCase()async{
    emit(GetAllCommunicationLoadingState());
    final failureOrListCommunication = await getAllCommunicationUseCase();
    failureOrListCommunication.fold((failure) =>emit(ErrorMessageCommunicationUserState(message: _mapFailureMessage(failure: failure))) , (communicationList) {
      this.communicationList = communicationList;
      emit(GetAllCommunicationLoadedDataState(communication: this.communicationList));
    },);
  }
  emitAddCommunicationUseCase({required Map data})async{
    emit(AddOrUpdateCommunicationLoadingState());
    final failureOrListCommunication = await addCommunicationUseCase(data: data);
    failureOrListCommunication.fold((failure) =>emit(ErrorMessageCommunicationUserState(message: _mapFailureMessage(failure: failure))) , (communicationList) {
      this.communicationList.add(communicationList);
      emit(GetAllCommunicationLoadedDataState(communication: this.communicationList));
    },);
  }
  emitUpdateCommunicationUseCase(
      {required Map data,required String content,required int id,required int index})async{
    emit(AddOrUpdateCommunicationLoadingState());
    final failureOrListCommunication = await updateCommunicationUseCase(data: data,id: id);
    failureOrListCommunication.fold((failure) =>emit(ErrorMessageCommunicationUserState(message: _mapFailureMessage(failure: failure))) , (communicationList) {
      this.communicationList[index].content = content;
      emit(GetAllCommunicationLoadedDataState(communication: this.communicationList));
    },);
  }
  String _mapFailureMessage({required Failure failure}) {
    switch (failure.runtimeType) {
      case InvalidDataFailureMessage:
        return failure.message??'';
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      case EmptyCacheFailure:
        return CACHE_FAILURE_MESSAGE;
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case InvalidDataFailure:
        return INVALID_DATA_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error, Please try again later .';
    }
  }
}
