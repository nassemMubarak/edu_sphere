import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/widgets/app_text_button.dart';
import 'package:edu_sphere/features/teacher/assessments/domain/entities/assessment.dart';
import 'package:edu_sphere/features/teacher/assessments/presentation/bloc/assessments_cubit.dart';
import 'package:edu_sphere/features/teacher/course_main/domain/entities/chapter.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/bloc/course_main_cubit.dart';
import 'package:edu_sphere/features/teacher/teacher_main/logic/teacher_main_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DeleteFileAssessmentInfoDialog extends StatelessWidget {
  AssessmentFile assessmentFile;
  DeleteFileAssessmentInfoDialog({super.key, required this.assessmentFile});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      insetPadding: EdgeInsets.all(16),
      backgroundColor: Colors.white,
      scrollable: true,
      title: Text(
        'Delete File',
        style: TextStyles.font16Black600Weight,
        textAlign: TextAlign.center,
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          verticalSpace(24),
          Text(
            'Do you really want to delete the File ${assessmentFile.title} ?',
            style: TextStyles.font14Red600Weight,
            textAlign: TextAlign.center,
          ),
          verticalSpace(24),
          Row(
            children: [
              Expanded(
                child: AppTextButton(
                  onPressed: () {
                    context.read<AssessmentsCubit>().emitDeleteAssessmentFile(assessmentFile: assessmentFile);
                    context.pop();
                  },
                  buttonText: 'Delete File',
                  textStyle: TextStyles.font12White400Weight,
                  buttonWidth: 160,
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
                  textStyle: TextStyles.font12Black500Weight,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
