import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/routing/app_router.dart';
import 'package:edu_sphere/core/routing/routes.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/util/toast_notification_message.dart';
import 'package:edu_sphere/core/widgets/app_text_button.dart';
import 'package:edu_sphere/core/widgets/loading_widget.dart';
import 'package:edu_sphere/core/widgets/wave_top_widget.dart';
import 'package:edu_sphere/edu_sphere_app.dart';
import 'package:edu_sphere/features/auth/presentation/bloc/auth/auth_cubit.dart';
import 'package:edu_sphere/features/auth/presentation/widgets/login_widgets/email_and_password_widget.dart';
import 'package:edu_sphere/features/auth/presentation/widgets/login_widgets/login_form_widget.dart';
import 'package:edu_sphere/features/auth/presentation/widgets/login_widgets/remember_forget_password_widget.dart';
import 'package:edu_sphere/features/auth/presentation/widgets/login_widgets/text_account_signup_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
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
            context.pop();
          ToastNotificationMessage()
              .showToastNotificationError(message: state.message, context: context);
          }else if(state is AuthLoadedState){
            context.read<AuthCubit>().getCurrentUserUseCase();
            context.pushReplacementNamed(Routes.studentRequestPage);
          }else if(state is AuthLoadingState){
            context.loading();

          }
        },
        builder: (context, state) {

          return const LoginFormWidget();

        },
      );
  }
}

