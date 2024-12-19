import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/features/teacher/profile/presentation/widgets/drawer_widget_teacher.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SliverWidget extends StatelessWidget {
  final Widget widget;
  final Widget? leading;
  List<Widget>? actions;

   SliverWidget({
    super.key,
    required this.widget,
    this.leading,
    this.actions,
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
            toolbarHeight: 70.h,
            centerTitle: true,
            expandedHeight: 160.h,
            foregroundColor: Colors.white,
            backgroundColor: ColorsManager.mainBlue ,
            pinned: true,
            actions: actions,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              titlePadding: EdgeInsets.only(bottom: 16.h),
              title: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'E',
                      style: TextStyles.font30White700Weight,
                    ),
                    TextSpan(
                      text: 'du',
                      style: TextStyles.font30SkyBlue700Weight,
                    ),
                    TextSpan(
                      text: 'Sphere',
                      style: TextStyles.font16White700Weight,
                    ),
                  ],
                ),
              ),
              background: Container(
                height: 120.h,
                color: Colors.white,
                child: Image.asset('assets/images/background_appbar.png',fit: BoxFit.cover),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              child: widget,
            ),
          ),
        ],
      ),
    );
  }
}
