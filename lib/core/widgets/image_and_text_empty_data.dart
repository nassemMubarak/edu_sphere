import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class ImageAndTextEmptyData extends StatelessWidget {
  const ImageAndTextEmptyData({
    super.key,
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 159.h,
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              'assets/images/no_data_image.png',
              height: 130.h,
              width: 200.w,
            ),
            verticalSpace(8),
            Text(
              message,
              style: TextStyles.font12Black400Weight,
            ),
          ],
        ),
      ),
    );
  }
}
