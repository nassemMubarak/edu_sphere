import 'package:edu_sphere/features/teacher/teacher_main/presentation/widgets/section_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class ShimmerLoadingChapterWidget extends StatelessWidget {
  const ShimmerLoadingChapterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: 'Chapters',
      icon: 'assets/svgs/chapter_icon.svg',
      widget: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: ListView.builder(
          itemCount: 4,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) => ListTile(
            onTap: () {},
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
            leading: SvgPicture.asset('assets/svgs/pdf_icon.svg'),
            title: Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(5)),
            ),
          ),
        ),
      ),
    );
  }
}
