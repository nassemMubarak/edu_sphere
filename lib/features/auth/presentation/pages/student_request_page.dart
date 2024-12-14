import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/util/snackbar_message.dart';
import 'package:edu_sphere/core/widgets/loading_widget.dart';
import 'package:edu_sphere/features/auth/presentation/bloc/auth/auth_cubit.dart';
import 'package:edu_sphere/features/auth/presentation/widgets/student_request_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class StudentRequestPage extends StatelessWidget {
  const StudentRequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }
  Widget _buildBody(){
    return BlocBuilder<AuthCubit,AuthState> (
      builder: (context, state) {
        if (state is AuthLoadingState) {
          return const LoadingWidget();
        }else if(state is AuthLoadedState){
          return  StudentRequestWidget(user:state.user);
        }
        else{
          return SizedBox();
        }

      },
    );
  }
}
