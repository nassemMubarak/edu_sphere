import 'package:dartz/dartz.dart';
import 'package:edu_sphere/core/error/exception.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/core/helpers/constants.dart';
import 'package:edu_sphere/core/helpers/shared_pref_helper.dart';
import 'package:edu_sphere/core/networking/network_info.dart';
import 'package:edu_sphere/features/communication/data/datasource/communication_remote_data_source.dart';
import 'package:edu_sphere/features/communication/domain/entities/communication.dart';
import 'package:edu_sphere/features/communication/domain/repositorises/communication_repository.dart';

class CommunicationRepositoryImpl implements CommunicationRepository{
  final NetworkInfo networkInfo;
  final CommunicationRemoteDataSource remoteDataSourceImpl;
  CommunicationRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSourceImpl
});
  @override
  Future<Either<Failure, List<Communication>>> getAllCommunication() async{
    if(await networkInfo.isConnected){
      try{
        final String token = await SharedPrefHelper.getString(SharedPrefKeys.cachedToken);
        final String type = await SharedPrefHelper.getString(SharedPrefKeys.cachedTypeUser);
        bool isStudent = type.toUpperCase()=='STUDENT';
        final listCommunication = await remoteDataSourceImpl.getAllCommunication( token: token,isStudent: isStudent);
        return Right(listCommunication);
      }on InvalidDataExceptionMessage catch (e){
        return Left(InvalidDataFailureMessage(message:e.message ));
      }
    }else{
      return Left(OfflineFailure());
    }
  }
  @override
  Future<Either<Failure, Communication>> addCommunication({required Map data})async {
    if(await networkInfo.isConnected){
      try{
        final String token = await SharedPrefHelper.getString(SharedPrefKeys.cachedToken);
        final String type = await SharedPrefHelper.getString(SharedPrefKeys.cachedTypeUser);
        bool isStudent = type.toUpperCase()=='STUDENT';

        final communication = await remoteDataSourceImpl.addCommunication(isStudent: isStudent, data: data,token: token);
        return Right(communication);
      }on InvalidDataExceptionMessage catch (e){
        return Left(InvalidDataFailureMessage(message:e.message ));
      }
    }else{
      return Left(OfflineFailure());
    }
  }


  @override
  Future<Either<Failure, Unit>> updateCommunication({required Map data,required int id}) async{
    if(await networkInfo.isConnected){
      try{
        final String token = await SharedPrefHelper.getString(SharedPrefKeys.cachedToken);
        final String type = await SharedPrefHelper.getString(SharedPrefKeys.cachedTypeUser);
        bool isStudent = type.toUpperCase()=='STUDENT';

        await remoteDataSourceImpl.updateCommunication(isStudent: isStudent, data: data,token: token,id:id);
        return const Right(unit);
      }on InvalidDataExceptionMessage catch (e){
        return Left(InvalidDataFailureMessage(message:e.message ));
      }
    }else{
      return Left(OfflineFailure());
    }
  }

}