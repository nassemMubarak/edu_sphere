import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/widgets/sliver_widget.dart';
import 'package:edu_sphere/features/profile/presentation/widgets/request_widgets/course_enrollment_requests_widget.dart';
import 'package:edu_sphere/features/profile/presentation/widgets/request_widgets/course_withdrawal_requests_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RequestsTeacherPage extends StatelessWidget {
  const RequestsTeacherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverWidget(
        widget: Padding(
      padding: EdgeInsets.only(top: 10.h, left: 16.w, right: 16.w),
      child: Column(
        children: [
          CourseEnrollmentRequestsWidget(),
          verticalSpace(24),
          CourseWithdrawalRequestsWidget(),
        ],
      ),
    ));
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
