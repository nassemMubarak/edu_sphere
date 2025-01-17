import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/widgets/sliver_widget.dart';
import 'package:edu_sphere/features/teacher/teacher_main/presentation/widgets/section_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class Shimmershowstudentassessmentwidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          verticalSpace(24),
          // Shimmer Effect for loading assessment time section
          Container(
            width: 1.sw,
            padding: const EdgeInsets.all(16.0),
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
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                        height: 12.h,
                        color: Colors.white,
                      )),
                  horizontalSpace(13),
                  Expanded(
                    child: Container(
                      height: 12.h,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          verticalSpace(24),
          // Shimmer Effect for loading assessment details
          Container(
            padding: const EdgeInsets.all(16.0),
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
            child: Column(
              children: [
                // ListTile(
                //   titleAlignment: ListTileTitleAlignment.center,
                //   contentPadding: EdgeInsetsDirectional.zero,
                //   leading: SvgPicture.asset(
                //     'assets/svgs/annual_assessment_icon.svg',
                //     width: 24.w,
                //     height: 24.h,
                //     color: ColorsManager.mainBlue,
                //   ),
                //   title: Shimmer.fromColors(
                //     baseColor: Colors.grey[300]!,
                //     highlightColor: Colors.grey[100]!,
                //     child: Container(
                //       height: 14.h,
                //       width: 0.4.sw,
                //       color: Colors.white,
                //     ),
                //   ),
                // ),
                verticalSpace(24),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: 0.6.sw,
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            height: 12.h,
                            color: Colors.white,
                          ),
                        )),
                  ],
                ),
                verticalSpace(24),

                buildShimmerTile(),
                verticalSpace(24),

                buildShimmerTile(),
                verticalSpace(24),

                buildShimmerTile(),
              ],
            ),
          ),
          verticalSpace(24),
        ],
      ),
    );
  }

  Widget buildShimmerTile() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 12.h,
        color: Colors.white,
      ),
    );
  }
}
