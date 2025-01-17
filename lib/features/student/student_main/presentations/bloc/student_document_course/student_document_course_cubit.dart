import 'package:bloc/bloc.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/core/string/failure.dart';
import 'package:edu_sphere/features/student/student_main/domain/usecases/get_all_student_document_course.dart';
import 'package:edu_sphere/features/teacher/assessments/domain/entities/document_assessment.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';

part 'student_document_course_state.dart';

class StudentDocumentCourseCubit extends Cubit<StudentDocumentCourseState> {
  final GetAllStudentDocumentCourseUseCase getAllStudentDocumentCourseUseCase;
  StudentDocumentCourseCubit({
    required this.getAllStudentDocumentCourseUseCase
}) : super(StudentDocumentCourseInitial());
  List<DocumentAssessment> documentList=[];
  emitGetAllDocumentToCourse({required int idCourse})async{
    emit(GetAllStudentDocumentToCourseLoadingState());
    final failureOrDocuments = await getAllStudentDocumentCourseUseCase(idCourse: idCourse);
    failureOrDocuments.fold((failure)=>emit(GetAllStudentDocumentToCourseMessageErrorState(message: _mapFailureMessage(failure: failure))), (documents){
      Logger().f('documents----------------->documents');
      documentList = documents;
      emit(GetAllStudentDocumentToCourseLoadedState(documents: documentList));
    });
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
