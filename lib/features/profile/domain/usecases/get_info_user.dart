import 'package:dartz/dartz.dart';
import 'package:edu_sphere/features/profile/domain/repositorises/profile_repository.dart';

import '../../../../core/error/failure.dart';
import '../../../auth/domain/entities/user.dart';

class GetInfoUserUseCase{
  final ProfileRepository profileRepository;
  GetInfoUserUseCase({required this.profileRepository});
  Future<Either<Failure,User>> call()async{
   return await profileRepository.getInfoUser();
  }
}