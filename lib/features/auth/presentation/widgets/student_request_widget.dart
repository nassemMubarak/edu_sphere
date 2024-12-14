import 'package:edu_sphere/core/helpers/constants.dart';
import 'package:edu_sphere/core/helpers/shared_pref_helper.dart';
import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/widgets/wave_top_widget.dart';
import 'package:edu_sphere/features/auth/domain/entities/user.dart';
import 'package:edu_sphere/features/auth/presentation/bloc/auth/auth_cubit.dart';
import 'package:edu_sphere/features/auth/presentation/widgets/warning_message_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentRequestWidget extends StatelessWidget {
  User user;

  StudentRequestWidget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const WaveTopWidget(),
          Container(
            margin: EdgeInsets.only(top: 200.h),
            // margin to create space from the top
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 4,
                            color: ColorsManager.shadowColor.withOpacity(0.4),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 16.h),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                    'assets/svgs/request_icon.svg'),
                                horizontalSpace(8),
                                Text(
                                  'Request',
                                  style: TextStyles.font16Black600Weight,
                                ),
                              ],
                            ),
                            verticalSpace(24),
                            Text(
                              'Camp login request has been sent, please wait for approval.',
                              style: TextStyles.font14NeutralGray400Weight,
                            ),
                          ],
                        ),
                      ),
                    ),
                    verticalSpace(24),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 4,
                            color: ColorsManager.shadowColor.withOpacity(0.4),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 16.h),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                    'assets/svgs/your_information_icon.svg'),
                                horizontalSpace(8),
                                Text(
                                  'Your information',
                                  style: TextStyles.font16Black600Weight,
                                ),
                              ],
                            ),
                            verticalSpace(24),
                            iconAndLabelWidget(
                              context,
                              imageUrl: 'assets/svgs/person_icon_outline.svg',
                              label: user.name,
                            ),
                            iconAndLabelWidget(context,
                                imageUrl: 'assets/svgs/email_icon.svg',
                                label: user.email),
                            iconAndLabelWidget(context,
                                imageUrl: 'assets/svgs/lock_icon.svg',
                                label: 'Password'),
                            iconAndLabelWidget(context,
                                imageUrl: 'assets/svgs/mail_icon.svg',
                                label: user.sex),
                            Visibility(
                              visible: user.level != null,
                              child: iconAndLabelWidget(
                                context,
                                imageUrl: 'assets/svgs/educational.svg',
                                label: user.level.toString(),
                              ),
                            ),
                            Visibility(
                              visible: user.specialization != null,
                              child: iconAndLabelWidget(
                                context,
                                imageUrl: 'assets/svgs/university_teacher.svg',
                                label: user.specialization.toString(),
                              ),
                            ),
                            iconAndLabelWidget(
                              context,
                              imageUrl: 'assets/svgs/circular-word-age.svg',
                              label: user.age,
                            ),
                            iconAndLabelWidget(context,
                                imageUrl: 'assets/svgs/camp.svg',
                                label: 'Camp Name',
                                isShowChangCampButton: true,
                                isWidthText: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  iconAndLabelWidget(BuildContext context,
      {required String imageUrl,
      required String label,
      bool isShowChangCampButton = false,
      bool isWidthText = false}) {
    return Column(
      children: [
        Row(
          children: [
            SvgPicture.asset(
              imageUrl,
              color: ColorsManager.mainBlue,
            ),
            horizontalSpace(8),
            Container(
              width: isWidthText == true ? null : 0.7.sw,
              child: Text(
                label,
                style: TextStyles.font16Black500Weight,
              ),
            ),
            Spacer(),
            Visibility(
              visible: isShowChangCampButton,
              child: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => WarningMessageAlertDialog(),
                  );
                },
                child: Text(
                  'Change Camp',
                  style: TextStyles.font12ElectricAzure400Weight.copyWith(
                    decoration: TextDecoration.underline,
                    decorationColor: ColorsManager.electricAzure,
                  ),
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
