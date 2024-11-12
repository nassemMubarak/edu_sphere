import 'package:edu_sphere/features/signup/logic/sign_up_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpCubit extends Cubit<SignUpState> {
  String? typeSignUp;
  late bool isContinue;
  SignUpCubit() : super(SignUpState.initial());

  void emitChangTypSignUp(String type) {
    typeSignUp= type;
    isContinue = true;
    emit(StatusSignUpType(type));
  }
  void emitChangTypeOnClicBotton(String type) {
    isContinue = false;
    typeSignUp = type;
    emit(StatusSignUpTypeOnClicBotton(type));
  }
}
