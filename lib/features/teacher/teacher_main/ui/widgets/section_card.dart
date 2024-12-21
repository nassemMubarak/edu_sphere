import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/features/teacher/teacher_main/logic/teacher_main_cubit.dart';
import 'package:edu_sphere/features/teacher/teacher_main/logic/teacher_main_state.dart';
import 'package:edu_sphere/features/teacher/teacher_main/ui/widgets/course_info_dialog.dart';
import 'package:edu_sphere/core/widgets/image_and_text_empty_data.dart';
import 'package:edu_sphere/features/teacher/teacher_main/ui/widgets/titel_and_icon_list_taile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SectionCard extends StatelessWidget {
  final String title;
  final bool showAddButton;
  final String icon;
  final Widget widget;
  final TextStyle? textStyle;

  SectionCard({
    required this.title,
    this.showAddButton = false,
    this.textStyle,
    required this.icon,
    required this.widget,
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
                  style: textStyle??TextStyles.font16Black500Weight,
                ),
                const Spacer(),
                Visibility(
                  visible: showAddButton,
                  child: addButtonWidget(context),
                ),
              ],
            ),
            horizontalSpace(8),
           widget,
          ],
        ),
      ),
    );
  }

  GestureDetector addButtonWidget(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => CourseInfoDialog(),
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
