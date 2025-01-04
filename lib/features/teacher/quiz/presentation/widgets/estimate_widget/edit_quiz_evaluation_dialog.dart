import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/util/toast_notification_message.dart';
import 'package:edu_sphere/core/widgets/app_text_button.dart';
import 'package:edu_sphere/core/widgets/dropdown_widget.dart';
import 'package:edu_sphere/core/widgets/label_and_widget.dart';
import 'package:edu_sphere/features/teacher/assessments/presentation/widgets/assessment_widget/loading_add_or_update_or_assessment_quiz_widget.dart';
import 'package:edu_sphere/features/teacher/quiz/presentation/bloc/quiz_cubit.dart';
import 'package:edu_sphere/features/teacher/quiz/presentation/widgets/quiz_widget/loading_add_or_update_or_delete_quiz_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class EditQuizEvaluationDialog extends StatefulWidget {
  int idCourse;
  int idQuiz;
  int grade;
  int? selectGrad;
  int idEstimate;
  int indexEstimateQuiz;
   EditQuizEvaluationDialog({super.key,required this.idQuiz,
     required this.idCourse,
     required this.grade,
     required this.idEstimate,
     required this.indexEstimateQuiz,});

  @override
  State<EditQuizEvaluationDialog> createState() => _EditQuizEvaluationDialogState();
}

class _EditQuizEvaluationDialogState extends State<EditQuizEvaluationDialog> {
  List<String> score = [];

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
        'Edit Quiz Evaluation',
        style: TextStyles.font16Black600Weight,
        textAlign: TextAlign.center,
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          verticalSpace(24),
          LabelAndWidget(
            label: 'Question Score',
            widget: DropdownWidget(items: score,prefixIcon: SvgPicture.asset('assets/svgs/quiz_score_icon.svg'),hintText: 'Question Score',onChanged: (val){
              setState(() {
                widget.selectGrad = int.parse(val!);
              });
              // context.read<QuizCubit>().questionScore = val;
            },),
          ),
          verticalSpace(24),
        BlocConsumer<QuizCubit, QuizState>(
          builder: (context, state) => SizedBox.shrink(),
          listener: (context, state) {
            if (state is AddOrUpdateOrDeleteLoadingState) {
              context.loading();
            } else if (state is QuizMessageErrorState) {
              ToastNotificationMessage().showToastNotificationError(
                  message: state.message, context: context);
              context.pop();
            } else if (state is GetAllEstimateQuizLoadedState) {
              ToastNotificationMessage().showNotificationSuccess(
                  message: 'The estimate has been delete successfully.',
                  context: context);
              context.pop();
              context.pop();
            }
          },
        ),
          Row(
            children: [
              Expanded(
                child: AppTextButton(
                  onPressed: () {
                    context.read<QuizCubit>().emitUpdateEstimateQuiz(idCourse: widget.idCourse, idQuiz: widget.idQuiz, grade: widget.selectGrad??widget.grade, idEstimate: widget.idEstimate, indexEstimateQuiz: widget.indexEstimateQuiz);
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
