import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/features/teacher/teacher_main/presentation/widgets/section_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
class ShimmerLoadingLecture extends StatelessWidget {
  const ShimmerLoadingLecture({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: 'Lectures',
      icon: 'assets/svgs/video_lecture_icon.svg',
      widget: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            verticalSpace(24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    alignment: AlignmentDirectional.bottomStart,
                    width: 0.5.sw,
                    child: Container(
                      width: 100,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(10)
                      ),
                    )
                ),
              ],
            ),
            verticalSpace(8),
            Container(
                alignment: AlignmentDirectional.bottomStart,
                width: 0.5.sw,
                child: Container(
                  width: 50,
                  height: 10,
                  decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(10)
                  ),
                )
            ),
            verticalSpace(16),
            Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                  color: Colors.black12,
                borderRadius: BorderRadius.circular(8)
              ),
            ),
            // Image.asset('assets/images/lecture_image.png'),
            verticalSpace(16),
          ],
        ),
      ),
    );
  }
}
