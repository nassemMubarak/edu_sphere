import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class ImageAndTextEmptyData extends StatelessWidget {
  String? imageUrl;
   ImageAndTextEmptyData({
    super.key,
    required this.message,
     this.imageUrl
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: imageUrl!=null?250.h:159.h,
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              imageUrl??'assets/images/no_data_image.png',
              height: imageUrl!=null?220.h:130.h,
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
