import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/widgets/app_text_button.dart';
import 'package:edu_sphere/features/teacher/quiz/domain/entities/quiz.dart';
import 'package:edu_sphere/features/teacher/quiz/presentation/bloc/quiz_cubit.dart';
import 'package:edu_sphere/features/teacher/quiz/presentation/widgets/quiz_widget/loading_add_or_update_or_delete_quiz_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ShowOrHidQuizInfoDialog extends StatelessWidget {
  Quiz quiz;
  int idCourse;
  ShowOrHidQuizInfoDialog({super.key, required this.quiz,required this.idCourse});

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
        quiz.visibility==0 ? 'Show Quiz' : 'Hide Quiz',
        style: TextStyles.font16Black600Weight,
        textAlign: TextAlign.center,
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          verticalSpace(24),
          Text(
            quiz.visibility==0
                ? 'Do you really want to show the quiz ?'
                : 'Do you really want to hide the quiz ?',
            style: TextStyles.font14Red600Weight,
            textAlign: TextAlign.center,
          ),
          verticalSpace(16),
          LoadingAddOrUpdateOrDeleteQuizWidget(message: 'The quiz has been update successfully.'),
          Text(
            quiz.visibility==0
                ? 'Do you want to show the quiz to students?'
                : 'If you hide the quiz, it will not appear to students until you show it again',
            style: TextStyles.font14Black400Weight,
            textAlign: TextAlign.center,
          ),
          verticalSpace(24),
          Row(
            children: [
              Expanded(
                child: AppTextButton(
                  onPressed: () {
                    context
                        .read<QuizCubit>()
                        .emitUpdateVisibilityQuiz(idCourse: idCourse, idQuiz: quiz.id, visibility: quiz.visibility);
                  },
                  buttonText: quiz.visibility==0 ? 'Show Quiz' : 'Hide Quiz',
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
