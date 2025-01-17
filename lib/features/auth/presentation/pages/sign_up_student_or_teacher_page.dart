import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/routing/routes.dart';
import 'package:edu_sphere/core/util/toast_notification_message.dart';
import 'package:edu_sphere/core/widgets/loading_widget.dart';
import 'package:edu_sphere/edu_sphere_app.dart';
import 'package:edu_sphere/features/auth/presentation/bloc/auth/auth_cubit.dart';
import 'package:edu_sphere/features/auth/presentation/widgets/signup_widgets/sign_up_or_student_teacher_widget.dart';
import 'package:edu_sphere/features/auth/presentation/widgets/signup_widgets/signup_loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class SignUpStudentOrTeacherPage extends StatelessWidget {
  const SignUpStudentOrTeacherPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthCubit>().emitGetAllCamp();
    return Scaffold(
      body: _buildBody(),
    );
  }
  Widget _buildBody(){
    return SignupLoadingWidget();
  }

}
