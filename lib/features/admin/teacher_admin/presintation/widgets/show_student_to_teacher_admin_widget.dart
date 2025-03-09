import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/widgets/image_and_text_empty_data.dart';
import 'package:edu_sphere/features/admin/teacher_admin/domain/entities/teacher_informstion.dart';
import 'package:edu_sphere/features/teacher/teacher_main/presentation/widgets/section_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShowStudentToTeacherAdminWidget extends StatelessWidget {
  TeacherInformation teacherInformation;
  ShowStudentToTeacherAdminWidget({
    super.key,
     required this.teacherInformation
  });

  @override
  Widget build(BuildContext context) {
    return teacherInformation.students.isNotEmpty?SectionCard(
      title: 'Students registered with him',
      icon: 'assets/svgs/university_teacher.svg',
      widget: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.all(0),
        itemCount: teacherInformation.students.length,
        itemBuilder: (context, index) => Container(
          margin: const EdgeInsets.only(bottom: 16),
          child: ListTile(
              leading: CircleAvatar(
                  backgroundColor: ColorsManager.neutralGray.withOpacity(0.3),
                  radius: 15,
                  child: Icon(Icons.person,color: ColorsManager.neutralGray,size: 15,)),

              title: Text(teacherInformation.students[index].name,style: TextStyles.font14Black400Weight,),
          )

        ),
        ),
    ):SectionCard(
      title: 'Students registered with him',
      icon: 'assets/svgs/university_teacher.svg',
    widget: ImageAndTextEmptyData(
    message: 'There is no students yet'),
    );
  }
}
