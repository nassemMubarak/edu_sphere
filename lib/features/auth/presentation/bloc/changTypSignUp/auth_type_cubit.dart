import 'package:dartz/dartz.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/core/string/failure.dart';
import 'package:edu_sphere/features/auth/domain/entities/user.dart';
import 'package:edu_sphere/features/auth/domain/usecases/get_current_user.dart';
import 'package:edu_sphere/features/auth/domain/usecases/login_user.dart';
import 'package:edu_sphere/features/auth/domain/usecases/register_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_type_state.dart';

class AuthTypeCubit extends Cubit<AuthTypeState> {

  AuthTypeCubit()
      : super(AuthInitial());
  String? typeSignUp='student';
  late bool isContinue;

  void emitChangTypSignUp(String type) {
    typeSignUp = type;
    isContinue = true;
    emit(StatusSignUpType(type: type));
  }

  void emitChangTypeOnClickButton(String type) {
    isContinue = false;
    typeSignUp = type;
    emit(StatusSignUpTypeOnClickButton(type: type));
  }

}
