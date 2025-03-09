import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/routing/routes.dart';
import 'package:edu_sphere/core/widgets/image_and_text_empty_data.dart';
import 'package:edu_sphere/features/admin/admin_main/presentation/bloc/admin_main_cubit.dart';
import 'package:edu_sphere/features/admin/admin_main/presentation/bloc/admin_student_main_page/admin_student_main_cubit.dart';
import 'package:edu_sphere/features/admin/admin_main/presentation/widgets/shimmer_loading_student_admin.dart';
import 'package:edu_sphere/features/admin/student_main/presintation/bloc/student_admin_cubit.dart';
import 'package:edu_sphere/features/teacher/teacher_main/presentation/widgets/section_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:edu_sphere/core/theming/colors.dart';

class AdminMainStudentWidget extends StatelessWidget {
  const AdminMainStudentWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminStudentMainCubit,AdminStudentMainState>(builder: (context, state) {
      if(state is GetAllStudentInAdminLoadingState){
        return ShimmerLoadingStudentAdmin();
      }else if(state is GetAllStudentInAdminLoadedState){
        return state.listStudent.isNotEmpty?
        SectionCard(
          title: 'Students',
          icon: 'assets/svgs/university_teacher.svg',
          isNotShowColorSvg:false,
          widget: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: state.listStudent.length,
            itemBuilder: (context, index) {
              return ListTile(
                  onTap: (){
                    context.pushNamed(Routes.informationStudentAdminPage);
                    context.read<AdminMainCubit>().selectedStudent = state.listStudent[index];
                    context.read<StudentAdminCubit>().emitGetInformationStudent(idStudent: state.listStudent[index].id);

                  },
                  title: Text(state.listStudent[index].name),
                  leading: CircleAvatar(
                      backgroundColor: ColorsManager.neutralGray.withOpacity(0.3),
                      radius: 15,
                      child: Icon(Icons.person,color: ColorsManager.neutralGray,size: 15,),),
              );
            },),
        )
            :SectionCard( title: 'Students',
            icon: 'assets/svgs/university_teacher.svg', widget: ImageAndTextEmptyData(
            message: 'There is no Student yet'));
      }else{
        return context.read<AdminMainCubit>().listTeacher.isNotEmpty?
        SectionCard(
          title: 'Students',
          icon: 'assets/svgs/university_teacher.svg',
          widget: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount:  context.read<AdminStudentMainCubit>().listStudent.length,
            itemBuilder: (context, index) {
              return ListTile(
                  onTap: (){
                      context.pushNamed(Routes.informationStudentAdminPage);
                    context.read<AdminMainCubit>().selectedStudent = context.read<AdminStudentMainCubit>().listStudent[index];
                    context.read<StudentAdminCubit>().emitGetInformationStudent(idStudent: context.read<AdminStudentMainCubit>().listStudent[index].id);

                  },
                  title: Text( context.read<AdminMainCubit>().listTeacher[index].name),
                  leading: CircleAvatar(
                      backgroundColor: ColorsManager.neutralGray.withOpacity(0.3),
                      radius: 15,
                      child: Icon(Icons.person,color: ColorsManager.neutralGray,size: 15,))
              );
            },),
        ):SectionCard(title: 'Students',
            icon: 'assets/svgs/university_teacher.svg', widget: ImageAndTextEmptyData(
            message: 'There is no Student yet'));
      }
    },);
  }
  }
  //   return SectionCard(
  //     title: 'Students',
  //     icon: 'assets/svgs/university_teacher.svg',
  //     widget: ImageAndTextEmptyData(
  //         message: 'There is no students yet'),
  //   );
  // }

