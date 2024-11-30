import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/core/string/failure.dart';
import 'package:edu_sphere/features/auth/domain/entities/user.dart';
import 'package:edu_sphere/features/auth/domain/usecases/get_current_user.dart';
import 'package:edu_sphere/features/auth/domain/usecases/login_user.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.loginUserUseCase, required this.getCurrentUserUseCase}) : super(AuthInitial());
  final LoginUserUseCase loginUserUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;

  emitLoginUser({required Map authData})async{
    emit(AuthLoadingState());
    final failureOrUser = await loginUserUseCase(authData: authData);
    return failureOrUser.fold(
        (failure)=>
          AuthMessageErrorState(message: _mapFailureMessage(failure: failure)),
          (user) => AuthLoadedState(user: user),

    );
  }
  String _mapFailureMessage({required Failure failure}) {
    switch (failure.runtimeType) {
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

