
import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/util/snackbar_message.dart';
import 'package:edu_sphere/features/teacher/teacher_main/presentation/logic/teacher_main_cubit.dart';
import 'package:edu_sphere/features/teacher/teacher_main/presentation/logic/teacher_main_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class LoadingAddOrUpdateOrDeleteCourse extends StatelessWidget {
  String messageSuccessful;
   LoadingAddOrUpdateOrDeleteCourse({
    super.key,
    required this.messageSuccessful
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TeacherMainCubit,TeacherMainState>(listener: (context, state) {
      if(state is AddOrUpdateOrDeleteCourseLoadingState){
        context.loading();
      }else if(state is AddOrUpdateOrDeleteMessageSuccessState){
        context.pop();
        SnackBarMessage().showSnackBarError(message: state.message, context: context);
      }else if(state is AddCourseState){
        context.pop();
        context.pop();
        SnackBarMessage().showSnackBarSuccess(message: messageSuccessful, context: context);
      }
    },builder: (context, state) {
      return SizedBox.shrink();
    },);
  }
}
