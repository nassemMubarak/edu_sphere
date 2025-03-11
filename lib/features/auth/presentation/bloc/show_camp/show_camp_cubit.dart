import 'package:bloc/bloc.dart';
import 'package:edu_sphere/features/auth/domain/entities/camp.dart';
import 'package:edu_sphere/features/auth/domain/usecases/show_camp.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/string/failure.dart';

part 'show_camp_state.dart';

class ShowCampCubit extends Cubit<ShowCampState> {
  final ShowCampUseCase showCampUseCase;

  ShowCampCubit({
    required this.showCampUseCase,

  }) : super(ShowCampInitial());
  emitShowCamp()async{
    Logger().f('-----------------------------------');
    emit(ShowCampLoginLoadingState());
    final failureOrCamp = await showCampUseCase();
    failureOrCamp.fold((failure) {
      Logger().e('----failure---------------------------------------$failure');

      emit(
          ShowCampMessageErrorState(message: _mapFailureMessage(failure: failure)));
    }, (camp) {
      Logger().e('camp-------------------$camp');
      emit(ShowCampLoadedState(camp: camp));
    },);
  }
  String _mapFailureMessage({required Failure failure}) {
    switch (failure.runtimeType) {
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      case EmptyCacheFailure:
        return CACHE_FAILURE_MESSAGE;
      case InvalidDataFailureMessage:
        return failure.message??'';
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case InvalidDataFailure:
        return INVALID_DATA_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error, Please try again later .';
    }
  }

}
