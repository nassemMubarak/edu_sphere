import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/util/toast_notification_message.dart';
import 'package:edu_sphere/core/widgets/app_text_button.dart';
import 'package:edu_sphere/core/widgets/dropdown_widget.dart';
import 'package:edu_sphere/core/widgets/label_and_widget.dart';
import 'package:edu_sphere/features/teacher/assessments/presentation/bloc/assessments_cubit.dart';
import 'package:edu_sphere/features/teacher/assessments/presentation/widgets/estimate_widget/loading_add_estimate_widgte.dart';
import 'package:flutter/material.dart';
import 'package:edu_sphere/l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditAssessmentEvaluationDialog extends StatefulWidget {
  int idStudent;
   int idCourse;
   int idAssessment;
   int grade;
   int idEstimate;
   int indexEstimateAssessment;
  EditAssessmentEvaluationDialog({super.key,
  required this.idAssessment,
  required this.idCourse,
  required this.grade,
  required this.idEstimate,
  required this.indexEstimateAssessment,
  required this.idStudent,
  });

  @override
  State<EditAssessmentEvaluationDialog> createState() => _EditAssessmentEvaluationDialogState();
}

class _EditAssessmentEvaluationDialogState extends State<EditAssessmentEvaluationDialog> {
   List<String> score = [];
    int mark = 0;
  @override
  Widget build(BuildContext context) {
   score =  List.generate(widget.grade, (index) => (index + 1).toString().padLeft(2, '0'));
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
        'Edit Assignment Evaluation',
        style: TextStyles.font16Black600Weight,
        textAlign: TextAlign.center,
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          verticalSpace(24),
          LabelAndWidget(
            label: 'Question Score',
            widget: DropdownWidget(items: score,prefixIcon: SvgPicture.asset('assets/svgs/quiz_score_icon.svg'),hintText: 'Assessment Score',onChanged: (val){
              setState(() {
                mark = int.parse(val!);
              });
              // context.read<QuizCubit>().questionScore = val;
            },),
          ),

          LoadingAddEstimateWidgte(),
          verticalSpace(24),
          Row(
            children: [
              Expanded(
                child: AppTextButton(
                  onPressed: () {
                    context.read<AssessmentsCubit>().emitAddEstimateAssessment(idCourse: widget.idCourse, idAssessment: widget.idAssessment, idStudent: widget.idStudent, mark: mark);
                    // context.pop();
                  },
                  buttonText: 'Save',
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
