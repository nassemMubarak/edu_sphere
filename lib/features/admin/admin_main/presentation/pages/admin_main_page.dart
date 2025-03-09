import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/widgets/sliver_widget.dart';
import 'package:edu_sphere/features/admin/admin_main/presentation/bloc/admin_main_cubit.dart';
import 'package:edu_sphere/features/admin/admin_main/presentation/bloc/admin_student_main_page/admin_student_main_cubit.dart';
import 'package:edu_sphere/features/admin/admin_main/presentation/widgets/admin_main_student_widget.dart';
import 'package:edu_sphere/features/admin/admin_main/presentation/widgets/admin_main_teacher_widget.dart';
import 'package:edu_sphere/features/admin/requests_admin/presentation/bloc/request_admin_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminMainPage extends StatelessWidget {
  const AdminMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AdminMainCubit>().emitGetAllTeacherInAdmin();
    context.read<AdminStudentMainCubit>().emitGetAllStudentInAdmin();
    context.read<RequestAdminCubit>().emitGetAllRequestAdmin();

    return SliverWidget(
      widget: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            AdminMainTeacherWidget(),
            verticalSpace(24),
            AdminMainStudentWidget(),
          ],
        ),
      ),
      
    );
  }
}


