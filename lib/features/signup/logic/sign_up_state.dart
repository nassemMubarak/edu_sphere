import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_state.freezed.dart';

@freezed
class SignUpState<T> with _$SignUpState<T> {
  const factory SignUpState.initial() = _Initial;
  
  const factory SignUpState.statusSignUpType(String type) = StatusSignUpType;
  const factory SignUpState.statusSignUpTypeOnClicBotton(String type) = StatusSignUpTypeOnClicBotton;

}
