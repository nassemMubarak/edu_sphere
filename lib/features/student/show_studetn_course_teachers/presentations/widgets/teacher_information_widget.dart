import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/features/student/show_studetn_course_teachers/domain/entities/show_student_teacher.dart';
import 'package:edu_sphere/features/teacher/teacher_main/presentation/widgets/section_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/styles.dart';

class TeacherInformationWidget extends StatelessWidget {
  ShowStudentTeacher showStudentTeacher;
   TeacherInformationWidget({super.key,required this.showStudentTeacher});

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: 'teacher information',
      icon: 'assets/svgs/your_information_icon.svg',
      isNotShowColorSvg: true,
      widget: Column(
        children: [
          verticalSpace(24),
          IconLabelRow(
            iconPath: 'assets/svgs/person_icon_outline.svg',
            label: showStudentTeacher.name,
          ),
          IconLabelRow(
            iconPath: 'assets/svgs/email_icon.svg',
            label:showStudentTeacher.email,
          ),
          IconLabelRow(
            iconPath: 'assets/svgs/mail_icon.svg',
            label: showStudentTeacher.sex,
          ),
          if (showStudentTeacher.specialization != null)
            IconLabelRow(
              iconPath: 'assets/svgs/university_teacher.svg',
              label:
              showStudentTeacher.specialization.toString(),
            ),
          IconLabelRow(
            iconPath: 'assets/svgs/circular-word-age.svg',
            label: showStudentTeacher.age.toString(),
          ),
        ],
      ),
    );
  }
}
class IconLabelRow extends StatelessWidget {
  final String iconPath;
  final String label;
  final bool showChangeCampButton;
  final bool isTextFullWidth;
  final VoidCallback? onChangeCamp;

  const IconLabelRow({
    Key? key,
    required this.iconPath,
    required this.label,
    this.showChangeCampButton = false,
    this.isTextFullWidth = false,
    this.onChangeCamp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SvgPicture.asset(
              iconPath,
              color: ColorsManager.mainBlue,
            ),
            horizontalSpace(8),
            Expanded(
              child: Text(
                label,
                style: TextStyles.font14Black400Weight,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        verticalSpace(16),
      ],
    );
  }
}

