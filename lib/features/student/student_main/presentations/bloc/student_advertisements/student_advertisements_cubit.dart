import 'package:bloc/bloc.dart';
import 'package:edu_sphere/features/student/student_main/domain/usecases/get_all_student_advertisement_course.dart';
import 'package:edu_sphere/features/teacher/course_main/domain/entities/advertisement.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';

import '../../../../../../core/error/failure.dart';
import '../../../../../../core/string/failure.dart';

part 'student_advertisements_state.dart';

class StudentAdvertisementsCubit extends Cubit<StudentAdvertisementsState> {
  final GetAllStudentAdvertisementUseCase getAllStudentAdvertisementUseCase;
  StudentAdvertisementsCubit({
    required this.getAllStudentAdvertisementUseCase
}) : super(StudentAdvertisementsInitial());
  List<Advertisement> advertisementList=[];
  emitGetAllAdvertisement({required int idCourse})async{
    emit(GetAllStudentAdvertisementsLoadingState());
    final failureOrAdvertisement = await getAllStudentAdvertisementUseCase(idCourse:idCourse);
    failureOrAdvertisement.fold((failure)=>emit(GetAllStudentAdvertisementsMessageErrorState(message: _mapFailureMessage(failure: failure))), (advertisement){
      Logger().d(advertisement);
      advertisementList = advertisement;

      emit(GetAllStudentAdvertisementsLoadedState(advertmints: advertisementList));
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
