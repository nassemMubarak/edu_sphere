import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/routing/routes.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/features/teacher/teacher_main/ui/widgets/section_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CourseEnrollmentRequestsWidget extends StatelessWidget {
  const CourseEnrollmentRequestsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      showAddButton: false,
      textStyle: TextStyles.font14Black500Weight,
      title: 'Course Enrollment Requests',
      icon: 'assets/svgs/request_icon.svg',
      widget: Container(
        margin: EdgeInsetsDirectional.only(top: 20.h),
        child: Column(
          children: [
            buildListTileLabel(name: 'Wessem Ah Mubarak',onTap: (){
              context.pushNamed(Routes.acceptRequestStudentPage);
            }),
            buildListTileLabel(name: 'Wassem Ah Mubarak'),
            buildListTileLabel(name: 'Nassem Ah Mubarak'),
          ],
        ),
      ),
    );
  }
  ListTile buildListTileLabel({required String name,Function()? onTap}) {
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        backgroundColor:
        ColorsManager.neutralGray.withOpacity(0.3),
        radius: 15,
        child: Icon(
          Icons.person,
          color: ColorsManager.neutralGray,
          size: 15,
        ),
      ),
      title: Text(
        name,
        style: TextStyles.font10Black400Weight,
      ),
      contentPadding: EdgeInsets.zero,
    );
  }

}
