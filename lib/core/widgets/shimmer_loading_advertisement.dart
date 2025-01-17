import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/features/teacher/teacher_main/presentation/widgets/section_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
class ShimmerLoadingAdvertisement extends StatelessWidget {
  const ShimmerLoadingAdvertisement({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      showAddButton: false,
      title: 'Advertisements',
      icon: 'assets/svgs/advertisements_icon.svg',
      widget: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: buildListView(index: 4))
    );
  }
  ListView buildListView({required int index}) {
    return ListView.separated(
        separatorBuilder: (context, index) => verticalSpace(16.h),
        padding: EdgeInsetsDirectional.only(top: 24.h,bottom: 40.h,end: 16.w,start: 16.w),
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: index,
        itemBuilder: (context, index) =>Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              'assets/svgs/ads_icon.svg',
            ),
            horizontalSpace(8),
            Container(
              height: 20,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.red
              ),

            )
          ],
        )

    );
  }
}
