import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/features/teacher/teacher_main/ui/widgets/course_info_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SectionCard extends StatelessWidget {
  final String title;
  final bool showAddButton;
  final String icon;
  final Widget widget;
  final Widget infoDialog;
  final Function()? onTapEdit;

  SectionCard(
      {required this.title,
      this.showAddButton = false,
      required this.icon,
      required this.widget,
      required this.infoDialog,
      this.onTapEdit,
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            spreadRadius: 2,
            blurRadius: 4,
            color: ColorsManager.shadowColor.withOpacity(0.3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  icon,
                  width: 24.w,
                  height: 24.h,
                  color: ColorsManager.mainBlue,
                ),
                horizontalSpace(8.w),
                Text(
                  title,
                  style: TextStyles.font16Black600Weight,
                ),
                Spacer(),
                Visibility(
                  visible: onTapEdit != null,
                  child: GestureDetector(
                    onTap: onTapEdit,
                    child: SvgPicture.asset('assets/svgs/edite_icon.svg',
                        height: 24, width: 24),
                  ),
                ),
                horizontalSpace(8),
                addButtonWidget(context, infoDialog: infoDialog),
              ],
            ),
            horizontalSpace(8),
            widget,
          ],
        ),
      ),
    );
  }

  GestureDetector addButtonWidget(BuildContext context,
      {required Widget infoDialog}) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => infoDialog,
        );
      },
      child: Container(
        height: 32.h,
        width: 32.w,
        decoration: BoxDecoration(
          color: ColorsManager.secondaryColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
