import 'package:bloc/bloc.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/core/string/failure.dart';
import 'package:edu_sphere/features/auth/domain/entities/user.dart';
import 'package:edu_sphere/features/profile/domain/usecases/get_info_user.dart';
import 'package:edu_sphere/features/profile/domain/usecases/update_user.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final UpdateUserUseCase updateUserUseCase;
  final GetInfoUserUseCase getInfoUserUseCase;
  ProfileCubit({
    required this.updateUserUseCase,
    required this.getInfoUserUseCase
}) : super(ProfileInitial());
  User? user;
  bool genderIsMale = true;
  emitGetInfoUser()async{
    emit(GetInfoUserLoadingState());
    final failureOrUser = await getInfoUserUseCase();
    failureOrUser.fold((failure)=>emit(ErrorMessageGetInfoUserState(message: _mapFailureMessage(failure: failure))),
            (user){
          Logger().d('get info user ---->   $user');
          this.user = user;
          emit(GetInfoUserLoadedDataState(user: user));
        });
  }
  emitUpdateUser({required Map data,required String type})async{
    emit(UpdateUserLoadingState());
    final failureOrUser = await updateUserUseCase(data: data,type: type);
    failureOrUser.fold((failure)=>emit(ErrorMessageGetInfoUserState(message: _mapFailureMessage(failure: failure))),
            (user){
          Logger().d('update user ---->   $user');
          this.user = user;
          emit(GetInfoUserLoadedDataState(user: user));
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
