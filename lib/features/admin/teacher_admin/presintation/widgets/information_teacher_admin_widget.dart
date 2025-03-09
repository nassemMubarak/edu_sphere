import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/features/admin/teacher_admin/domain/entities/teacher_informstion.dart';
import 'package:edu_sphere/features/teacher/teacher_main/presentation/widgets/section_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InformationTeacherAdminWidget extends StatelessWidget {
  TeacherInformation teacherInformation;
   InformationTeacherAdminWidget({
    super.key,
     required this.teacherInformation
  });

  @override
  Widget build(BuildContext context) {
    return SectionCard(title: 'Teacher Information', icon: 'assets/svgs/your_information_icon.svg', widget: Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: SvgPicture.asset(
            'assets/svgs/person_icon_outline.svg',
            color: ColorsManager.mainBlue,
          ),
          title: Text(teacherInformation.teacher.name),
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,

          leading: SvgPicture.asset(
            'assets/svgs/email_icon.svg',
            color: ColorsManager.mainBlue,
          ),
          title: Text(teacherInformation.teacher.email),
        ),ListTile(
          contentPadding: EdgeInsets.zero,
          leading: SvgPicture.asset(
            'assets/svgs/mail_icon.svg',
            color: ColorsManager.mainBlue,
          ),
          title: Text(teacherInformation.teacher.sex),
        ),ListTile(
          contentPadding: EdgeInsets.zero,
          leading: SvgPicture.asset(
            'assets/svgs/university_teacher.svg',
            color: ColorsManager.mainBlue,
          ),
          title: Text(teacherInformation.teacher.specialization!),
        ),
      ],
    ),);
  }
}
