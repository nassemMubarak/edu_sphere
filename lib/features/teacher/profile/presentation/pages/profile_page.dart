import 'package:edu_sphere/features/teacher/profile/presentation/widgets/profile_info_row.dart';
import 'package:edu_sphere/features/teacher/profile/presentation/widgets/profile_info_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/widgets/sliver_widget.dart';
import 'package:edu_sphere/features/teacher/profile/presentation/widgets/upload_image_profile_and_show_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverWidget(
      widget: Padding(
        padding: EdgeInsets.only(top: 10.h, left: 16.w, right: 16.w),
        child: Column(
          children: [
            verticalSpace(20),
            const UploadImageProfileAndShowWidget(),
            verticalSpace(24),
            const ProfileInfoSection(),
          ],
        ),
      ),
    );
  }
}



class UserProfile {
  final String name;
  final String email;
  final String bio;
  final String password;
  final String sex;
  final String level;
  final String major;
  final String age;
  final String campName;

  UserProfile({
    required this.name,
    required this.email,
    required this.bio,
    required this.password,
    required this.sex,
    required this.level,
    required this.major,
    required this.age,
    required this.campName,
  });
}
