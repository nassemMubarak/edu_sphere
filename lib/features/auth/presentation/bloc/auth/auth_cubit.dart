import 'package:dartz/dartz.dart';
import 'package:edu_sphere/core/error/failure.dart';
import 'package:edu_sphere/core/string/failure.dart';
import 'package:edu_sphere/features/auth/domain/entities/camp.dart';
import 'package:edu_sphere/features/auth/domain/entities/user.dart';
import 'package:edu_sphere/features/auth/domain/usecases/get_all_camp.dart';
import 'package:edu_sphere/features/auth/domain/usecases/get_current_user.dart';
import 'package:edu_sphere/features/auth/domain/usecases/login_user.dart';
import 'package:edu_sphere/features/auth/domain/usecases/register_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final globalKey = GlobalKey<FormState>();
  final globalKeyRegisterScreen = GlobalKey<FormState>();
  final globalKeyStudentScreen = GlobalKey<FormState>();
  final globalKeyTeacherScreen = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController emailRegisterController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordRegisterController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
   String? studentEducationStage;
   String? campStudentId;
  late TextEditingController ageStudentTextEditingController = TextEditingController();
   String? campTeacherId;
  late TextEditingController teacherUniversityMajor = TextEditingController();
  late TextEditingController ageTeacherTextEditingController = TextEditingController();
  bool genderIsMale = true;

  final LoginUserUseCase loginUserUseCase;
  final GetAllCampUseCase getAllCampUserUseCase;
  final RegisterUserUseCase registerUserUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;

  AuthCubit(
      {required this.loginUserUseCase,
      required this.getCurrentUserUseCase,
      required this.registerUserUseCase,
      required this.getAllCampUserUseCase,
      })
      : super(AuthInitial());

  emitGetCurrentUser() async {
    emit(AuthLoadingState());
    final failureOrUser = await getCurrentUserUseCase();
    emit(failureOrUser.fold(
      (_) => AuthInitial(),
      (user) => AuthLoadedState(user: user),
    ));
  }

  emitLoginUser() async {
    emit(AuthLoadingState());
    final failureOrUser = await loginUserUseCase(authData: {
      'email': emailController.text,
      'password': passwordController.text
    });
    emit(_eitherFailureOrUser(failureOrUser));
  }
  emitGetAllCamp()async{
    final failureOrListCamp = await getAllCampUserUseCase();
    failureOrListCamp.fold(
          (failure) =>
          emit(AuthMessageErrorCampState(message: _mapFailureMessage(failure: failure))),
          (camps) => emit(GetAllCampsLoadedState(camp: camps)),
    );
  }

  emitRegisterUser({bool isStudent=false,bool isTeacher = false,bool isCamp = false }) async {
    emit(AuthLoadingState());
   var bodyStudent = {
      'name': nameController.text,
      'email': emailRegisterController.text,
      'password': passwordRegisterController.text,
      'password_confirmation': passwordRegisterController.text,
      'age': ageStudentTextEditingController.text,
      'sex': genderIsMale?'male':'female',
      'phone_number': '0592815701',
      'camp_id': campStudentId,
      'level': studentEducationStage,
     // 'name': 'Nassem Mubarak',
     // 'email': '787878@gmail.com',
     // 'password': 'nassemmubarak',
     // 'password_confirmation': 'nassemmubarak',
     // 'age': '20',
     // 'sex': 'male',
     // 'phone_number': '0592815201',
     // 'camp_id': '4',
     // 'level': '10',
    };
   var bodyCamp = {

     'name': 'Nassem Mubarak',
     'email': 'nassemmubarak1qq2q3@gmail.com',
     'password': 'nassemmubarak',
     'password_confirmation': 'nassemmubarak',
     'age': '20',
     'sex': 'male',
     'phone_number': '0592815201',
     'camp_id': '4',
     'level': '10',
    };
   var bodyTeacher = {
     'name': nameController.text,
     'email': emailRegisterController.text,
     'password': passwordRegisterController.text,
     'password_confirmation': passwordRegisterController.text,
     'age': ageTeacherTextEditingController.text,
     'sex': genderIsMale?'male':'female',
     'phone_number': '0592815701',
     'specialization': teacherUniversityMajor.text,
     'camp_id': campTeacherId,
     // 'name': 'Nassem111 Mubarak',
     // 'email': '2222222@gmail.com',
     // 'password': 'nassemmubarak',
     // 'password_confirmation': 'nassemmubarak',
     // 'age': '20',
     // 'sex': 'male',
     // 'phone_number': '0592815201',
     // 'specialization': 'math',
     'level': null,

   };

    // var body = {
    //  'name': nameController.text,
    //  'email': emailRegisterController.text,
    //  'password': passwordRegisterController.text,
    //  'password_confirmation': passwordRegisterController.text,
    //  'age': ageStudentTextEditingController.text,
    //  'sex': genderIsMale?'male':'female',
    //  'phone_number': '0592815701',
    //  'camp_id': campStudentId,
    //  'level': studentEducationStage,
    // };
    final failureOrUser = await registerUserUseCase(authData: isStudent?bodyStudent:isTeacher?bodyTeacher:bodyCamp);
     emit(_eitherFailureOrUser(failureOrUser));
  }

  _eitherFailureOrUser(Either<Failure, User> either) {
    return either.fold(
      (failure) =>
          AuthMessageErrorState(message: _mapFailureMessage(failure: failure)),
      (user) => AuthLoadedState(user: user),
    );
  }

  String _mapFailureMessage({required Failure failure}) {
    Logger().f(failure.message);
    switch (failure.runtimeType) {
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      case EmptyCacheFailure:
        return CACHE_FAILURE_MESSAGE;
      case InvalidDataFailureMessage:
        return failure.message??'';
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case InvalidDataFailure:
        return INVALID_DATA_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error, Please try again later .';
    }
  }
}
