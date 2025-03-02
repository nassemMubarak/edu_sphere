import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/widgets/app_text_button.dart';
import 'package:edu_sphere/features/teacher/assessments/domain/entities/assessment.dart';
import 'package:edu_sphere/features/teacher/assessments/presentation/bloc/assessments_cubit.dart';
import 'package:edu_sphere/features/teacher/assessments/presentation/widgets/assessment_widget/loading_add_or_update_or_assessment_quiz_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:edu_sphere/l10n/app_localizations.dart';
import 'package:logger/logger.dart';



class ShowOrHidAssessmentInfoDialog extends StatelessWidget {
  int idCourse;
  Assessment assessment;

  ShowOrHidAssessmentInfoDialog({super.key, required this.assessment,required this.idCourse});

  @override
  Widget build(BuildContext context) {
    Logger().f('=------------->assessment---------------${assessment.visibility}');
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
        assessment.visibility ? 'Hide Assessment' : 'Show Assessment',
        style: TextStyles.font16Black600Weight,
        textAlign: TextAlign.center,
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          verticalSpace(24),
          Text(
            assessment.visibility
                ? 'Do you really want to hide the assessment ?'
                : 'Do you really want to show the assessment ?',
            style: TextStyles.font14Red600Weight,
            textAlign: TextAlign.center,
          ),
          verticalSpace(16),
          Text(
            assessment.visibility
                ? 'If you hide the quiz, it will not appear to students until you show it again'
                : 'Do you want to show the assessment to students?',
            style: TextStyles.font14Black400Weight,
            textAlign: TextAlign.center,
          ),
          verticalSpace(24),
          LoadingAddOrUpdateOrAssessmentQuizWidget(message: 'The assessment has been updated successfully.'),

          Row(
            children: [
              Expanded(
                child: AppTextButton(
                  onPressed: () {
                    context
                        .read<AssessmentsCubit>()
                        .emitUpdateVisibilityAssessment(idAssessment: assessment.id,idCourse: idCourse,visibility: !assessment.visibility);
                  },
                  buttonText: assessment.visibility ? 'Hide Assessment':'Show Assessment' ,
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
