import 'package:dartz/dartz.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/features/auth/domain/repositorises/repository.dart';

class SendCodeToForgetPasswordUseCase{
  final AuthRepository authRepository;

  SendCodeToForgetPasswordUseCase({required this.authRepository});

  Future<Either<Failure,Unit>> call({required String email})async{
    return await authRepository.sendCodeToForgetPassword(email: email);
  }

}