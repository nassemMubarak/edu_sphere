import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/features/teacher/teacher_main/data/model/courses_model.dart';
import 'package:edu_sphere/features/teacher/teacher_main/domain/entities/course.dart';
import 'package:edu_sphere/features/teacher/teacher_main/presentation/widgets/delete_course_info_dialog.dart';
import 'package:edu_sphere/features/teacher/teacher_main/presentation/widgets/edit_course_info_dialog.dart';
import 'package:edu_sphere/features/teacher/teacher_main/presentation/widgets/warning_message_teacher_info_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TitelAndIconListTaileWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  final String iconUrl;
  final bool? isShowTrailing;
  final TextStyle? subTitleStyle;
  final Course? coursesModel;
  final int? indexCourse;
  final bool isShowEditButton;
   bool? isDeleteEditButton;
  final Function()? onTap;
  final Function()? onDeleteIconTap;
     TitelAndIconListTaileWidget(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.iconUrl,
      required this.isShowEditButton,
       this.isDeleteEditButton,

      this.isShowTrailing,
      this.subTitleStyle,
      this.coursesModel,
      this.indexCourse,
      this.onTap,
      this.onDeleteIconTap,
      });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.only(left: 0.0, right: 0.0),
      title: Text(
        title,
        style: TextStyles.font14Black500Weight,
      ),
      leading: SvgPicture.asset(
        iconUrl,
        width: 24,
        height: 24,
      ),
      subtitle: Text(
        subTitle,
        style: subTitleStyle ?? TextStyles.font12NeutralGray400Weight,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
      ),
      trailing: isShowTrailing == null
          ? null
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Visibility(
                  visible: isShowEditButton,
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => WarningMessageTeacherInfoDialog(
                          title: 'Do you really want to Edit Course Information?',
                          subTitle: 'This action will delete the request you sent to the camp',
                          textButton: 'Edit Course',
                          onTap: () {
                            context.pop();
                            showDialog(
                              context: context,
                              builder: (context) => EditCourseInfoDialog(
                                indexCourse: indexCourse!,
                                coursesModel: coursesModel!,
                              ),
                            );
                          },
                        ),
                      );
                    },
                    child: SvgPicture.asset(
                      'assets/svgs/edite_icon.svg',
                      width: 24,
                      height: 24,
                    ),
                  ),
                ),
                horizontalSpace(8),
                Visibility(
                  visible: isDeleteEditButton==null?true:false,
                  child: GestureDetector(
                    onTap:onDeleteIconTap?? () {
                      showDialog(
                        context: context,
                        builder: (context) => WarningMessageTeacherInfoDialog(
                          title: 'Do you really want to delete Course?',
                          subTitle: 'This action will delete the request you sent to the camp',
                          textButton: 'Delete Course',
                          onTap: () {
                            context.pop();
                            showDialog(
                              context: context,
                              builder: (context) => WarningMessageTeacherInfoDialog(
                                title: 'Do you really want to delete Course?',
                                subTitle: 'If you want to delete the course, this will result in deleting all the course contents and all its students.',
                                textButton: 'Accepts',
                                onTap: () {
                                  context.pop();
                                  showDialog(
                                    context: context,
                                    builder: (context) => DeleteCourseInfoDialog(
                                      indexCourse: indexCourse!,
                                      courseTitle: coursesModel!.title,
                                      courseId: coursesModel!.id,
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      );

                    },
                    child: SvgPicture.asset(
                      'assets/svgs/delete_icon.svg',
                      width: 24,
                      height: 24,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
