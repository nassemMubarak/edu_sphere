import 'package:edu_sphere/features/teacher/teacher_main/presentation/widgets/section_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class ShimmerLoadingQuizWidget extends StatelessWidget {
  const ShimmerLoadingQuizWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: 'Quize',
      icon: 'assets/svgs/quiz_on_computer_question_icon.svg',
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
            leading: SvgPicture.asset('assets/svgs/quiz_leading_icon.svg'),
            title: Container(
              height: 10,
              width: 100,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(5)),
            ),
          ),
        ),
      ),
    );
  }
}
