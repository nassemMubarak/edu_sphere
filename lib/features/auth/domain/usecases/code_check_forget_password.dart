import 'package:dartz/dartz.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/features/auth/domain/repositorises/repository.dart';

class CodeCheckForgetPasswordUseCase{
  final AuthRepository authRepository;

  CodeCheckForgetPasswordUseCase({required this.authRepository});

  Future<Either<Failure,Unit>> call({required String code})async{
    return await authRepository.codeCheckForgetPassword(code: code);
  }

}