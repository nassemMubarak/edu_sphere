import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/features/admin/student_main/data/model/student_information_model.dart';
import 'package:edu_sphere/features/admin/teacher_admin/domain/entities/teacher_informstion.dart';
import 'package:edu_sphere/features/teacher/teacher_main/presentation/widgets/section_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InformationStudentAdminWidget extends StatelessWidget {
  StudentInformationModel studentInformationModel;

  InformationStudentAdminWidget({super.key, required this.studentInformationModel});

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: 'Student Information',
      icon: 'assets/svgs/your_information_icon.svg',
      widget: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: SvgPicture.asset(
              'assets/svgs/person_icon_outline.svg',
              color: ColorsManager.mainBlue,
            ),
            title: Text(studentInformationModel.name),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: SvgPicture.asset(
              'assets/svgs/email_icon.svg',
              color: ColorsManager.mainBlue,
            ),
            title: Text(studentInformationModel.email),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: SvgPicture.asset(
              'assets/svgs/educational.svg',
              color: ColorsManager.mainBlue,
            ),
            title: Text(studentInformationModel.level.toString()),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: SvgPicture.asset(
              'assets/svgs/quiz_score_icon.svg',
              color: ColorsManager.mainBlue,
            ),
            title: Text(studentInformationModel.age.toString()),
          ),
        ],
      ),
    );
  }
}
