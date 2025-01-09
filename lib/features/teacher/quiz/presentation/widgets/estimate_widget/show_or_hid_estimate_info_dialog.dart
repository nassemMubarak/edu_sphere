import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/widgets/app_text_button.dart';
import 'package:edu_sphere/features/teacher/quiz/presentation/bloc/quiz_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ShowOrHidEstimateInfoDialog extends StatelessWidget {
  bool isHide;

  ShowOrHidEstimateInfoDialog({super.key, required this.isHide});

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
        isHide ? 'Show Estimate' : 'Hide Estimate',
        style: TextStyles.font16Black600Weight,
        textAlign: TextAlign.center,
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          verticalSpace(24),
          Text(
            isHide
                ? 'Do you really want to show the estimate ?'
                : 'Do you really want to hide the estimate ?',
            style: TextStyles.font14Red600Weight,
            textAlign: TextAlign.center,
          ),
          verticalSpace(16),
          Text(
            isHide
                ? 'Do you want to show the Estimate to students?'
                : 'If you hide the Estimate, it will not appear to students until you show it again',
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
                        .emitIsHideEstimation(!isHide);
                    context.pop();
                  },
                  buttonText: isHide ? 'Show Evaluation' : 'Hide Evaluation',
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
