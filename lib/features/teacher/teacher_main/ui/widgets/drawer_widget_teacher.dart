import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/features/teacher/teacher_main/ui/widgets/image_and_name_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DrawerWidgetTeacher extends StatefulWidget {
 const DrawerWidgetTeacher({
    super.key,
  });

  @override
  State<DrawerWidgetTeacher> createState() => _DrawerWidgetTeacherState();
}

class _DrawerWidgetTeacherState extends State<DrawerWidgetTeacher> {
  List iconAndLabel = [
    {'icon': 'assets/svgs/home_icon.svg', 'label': 'Home'},
    {'icon': 'assets/svgs/profile_icon.svg', 'label': 'Your Profile'},
    {'icon': 'assets/svgs/communication_icon.svg', 'label': 'Communication'},
    {
      'icon': 'assets/svgs/course_subscription_icon.svg',
      'label': 'Course subscription'
    },
    {'icon': 'assets/svgs/language_icon.svg', 'label': 'Change language'},
    {'icon': 'assets/svgs/about_program_icon.svg', 'label': 'About program'},
    {'icon': 'assets/svgs/logout_icon.svg', 'label': 'Logout'},
  ];

  int indexSelected = 0;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          const ImageAndNameDrawer(),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: iconAndLabel.length,
            itemBuilder: (context, index) => buildListTile(index),
          ),
          const Spacer(),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Copyright © 2024 EduSphere\nAll rights reserved.',
              textAlign: TextAlign.center,
              style: TextStyle(color: ColorsManager.neutralGray),
            ),
          ),
          verticalSpace(72),
        ],
      ),
    );
  }

  Widget buildListTile(int index) {
    return ListTile(
      leading: SvgPicture.asset(
        iconAndLabel[index]['icon'],
        width: 24,
        height: 24,
        color: index == indexSelected
            ? ColorsManager.mainBlue
            : Colors.black,
      ),
      title: Text(
        iconAndLabel[index]['label'],
        style: index == indexSelected
            ? TextStyles.font16MainBlue500Weight
            : TextStyles.font16Black500Weight,
      ),
      onTap: () {
        setState(() {
          indexSelected = index;
        });
      },
    );
  }
}
