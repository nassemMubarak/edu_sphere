import 'package:bloc/bloc.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/core/string/failure.dart';
import 'package:edu_sphere/features/admin/requests_admin/data/model/request_model.dart';
import 'package:edu_sphere/features/admin/requests_admin/domain/usecases/get_all_request_admin.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';

part 'request_admin_state.dart';

class RequestAdminCubit extends Cubit<RequestAdminState> {
  GetAllRequestAdminUseCase getAllRequestAdminUseCase;
  RequestAdminCubit({required this.getAllRequestAdminUseCase}) : super(RequestAdminInitial());
  List<RequestModel> listRequestModel = [];
  RequestModel? requestModelSelected;
  emitGetAllRequestAdmin()async{
    emit(GetAllRequestAdminLoadingState());
    final failureOrAdvertisement = await getAllRequestAdminUseCase();
    failureOrAdvertisement.fold((failure)=>emit(ErrorRequestAdminState(message: _mapFailureMessage(failure: failure))),
            (requestModel){
          Logger().d('requestModel  list ---->   $requestModel');
          listRequestModel = requestModel;
          emit(GetAllRequestAdminLoadedState(listRequest: listRequestModel));
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
