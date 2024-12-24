import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/core/string/failure.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/features/teacher/course_main/domain/entities/advertisement.dart';
import 'package:edu_sphere/features/teacher/course_main/domain/usecases/advertisement_usecase/add_advertisement.dart';
import 'package:edu_sphere/features/teacher/course_main/domain/usecases/advertisement_usecase/delete_advertisement.dart';
import 'package:edu_sphere/features/teacher/course_main/domain/usecases/advertisement_usecase/get_all_advertisement.dart';
import 'package:edu_sphere/features/teacher/course_main/domain/usecases/advertisement_usecase/update_advertisement.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';

part 'course_advertisement_state.dart';

class CourseAdvertisementCubit extends Cubit<CourseAdvertisementState> {
  CourseAdvertisementCubit({
    required this.updateAdvertisementUseCase,
    required this.addAdvertisementUseCase,
    required this.deleteAdvertisementUseCase,
    required this.getAllAdvertisementUseCase
}) : super(CourseAdvertisementInitial());
  final GetAllAdvertisementUseCase getAllAdvertisementUseCase;
  final DeleteAdvertisementUseCase deleteAdvertisementUseCase;
  final AddAdvertisementUseCase addAdvertisementUseCase;
  final UpdateAdvertisementUseCase updateAdvertisementUseCase;
  List<Advertisement> advertisementList=[];
  emitChangColorTextField({required Color color}) {
    colorSelectedTextField = color;
    emit(ChangColorTextInTextField(colorSelect: color));
  }
  Color colorSelectedTextField = ColorsManager.mainBlue;
  TextEditingController advertisementTextEditionController = TextEditingController();
  final globalAdvertisementKey = GlobalKey<FormState>();
  emitGetAllAdvertisement({required int idCourse})async{
    emit(GetAllAdvertisementLoadingState());
    Logger().e('--------------------------------');
    final failureOrAdvertisement = await getAllAdvertisementUseCase(idCourse:idCourse);
    failureOrAdvertisement.fold((failure)=>emit(AdvertisementMessageErrorState(message: _mapFailureMessage(failure: failure))), (advertisement){
      Logger().d(advertisement);
      advertisementList = advertisement;

      emit(GetAllAdvertisementLoadedState(advertisement: advertisementList));
    }) ;
  }
  emitAddAdvertisement({required int idCourse})async{
    emit(AddOrUpdateOrDeleteLoadingState());
    Logger().e('--------------------------------${colorSelectedTextField.toString()}');
    final failureOrAdvertisement = await addAdvertisementUseCase(idCourse: idCourse,data:{
      'text':advertisementTextEditionController.text,
      'color':colorSelectedTextField.toString()
    } );
    failureOrAdvertisement.fold((failure)=>emit(AdvertisementMessageErrorState(message: _mapFailureMessage(failure: failure))), (advertisement){
      Logger().d(advertisement);
      advertisementList.add(advertisement);
      advertisementTextEditionController = TextEditingController();
       colorSelectedTextField = ColorsManager.mainBlue;
      emit(GetAllAdvertisementLoadedState(advertisement: advertisementList));
    }) ;
  }

  String _mapFailureMessage({required Failure failure}) {
    switch (failure.runtimeType) {
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      case EmptyCacheFailure:
        return CACHE_FAILURE_MESSAGE;
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case InvalidDataFailure:
        return INVALID_DATA_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error, Please try again later .';
    }
  }
}
