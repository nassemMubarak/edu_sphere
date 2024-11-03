import 'package:edu_sphere/features/signup/logic/sign_up_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpCubit extends Cubit<SignUpState> {
  String? typeSignUp;
  SignUpCubit() : super(SignUpState.initial());
  
  void emitChangTypSignUp(String type) {
    typeSignUp= type;
    emit(StatusSignUpType(type));
  }
  void emitChangTypeOnClicBotton(String type) {
    typeSignUp = type;
    emit(StatusSignUpTypeOnClicBotton(type));
  }
}
