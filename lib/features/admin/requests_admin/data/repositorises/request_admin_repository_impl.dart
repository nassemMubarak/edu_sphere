import 'package:dartz/dartz.dart';
import 'package:edu_sphere/core/error/exception.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/core/helpers/constants.dart';
import 'package:edu_sphere/core/helpers/shared_pref_helper.dart';
import 'package:edu_sphere/core/networking/network_info.dart';
import 'package:edu_sphere/features/admin/requests_admin/data/datasource/request_admin_remote_datasource.dart';
import 'package:edu_sphere/features/admin/requests_admin/data/model/request_model.dart';
import 'package:edu_sphere/features/admin/requests_admin/domain/repositorises/request_admin_repository.dart';
 class RequestAdminRepositoryImpl implements RequestAdminRepository{
   final NetworkInfo networkInfo;
   final RequestAdminRemoteDataSourceImpl remoteDataSourceImpl;
   RequestAdminRepositoryImpl({required this.networkInfo,required this.remoteDataSourceImpl});

   @override
  Future<Either<Failure, List<RequestModel>>> getAllRequestAdmin() async{
     if (await networkInfo.isConnected) {
       try {
         final String token =
             await SharedPrefHelper.getString(SharedPrefKeys.cachedToken);
         final listRequest = await remoteDataSourceImpl.getAllRequestAdmin(token: token);
         return Right(listRequest);
       } on InvalidDataExceptionMessage catch (e) {
         return Left(InvalidDataFailureMessage(message: e.message));
       } on ServerException {
         return Left(ServerFailure());
       }
     } else {
       return Left(OfflineFailure());
     }
  }

  @override
  Future<Either<Failure, Unit>> replayRequest({required bool acceptRequest,required int idRequest}) async{
    if (await networkInfo.isConnected) {
      try {
        final String token =
            await SharedPrefHelper.getString(SharedPrefKeys.cachedToken);
        await remoteDataSourceImpl.replayRequest(acceptRequest: acceptRequest,token: token,idRequest: idRequest);
        return const Right(unit);
      } on InvalidDataExceptionMessage catch (e) {
        return Left(InvalidDataFailureMessage(message: e.message));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}