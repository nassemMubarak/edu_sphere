import 'package:edu_sphere/features/teacher/teacher_main/presentation/widgets/section_card.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../../core/theming/colors.dart';
class ShimmerLoadingEstimateQuizWidget extends StatelessWidget {
  const ShimmerLoadingEstimateQuizWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: 'Quiz Estimates',
      icon: 'assets/svgs/assessment_estimates_icon.svg',
      widget: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: ListView.builder(
          itemCount: 4,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) => ListTile(
            titleAlignment: ListTileTitleAlignment.center,
            contentPadding: EdgeInsetsDirectional.zero,
            leading: CircleAvatar(
                backgroundColor: ColorsManager.neutralGray.withOpacity(0.3),
                radius: 15,
                child: Icon(Icons.person,color: ColorsManager.neutralGray,size: 15,)),
            title: Container(
              height: 20,
              width: 100,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5)
              ),
            ),
            subtitle: Container(
              height: 10,
              width: 100,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5)
              ),
            ),

          ),
        ),
      ),
    );
  }
}
