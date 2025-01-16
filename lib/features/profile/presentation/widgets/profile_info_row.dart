import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileInfoRow extends StatelessWidget {
  final String iconPath;
  final String label;
  final VoidCallback? onEdit;
  final bool isTextFullWidth;

  const ProfileInfoRow({
    Key? key,
    required this.iconPath,
    required this.label,
    this.onEdit,
    this.isTextFullWidth = false,
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
              GestureDetector(
                onTap: onEdit,
                child: SvgPicture.asset(
                  'assets/svgs/edite_icon.svg',
                  width: 24.w,
                  height: 24.h,
                ),
              ),
          ],
        ),
        verticalSpace(30),
      ],
    );
  }
}
