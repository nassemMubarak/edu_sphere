import 'package:bloc/bloc.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/features/admin/requests_admin/domain/usecases/get_all_request_admin.dart';
import 'package:edu_sphere/features/admin/requests_admin/domain/usecases/replay_request.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';

import '../../../../../../core/string/failure.dart';

part 'accept_or_reject_request_state.dart';

class AcceptOrRejectRequestCubit extends Cubit<AcceptOrRejectRequestState> {
  ReplayRequestUseCase replayRequestUseCase;
  AcceptOrRejectRequestCubit({required this.replayRequestUseCase}) : super(AcceptOrRejectRequestInitial());
  emitReplyRequest({required bool acceptRequest,required int idRequest})async{
    emit(ReplayRequestLoadingState());
    final failureOrAdvertisement = await replayRequestUseCase(acceptRequest:acceptRequest,idRequest: idRequest );
    failureOrAdvertisement.fold((failure)=>emit(ErrorMessageReplayRequestState(message: _mapFailureMessage(failure: failure))),
            (requestModel){
      Logger().f('reply successfully');
          emit(ReplayRequestLoadedDataState());
        });
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
