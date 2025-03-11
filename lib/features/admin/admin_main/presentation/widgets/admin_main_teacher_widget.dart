import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/routing/routes.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/widgets/image_and_text_empty_data.dart';
import 'package:edu_sphere/features/admin/admin_main/presentation/bloc/admin_main_cubit.dart';
import 'package:edu_sphere/features/admin/admin_main/presentation/widgets/shimmer_loading_teacher_admin.dart';
import 'package:edu_sphere/features/admin/teacher_admin/presintation/bloc/teacher_admin_cubit.dart';
import 'package:edu_sphere/features/teacher/teacher_main/presentation/widgets/section_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminMainTeacherWidget extends StatelessWidget {
  const AdminMainTeacherWidget({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminMainCubit,AdminMainState>(builder: (context, state) {
      if(state is GetAllTeacherInAdminLoadingState){
        return  ShimmerLoadingTeacherAdmin();
      }else if(state is GetAllTeacherInAdminLoadedState){
       return state.listTeacher.isNotEmpty?
       SectionCard(
         title: 'Teachers',
         icon: 'assets/svgs/type_of_teaching.svg',
         isNotShowColorSvg:false,
         widget: ListView.builder(
           shrinkWrap: true,
           physics: NeverScrollableScrollPhysics(),
           itemCount: state.listTeacher.length,
           itemBuilder: (context, index) {
             return ListTile(
               onTap: (){
                 context.pushNamed(Routes.informationTeacherPage);
                 context.read<AdminMainCubit>().selectedTeacher = state.listTeacher[index];
                 context.read<TeacherAdminCubit>().emitGetInformationTeacher(idTeacher: state.listTeacher[index].id);
               },
                 leading: CircleAvatar(
                     backgroundColor: ColorsManager.neutralGray.withOpacity(0.3),
                     radius: 15,
                     child: Icon(Icons.person,color: ColorsManager.neutralGray,size: 15,)),

                 title: Text(state.listTeacher[index].name));
           },),
       )
           :SectionCard(
         title: 'Teachers',
         icon: 'assets/svgs/type_of_teaching.svg',
             widget: ImageAndTextEmptyData(
              message: 'There is no Teacher yet'),
           );
      }else{
       return context.read<AdminMainCubit>().listTeacher.isNotEmpty?
       SectionCard(
         isNotShowColorSvg:false,
         title: 'Teachers',
         icon: 'assets/svgs/type_of_teaching.svg',
         widget: ListView.builder(
           shrinkWrap: true,
           physics: NeverScrollableScrollPhysics(),
            itemCount:  context.read<AdminMainCubit>().listTeacher.length,
            itemBuilder: (context, index) {
              return ListTile(
                  onTap: (){
                    context.pushNamed(Routes.informationTeacherPage);
                    context.read<AdminMainCubit>().selectedTeacher = context.read<AdminMainCubit>().listTeacher[index];
                    context.read<TeacherAdminCubit>().emitGetInformationTeacher(idTeacher: context.read<AdminMainCubit>().listTeacher[index].id);

                  },
                  leading: CircleAvatar(
                      backgroundColor: ColorsManager.neutralGray.withOpacity(0.3),
                      radius: 15,
                      child: Icon(Icons.person,color: ColorsManager.neutralGray,size: 15,)),

                  title: Text( context.read<AdminMainCubit>().listTeacher[index].name));
            },),
       ):SectionCard(
         isNotShowColorSvg:false,
         title: 'Teachers',
         icon: 'assets/svgs/type_of_teaching.svg',
         widget: ImageAndTextEmptyData(
              message: 'There is no teacher yet'),
       );
      }
    },);
  }
}
/*
ImageAndTextEmptyData(
          message: 'There is no teacher yet')
 */