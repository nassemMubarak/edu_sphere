import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/routing/routes.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/widgets/image_and_text_empty_data.dart';
import 'package:edu_sphere/features/admin/teacher_admin/domain/entities/teacher_informstion.dart';
import 'package:edu_sphere/features/admin/teacher_admin/presintation/bloc/show_courrse_teacher/show_course_teacher_cubit.dart';
import 'package:edu_sphere/features/admin/teacher_admin/presintation/bloc/teacher_admin_cubit.dart';
import 'package:edu_sphere/features/teacher/teacher_main/presentation/widgets/section_card.dart';
import 'package:edu_sphere/l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ShowCoursesTeacherAdminWidget extends StatelessWidget {
  TeacherInformation teacherInformation;
   ShowCoursesTeacherAdminWidget({
    super.key,
     required this.teacherInformation
  });

  @override
  Widget build(BuildContext context) {
    return teacherInformation.courses.isNotEmpty?SectionCard(
      title: 'Courses taught',
      icon: 'assets/svgs/courses_icon.svg',
      widget: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.all(0),
        itemCount: teacherInformation.courses.length,
        itemBuilder: (context, index) => Container(
          margin: const EdgeInsets.only(bottom: 16),
          child: ListTile(
            onTap: (){
              context.pushNamed(Routes.showCourseTeacherPage);
              context.read<TeacherAdminCubit>().courseSelected = teacherInformation.courses[index];
              context.read<ShowCourseTeacherCubit>().emitShowCourseTeacher(idCourse: teacherInformation.courses[index].id);
            },
            contentPadding: const EdgeInsets.only(left: 0.0, right: 0.0),
            title: Text(
              teacherInformation.courses[index].title,
              style: TextStyles.font14Black500Weight,
            ),
            leading: SvgPicture.asset(
              'assets/svgs/writing_education_learning_icon.svg',
              width: 24,
              height: 24,
            ),
            subtitle: Text(
              teacherInformation.courses[index].description,
              style:TextStyles.font12NeutralGray400Weight,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        ),
      ),
    ):SectionCard(
    title: AppLocalizations.of(context)!.yourCourses,
    icon: 'assets/svgs/courses_icon.svg',
    widget: ImageAndTextEmptyData(
    message: AppLocalizations.of(context)!.noCoursesAdded),
    );
  }
}
