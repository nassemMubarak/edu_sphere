import 'package:edu_sphere/core/widgets/warning_message_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/widgets/wave_top_widget.dart';
import 'package:edu_sphere/features/auth/domain/entities/user.dart';

class StudentRequestWidget extends StatelessWidget {
  final User user;

  const StudentRequestWidget({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const WaveTopWidget(),
          Positioned.fill(
            top: 200.h,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  InfoCard(
                    title: 'Request',
                    iconPath: 'assets/svgs/request_icon.svg',
                    content:
                    'Camp login request has been sent, please wait for approval.',
                  ),
                  verticalSpace(24),
                  InfoCard(
                    title: 'Your Information',
                    iconPath: 'assets/svgs/your_information_icon.svg',
                    child: Column(
                      children: [
                        IconLabelRow(
                          iconPath: 'assets/svgs/person_icon_outline.svg',
                          label: user.name,
                        ),
                        IconLabelRow(
                          iconPath: 'assets/svgs/email_icon.svg',
                          label: user.email,
                        ),
                        IconLabelRow(
                          iconPath: 'assets/svgs/lock_icon.svg',
                          label: 'Password',
                        ),
                        IconLabelRow(
                          iconPath: 'assets/svgs/mail_icon.svg',
                          label: user.sex,
                        ),
                        if (user.level != null)
                          IconLabelRow(
                            iconPath: 'assets/svgs/educational.svg',
                            label: user.level.toString(),
                          ),
                        if (user.specialization != null)
                          IconLabelRow(
                            iconPath: 'assets/svgs/university_teacher.svg',
                            label: user.specialization.toString(),
                          ),
                        IconLabelRow(
                          iconPath: 'assets/svgs/circular-word-age.svg',
                          label: user.age,
                        ),
                        IconLabelRow(
                          iconPath: 'assets/svgs/camp.svg',
                          label: 'Camp Name',
                          showChangeCampButton: true,
                          isTextFullWidth: true,
                          onChangeCamp: () => _showChangeCampDialog(context),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showChangeCampDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) =>  WarningMessageAlertDialog(),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final String iconPath;
  final String? content;
  final Widget? child;

  const InfoCard({
    Key? key,
    required this.title,
    required this.iconPath,
    this.content,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _cardDecoration(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset(iconPath),
                horizontalSpace(8),
                Text(
                  title,
                  style: TextStyles.font16Black600Weight,
                ),
              ],
            ),
            verticalSpace(24),
            if (content != null)
              Text(
                content!,
                style: TextStyles.font14NeutralGray400Weight,
              ),
            if (child != null) child!,
          ],
        ),
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(4.r),
      boxShadow: [
        BoxShadow(
          spreadRadius: 2,
          blurRadius: 4,
          color: ColorsManager.shadowColor.withOpacity(0.4),
        ),
      ],
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
                style: TextStyles.font16Black500Weight,
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
        verticalSpace(16),
      ],
    );
  }
}
