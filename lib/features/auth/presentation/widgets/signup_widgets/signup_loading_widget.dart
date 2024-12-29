import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/routing/routes.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/util/toast_notification_message.dart';
import 'package:edu_sphere/core/widgets/loading_widget.dart';
import 'package:edu_sphere/features/auth/presentation/bloc/auth/auth_cubit.dart';
import 'package:edu_sphere/features/auth/presentation/widgets/signup_widgets/sign_up_or_student_teacher_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class SignupLoadingWidget extends StatelessWidget {
  const SignupLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit,AuthState> (
      listener: (context, state) {
        if(state is AuthMessageSuccessState){
          ToastNotificationMessage()
              .showNotificationSuccess(message: state.message, context: context);
        }else if(state is AuthMessageErrorState){
          context.pop();
          ToastNotificationMessage()
              .showToastNotificationError(message: state.message, context: context);
        }else if(state is AuthLoadedState){
          context.read<AuthCubit>().getCurrentUserUseCase();
          context.pushReplacementNamed(Routes.studentRequestPage);
        }else if(state is AuthLoadingState){
        context.loading();
        }else if(state is AuthMessageErrorCampState){
          ToastNotificationMessage()
              .showToastNotificationError(message: state.message, context: context);
        }
      },
      builder: (context, state) {
        return const SignUpStudentOrTeacherWidget();
      },
    );
  }
}
