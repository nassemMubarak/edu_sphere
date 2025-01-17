import 'package:dartz/dartz.dart';
import 'package:edu_sphere/features/profile/domain/repositorises/profile_repository.dart';
import 'package:logger/logger.dart';

import '../../../../core/error/failure.dart';
import '../../../auth/domain/entities/user.dart';

class UpdateUserUseCase{
  final ProfileRepository profileRepository;
  UpdateUserUseCase({required this.profileRepository});
  Future<Either<Failure,User>> call({required Map data,required String type})async{
    Logger().w('---------type______________$type');
   return await profileRepository.updateUser(data: data,type: type);
  }
}