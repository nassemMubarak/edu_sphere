import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/widgets/image_and_text_empty_data.dart';
import 'package:edu_sphere/features/teacher/teacher_main/domain/entities/course.dart';
import 'package:edu_sphere/features/teacher/teacher_main/presentation/widgets/section_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CoursesTaughtWidget extends StatelessWidget {
  List<Course> corses;
   CoursesTaughtWidget({super.key,required this.corses});

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: 'Courses Taught',
      icon: 'assets/svgs/courses_icon.svg',
      isNotShowColorSvg: true,
      widget:corses.isNotEmpty?ListView.builder(
        padding: EdgeInsets.zero,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: corses.length,
        itemBuilder: (context, index) => ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(
            corses[index].title,
            style: TextStyles.font14Black500Weight,
          ),
          leading: SvgPicture.asset(
            'assets/svgs/writing_education_learning_icon.svg',
            width: 24,
            height: 24,
          ),
          subtitle: Text(
            corses[index].description,
            style: TextStyles.font12NeutralGray400Weight,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ),
      ):ImageAndTextEmptyData(message: 'Not added Courses'),
    );
  }
}
