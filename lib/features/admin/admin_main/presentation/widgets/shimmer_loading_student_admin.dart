import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/features/teacher/teacher_main/presentation/widgets/section_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoadingStudentAdmin extends StatelessWidget {
  const ShimmerLoadingStudentAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionCard(
        title: 'Students',
          isNotShowColorSvg:false,
        icon: 'assets/svgs/university_teacher.svg', widget: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 3, // Show dummy list items
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                    backgroundColor: ColorsManager.neutralGray.withOpacity(0.3),
                    radius: 15,
                    child: Icon(Icons.person,color: ColorsManager.neutralGray,size: 15,)),
                title: Container(
                  width: double.infinity,
                  height: 16.0,
                  color: Colors.white,
                ),
              );
            },
          ),
        ));
  }
}
