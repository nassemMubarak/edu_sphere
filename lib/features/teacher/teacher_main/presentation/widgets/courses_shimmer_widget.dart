import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';

class CoursesShimmerWidget extends StatelessWidget {
  const CoursesShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.all(0),
      itemCount: 4,
      itemBuilder: (context, index) => Container(
        margin: const EdgeInsets.only(bottom: 16),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child:  ListTile(
            leading: SvgPicture.asset('assets/svgs/writing_education_learning_icon.svg'),
          title: Container(
          height: 20,
          width: 200,
          color: Colors.white,
        ),
            subtitle: Container(
              margin: EdgeInsetsDirectional.only(top: 5),
              height: 10,
              width: 0,
              color: Colors.white,
            ),
      ),
        ),
      ),
    );
  }
}
