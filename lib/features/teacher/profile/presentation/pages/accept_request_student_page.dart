import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/widgets/alert_dialog_widget.dart';
import 'package:edu_sphere/core/widgets/app_text_button.dart';
import 'package:edu_sphere/core/widgets/sliver_widget.dart';
import 'package:edu_sphere/features/teacher/profile/presentation/widgets/request_widgets/accept_request_alert_dialog.dart';
import 'package:edu_sphere/features/teacher/profile/presentation/widgets/request_widgets/reject_request_alert_dialog.dart';
import 'package:edu_sphere/features/teacher/teacher_main/presentation/widgets/section_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/theming/colors.dart';

class AcceptRequestStudentPage extends StatelessWidget {
  const AcceptRequestStudentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverWidget(
      widget: Padding(
        padding: EdgeInsets.only(top: 20.h, left: 16.w, right: 16.w),
        child: Column(
          children: [
            SectionCard(
              title: 'Student information',
              icon: 'assets/svgs/student_information_icon.svg',
              widget: Column(
                children: [
                  verticalSpace(24),
                  IconLabelRow(
                    iconPath: 'assets/svgs/person_icon_outline.svg',
                    label: 'Nassem Ah Mubarak',
                  ),
                  IconLabelRow(
                    iconPath: 'assets/svgs/email_icon.svg',
                    label: 'nassemmubarak@gmail.com',
                  ),
                  IconLabelRow(
                    iconPath: 'assets/svgs/mail_icon.svg',
                    label: 'Mail',
                  ),
                  IconLabelRow(
                    iconPath: 'assets/svgs/educational.svg',
                    label: 'level 5',
                  ),
                  IconLabelRow(
                    iconPath: 'assets/svgs/circular-word-age.svg',
                    label: '22',
                  ),
                  IconLabelRow(
                    iconPath: 'assets/svgs/courses_icon.svg',
                    label: 'Data Science',
                  ),

                ],
              ),
            ),
            verticalSpace(24),
            Row(
              children: [
                Expanded(child: AppTextButton(buttonText: 'Accept Request',onPressed: (){
                  showDialog(context: context, builder: (context) => AcceptRequestAlertDialog(),);
                },)),
                horizontalSpace(16),
                Expanded(child: AppTextButton(buttonText: 'Reject',backgroundColor: Colors.white,textStyle: TextStyles.font16Black500Weight,onPressed: (){
                  showDialog(context: context, builder: (context) => RejectRequestAlertDialog(),);
                },)),
              ],
            ),
          ],
        ),
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
            if (showChangeCampButton)
              GestureDetector(
                onTap: onChangeCamp,
                child: Text(
                  'Change Camp',
                  style: TextStyles.font12ElectricAzure400Weight.copyWith(
                    decoration: TextDecoration.underline,
                    decorationColor: ColorsManager.electricAzure,
                  ),
                ),
              ),
          ],
        ),
        verticalSpace(20),
      ],
    );
  }
}
