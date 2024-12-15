import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/features/teacher/teacher_main/ui/widgets/drawer_widget_teacher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class SliverWidget extends StatelessWidget {
  Widget widget;
  Widget? leading;
  SliverWidget({

    super.key,
    required this.widget,
    this.leading

  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const DrawerWidgetTeacher(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: leading,
            toolbarHeight: 70,
            centerTitle: true,
            foregroundColor: Colors.white,
            backgroundColor: ColorsManager.mainBlue ,
            iconTheme:const IconThemeData(color: Colors.white),
            expandedHeight: 170.h, // Height when fully expanded04
            floating: true, // If true, the app bar will not stick at the top
            pinned: true, // Keep the app bar visible when scrolled up
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              // titlePadding: EdgeInsetsDirectional.only(top:30.h,bottom: 30.h,start: 105.w),
              title: RichText(
                text: TextSpan(
                    text: 'E',
                    style: TextStyles .font30White700Weight,
                    children: [
                      TextSpan(
                        text: 'du',
                        style: TextStyles.font30SkyBlue700Weight,
                      ),
                      TextSpan(
                        text: 'sphere',
                        style: TextStyles.font16White700Weight,
                      )
                    ]),
              ),
              background: Container(
                  // height: 200.h,
                  // width: double.infinity,
                padding: EdgeInsets.only(bottom: 10),
                  color: Colors.white,
                  child: Image.asset('assets/images/background_appbar.png',fit: BoxFit.cover,)),
            ),

          ),
          SliverToBoxAdapter(
              child:Container(
                  color: Colors.white,
                  child: widget,
              ),
          ),
        ],
      ),
    );
  }
}
