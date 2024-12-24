import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/widgets/app_text_button.dart';
import 'package:edu_sphere/features/teacher/teacher_main/presentation/logic/teacher_main_cubit.dart';
import 'package:edu_sphere/features/teacher/teacher_main/presentation/widgets/loading_add_or_update_or_delete_course.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class DeleteCourseInfoDialog extends StatelessWidget {
  int indexCourse;
  String courseTitle;
  int courseId;
  DeleteCourseInfoDialog({super.key, required this.indexCourse,required this.courseTitle,required this.courseId});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        insetPadding: EdgeInsets.all(16),
        backgroundColor: Colors.white,
        scrollable: true,
        title: Text(
          AppLocalizations.of(context)!.deleteCourse,
          style: TextStyles.font16Black600Weight,
          textAlign: TextAlign.center,
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            verticalSpace(24),
            Text(AppLocalizations.of(context)!.deleteConfirmation(courseTitle),
              style: TextStyles.font14Red600Weight,
              textAlign: TextAlign.center,
            ),
            LoadingAddOrUpdateOrDeleteCourse(messageSuccessful: 'Delete Course Successful'),
            verticalSpace(24),
            Row(
              children: [
                Expanded(
                  child: AppTextButton(
                    onPressed: () {
                      context
                            .read<TeacherMainCubit>()
                            .emitDeleteCourse(indexCourse: indexCourse,courseId: courseId);
                    },
                    buttonText: AppLocalizations.of(context)!.deleteCourse,
                    buttonWidth: 147,
                  ),
                ),
                horizontalSpace(16),
                Expanded(
                  child: AppTextButton(
                    onPressed: () {
                      context.pop();
                    },
                    buttonText: AppLocalizations.of(context)!.cancel,
                    buttonWidth: 147,
                    backgroundColor: Colors.white,
                    textStyle: TextStyles.font14Black600Weight,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
