import 'package:edu_sphere/core/helpers/constants.dart';
import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/helpers/shared_pref_helper.dart';
import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/routing/routes.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/features/admin/requests_admin/presentation/bloc/request_admin_cubit.dart';
import 'package:edu_sphere/features/auth/domain/entities/user.dart';
import 'package:edu_sphere/features/auth/presentation/bloc/auth/auth_cubit.dart';
import 'package:edu_sphere/features/profile/presentation/widgets/image_and_name_drawer.dart';
import 'package:edu_sphere/features/profile/presentation/widgets/logout_alert_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class DrawerWidget extends StatefulWidget {
   DrawerWidget({Key? key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final List<Map<String, dynamic>> iconAndLabelTeacher = [
    {
      'icon': 'assets/svgs/home_icon.svg',
      'label': 'Home',
      'onTap': (BuildContext context) =>
          context.pushNamed(Routes.teacherMainScreen),
    },
    {
      'icon': 'assets/svgs/profile_icon.svg',
      'label': 'Your Profile',
      'onTap': (BuildContext context) => context.pushNamed(Routes.profilePage),
    },
    {'icon': 'assets/svgs/request_icon.svg', 'label': 'Requests',
      'onTap': (BuildContext context) => context.pushNamed(Routes.requestsTeacherPage),
    },
    // {'icon': 'assets/svgs/assessment_estimates_icon.svg', 'label': 'Student Estimates'},
    // {'icon': 'assets/svgs/university_teacher.svg', 'label': 'Course Students'},
    {'icon': 'assets/svgs/communication_icon.svg', 'label': 'Communication',
      'onTap': (BuildContext context) => context.pushNamed(Routes.communicationMainPage),
    },
    {'icon': 'assets/svgs/contact_us_icon.svg', 'label': 'Contact Us',
      'onTap': (BuildContext context) => context.pushNamed(Routes.contactUsPage),

    },
    // {'icon': 'assets/svgs/course_subscription_icon.svg', 'label': 'Course subscription'},
    {'icon': 'assets/svgs/language_icon.svg', 'label': 'Change language'},
    {'icon': 'assets/svgs/about_program_icon.svg', 'label': 'About program'},
    {
      'icon': 'assets/svgs/logout_icon.svg',
      'label': 'Logout',
      'onTap': (BuildContext context) async {
        showDialog(context: context, builder: (context) => LogoutAlertDialogWidget());

      },
    },
  ];
  final List<Map<String, dynamic>> iconAndLabelStudent = [
    {
      'icon': 'assets/svgs/home_icon.svg',
      'label': 'Home',
      'onTap': (BuildContext context) =>
          context.pushNamed(Routes.studentMainPage),
    },
    {
      'icon': 'assets/svgs/profile_icon.svg',
      'label': 'Your Profile',
      'onTap': (BuildContext context) => context.pushNamed(Routes.profilePage),
    },
    // {'icon': 'assets/svgs/request_icon.svg', 'label': 'Withdrawal requests'},
    {'icon': 'assets/svgs/assessment_estimates_icon.svg', 'label': 'Estimates',
      'onTap': (BuildContext context) => context.pushNamed(Routes.estimateStudentMainPage),

    },
    {'icon': 'assets/svgs/type_of_teaching.svg', 'label': 'Course teachers',

      'onTap': (BuildContext context) => context.pushNamed(Routes.showStudentTeacherMainPage),
    },
    {'icon': 'assets/svgs/communication_icon.svg', 'label': 'Communication',
      'onTap': (BuildContext context) => context.pushNamed(Routes.communicationMainPage),

    },
    {'icon': 'assets/svgs/contact_us_icon.svg', 'label': 'Contact us',
      'onTap': (BuildContext context) => context.pushNamed(Routes.contactUsPage),
    },
    {'icon': 'assets/svgs/language_icon.svg', 'label': 'Change language'},
    {'icon': 'assets/svgs/about_program_icon.svg', 'label': 'About program'},
    {
      'icon': 'assets/svgs/logout_icon.svg',
      'label': 'Logout',
      'onTap': (BuildContext context) async {
        showDialog(context: context, builder: (context) => LogoutAlertDialogWidget());

      },
    },
  ];
  final List<Map<String, dynamic>> iconAndLabelAdmin = [
    {
      'icon': 'assets/svgs/home_icon.svg',
      'label': 'Home',
      'onTap': (BuildContext context) =>
          context.pushNamed(Routes.studentMainPage),
    },
    {
      'icon': 'assets/svgs/profile_icon.svg',
      'label': 'Your Profile',
      'onTap': (BuildContext context) => context.pushNamed(Routes.profilePage),
    },
    {'icon': 'assets/svgs/request_icon.svg', 'label': 'Requests',
      'onTap': (BuildContext context) => context.pushNamed(Routes.requestAdminMainPage),
    },
    {'icon': 'assets/svgs/course_subscription_icon.svg', 'label': 'Camp Subscription',
      'onTap': (BuildContext context) => context.pushNamed(Routes.campSubscribePage),

    },
    {'icon': 'assets/svgs/communication_icon.svg', 'label': 'Communication',
      'onTap': (BuildContext context) => context.pushNamed(Routes.communicationMainPage),

    },
    {'icon': 'assets/svgs/contact_us_icon.svg', 'label': 'Contact us',
      'onTap': (BuildContext context) => context.pushNamed(Routes.contactUsPage),
    },
    {'icon': 'assets/svgs/language_icon.svg', 'label': 'Change language'},
    {'icon': 'assets/svgs/about_program_icon.svg', 'label': 'About program'},
    {
      'icon': 'assets/svgs/logout_icon.svg',
      'label': 'Logout',
      'onTap': (BuildContext context) async {
        showDialog(context: context, builder: (context) => LogoutAlertDialogWidget());

      },
    },
  ];


  int indexSelected = 0;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: BlocBuilder<AuthCubit, AuthState>(
       builder: (context, state) {
        if(state is AuthLoadedState){
          return Column(
            children: <Widget>[
              ImageAndNameDrawer(),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount:state.user.type!.toUpperCase()=='STUDENT'?iconAndLabelStudent.length:state.user.type!.toUpperCase()=='ADMIN'?iconAndLabelAdmin.length:iconAndLabelTeacher.length,
                  itemBuilder: (context, index) => buildListTile(index, context,state.user),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Copyright © 2024 EduSphere\nAll rights reserved.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: ColorsManager.neutralGray),
                ),
              ),
              verticalSpace(10),
            ],
          );
        }else{
          return SizedBox.shrink();
        }
  },
),
    );
  }

  Widget buildListTile(int index, BuildContext context,User user) {
    final item = user.type!.toUpperCase()=='STUDENT'?iconAndLabelStudent[index]:user.type!.toUpperCase()=='ADMIN'?iconAndLabelAdmin[index]:iconAndLabelTeacher[index];
    final iconPath = item['icon'] as String?;
    final label = item['label'] as String?;
    final onTap = item['onTap'] as Function(BuildContext)?; // Specific callback type.

    if (iconPath == null || label == null) {
      return const SizedBox.shrink(); // Fallback for invalid data.
    }

    if(index==2&&user.type!.toUpperCase()=='ADMIN'){
      return ListTile(
        leading: SvgPicture.asset(
          iconPath,
          width: 15.w,
          height: 15.h,
          color: index == indexSelected ? ColorsManager.mainBlue : Colors.black,
        ),
        title: Text(
          label,
          style: index == indexSelected
              ? TextStyles.font12MainBlue500Weight
              : TextStyles.font12Black400Weight,
        ),
        trailing: BlocBuilder<RequestAdminCubit, RequestAdminState>(
          builder: (context, state) {
            if(state is GetAllRequestAdminLoadedState){
              return state.listRequest.isEmpty?SizedBox.shrink():Container(
                alignment: Alignment.center,
                width: 24.w,
                height: 24.h,
                decoration: BoxDecoration(
                    color: ColorsManager.mainBlue,
                    borderRadius: BorderRadius.circular(12)
                ),
                child: Text('+${state.listRequest.length}',style: TextStyles.font10White400Weight),
              );
            }else{
              if(context.read<RequestAdminCubit>().listRequestModel.isNotEmpty){
               return context.read<RequestAdminCubit>().listRequestModel.isEmpty?SizedBox.shrink(): Container(
                 alignment: Alignment.center,
                  width: 24.w,
                  height: 24.h,
                  decoration: BoxDecoration(
                      color: ColorsManager.mainBlue,
                      borderRadius: BorderRadius.circular(12)
                  ),
                  child: Text('+${context.read<RequestAdminCubit>().listRequestModel.length}',style: TextStyles.font10White400Weight),
                );

              }
              return  SizedBox.shrink();
            }
          },
        ),
        onTap: () async {
          setState(() {
            indexSelected = index;
          });

          if (onTap != null) {
            await onTap(context);
          }
        },
      );
    }

    return  ListTile(
      leading: SvgPicture.asset(
        iconPath,
        width: 15.w,
        height: 15.h,
        color: index == indexSelected ? ColorsManager.mainBlue : Colors.black,
      ),
      title: Text(
        label,
        style: index == indexSelected
            ? TextStyles.font12MainBlue500Weight
            : TextStyles.font12Black400Weight,
      ),
      onTap: () async {
        setState(() {
          indexSelected = index;
        });

        if (onTap != null) {
          await onTap(context);
        }
      },
    );
  }
}
