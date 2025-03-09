import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/routing/routes.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/widgets/image_and_text_empty_data.dart';
import 'package:edu_sphere/core/widgets/sliver_widget.dart';
import 'package:edu_sphere/features/admin/requests_admin/data/model/request_model.dart';
import 'package:edu_sphere/features/admin/requests_admin/presentation/bloc/accept_or_reject_request/accept_or_reject_request_cubit.dart';
import 'package:edu_sphere/features/admin/requests_admin/presentation/bloc/request_admin_cubit.dart';
import 'package:edu_sphere/features/admin/requests_admin/presentation/widgets/shimmer_request_main_page.dart';
import 'package:edu_sphere/features/teacher/teacher_main/presentation/widgets/section_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class RequestAdminMainPage extends StatelessWidget {
  const RequestAdminMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<RequestAdminCubit>().emitGetAllRequestAdmin();
    return SliverWidget(
        widget: Padding(
      padding: EdgeInsets.all(16.w),
      child: BlocBuilder<RequestAdminCubit, RequestAdminState>(
        builder: (context, state) {
           if(state is GetAllRequestAdminLoadingState){
             return ShimmerRequestMainPage();

          }else if(state is GetAllRequestAdminLoadedState){
             List<RequestModel> teacherRequests = [];
             List<RequestModel> studentRequests = [];
             for (var request in state.listRequest) {
               // Check the model field in RequestDataModel to categorize as Teacher or Student
               if (request.data.model.contains('Teacher')) {
                 teacherRequests.add(request);
               } else if (request.data.model.contains('Student')) {
                 studentRequests.add(request);
               }
             }
             return Column(
               children: [
                 SectionCard(
                     title: 'Teacher Requests',
                     icon: 'assets/svgs/request_icon.svg',
                     widget:
                     teacherRequests.isNotEmpty?
                     ListView.builder(
                       shrinkWrap: true,
                       physics: NeverScrollableScrollPhysics(),
                       itemCount: teacherRequests.length,
                       itemBuilder: (context, index) {
                          return ListTile(
                              onTap: (){
                                context.read<RequestAdminCubit>().requestModelSelected = teacherRequests[index];
                                context.pushNamed(Routes.acceptOrRejectRequestPage);

                              },
                              leading: CircleAvatar(
                                  backgroundColor: ColorsManager.neutralGray.withOpacity(0.3),
                                  radius: 15,
                                  child: Icon(Icons.person,color: ColorsManager.neutralGray,size: 15,)),

                              title: Text(teacherRequests[index].requestable.name),);
                       },):ImageAndTextEmptyData(message: 'There are no requests yet.')
                 ),
                 verticalSpace(25),
                 SectionCard(
                     title: 'Student Requests',
                     icon: 'assets/svgs/request_icon.svg',
                     widget:
                     studentRequests.isNotEmpty?
                     ListView.builder(
                       shrinkWrap: true,
                       physics: NeverScrollableScrollPhysics(),
                       itemCount: studentRequests.length,
                       itemBuilder: (context, index) {
                         return ListTile(
                           onTap: (){
                             context.read<RequestAdminCubit>().requestModelSelected = studentRequests[index];
                             context.pushNamed(Routes.acceptOrRejectRequestPage);
                           },
                           leading: CircleAvatar(
                               backgroundColor: ColorsManager.neutralGray.withOpacity(0.3),
                               radius: 15,
                               child: Icon(Icons.person,color: ColorsManager.neutralGray,size: 15,)),

                           title: Text(studentRequests[index].requestable.name),);
                       },):ImageAndTextEmptyData(message: 'There are no requests yet.')
                 ),

               ],
             );
           }else{
             if(context.read<RequestAdminCubit>().listRequestModel.isNotEmpty){
               List<RequestModel> teacherRequests = [];
               List<RequestModel> studentRequests = [];
               for (var request in context.read<RequestAdminCubit>().listRequestModel) {
                 // Check the model field in RequestDataModel to categorize as Teacher or Student
                 if (request.data.model.contains('Teacher')) {
                   teacherRequests.add(request);
                 } else if (request.data.model.contains('Student')) {
                   studentRequests.add(request);
                 }
               }
               return Column(
                 children: [
                   SectionCard(
                       title: 'Teacher Requests',
                       icon: 'assets/svgs/request_icon.svg',
                       widget:
                       teacherRequests.isNotEmpty?
                       ListView.builder(
                         shrinkWrap: true,
                         physics: NeverScrollableScrollPhysics(),
                         itemCount: teacherRequests.length,
                         itemBuilder: (context, index) {
                           return ListTile(
                             onTap: (){
                               context.read<RequestAdminCubit>().requestModelSelected = teacherRequests[index];
                               context.pushNamed(Routes.acceptOrRejectRequestPage);
                             },
                             leading: CircleAvatar(
                                 backgroundColor: ColorsManager.neutralGray.withOpacity(0.3),
                                 radius: 15,
                                 child: Icon(Icons.person,color: ColorsManager.neutralGray,size: 15,)),

                             title: Text(teacherRequests[index].requestable.name),);
                         },):ImageAndTextEmptyData(message: 'There are no requests yet.')
                   ),
                   verticalSpace(25),
                   SectionCard(
                       title: 'Student Requests',
                       icon: 'assets/svgs/request_icon.svg',
                       widget:
                       studentRequests.isNotEmpty?
                       ListView.builder(
                         shrinkWrap: true,
                         physics: NeverScrollableScrollPhysics(),
                         itemCount: studentRequests.length,
                         itemBuilder: (context, index) {
                           return ListTile(
                             onTap: (){
                               context.read<RequestAdminCubit>().requestModelSelected = studentRequests[index];
                               context.pushNamed(Routes.acceptOrRejectRequestPage);
                             },
                             leading: CircleAvatar(
                                 backgroundColor: ColorsManager.neutralGray.withOpacity(0.3),
                                 radius: 15,
                                 child: Icon(Icons.person,color: ColorsManager.neutralGray,size: 15,)),

                             title: Text(studentRequests[index].requestable.name),);
                         },):ImageAndTextEmptyData(message: 'There are no requests yet.')
                   ),

                 ],
               );
             }else{
               return Column(
                 children: [
                   SectionCard(
                     title: 'Teacher Requests',
                     icon: 'assets/svgs/request_icon.svg',
                     widget:
                     ImageAndTextEmptyData(message: 'There are no requests yet.'),
                   ),
                   verticalSpace(25),
                   SectionCard(
                     title: 'Student Requests',
                     icon: 'assets/svgs/request_icon.svg',
                     widget:
                     ImageAndTextEmptyData(message: 'There are no requests yet.'),
                   ),
                 ],
               );
             }
           }
        },
      )
    ));
  }
}
