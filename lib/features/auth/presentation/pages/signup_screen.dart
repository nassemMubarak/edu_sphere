import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/routing/routes.dart';
import 'package:edu_sphere/core/util/toast_notification_message.dart';
import 'package:edu_sphere/core/widgets/loading_widget.dart';
import 'package:edu_sphere/features/auth/presentation/bloc/auth/auth_cubit.dart';
import 'package:edu_sphere/features/auth/presentation/widgets/signup_widgets/signup_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }
  Widget _buildBody(){
    return BlocConsumer<AuthCubit,AuthState> (
      listener: (context, state) {
        if(state is AuthMessageSuccessState){
          ToastNotificationMessage()
              .showNotificationSuccess(message: state.message, context: context);
        }else if(state is AuthMessageErrorState){
          ToastNotificationMessage()
              .showToastNotificationError(message: state.message, context: context);
        }else if(state is AuthLoadedState){
          context.read<AuthCubit>().getCurrentUserUseCase();
          context.pushReplacementNamed(Routes.studentRequestPage);
        }
      },
      builder: (context, state) {
        if (state is AuthLoadingState) {
          return const LoadingWidget();
        }
        return const SignupWidget();

      },
    );
  }

}
