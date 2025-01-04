import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/widgets/app_text_button.dart';
import 'package:edu_sphere/core/widgets/app_text_form_field.dart';
import 'package:edu_sphere/core/widgets/label_and_widget.dart';
import 'package:edu_sphere/features/teacher/assessments/presentation/bloc/assessments_cubit.dart';
import 'package:edu_sphere/features/teacher/assessments/presentation/widgets/assessment_widget/date_assessment_widget.dart';
import 'package:edu_sphere/features/teacher/assessments/presentation/widgets/assessment_widget/loading_add_or_update_or_assessment_quiz_widget.dart';
import 'package:edu_sphere/features/teacher/assessments/presentation/widgets/assessment_widget/time_assessment_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddAssessmentDialog extends StatelessWidget {
  int idCourse;
   AddAssessmentDialog({super.key,required this.idCourse});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 24.w),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      insetPadding: EdgeInsets.all(5),
      backgroundColor: Colors.white,
      scrollable: true,
      title: Text(
        'Add Assessment',
        style: TextStyles.font16Black600Weight,
        textAlign: TextAlign.center,
      ),
      content: Container(
        width: 0.85.sw,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Form(
              key: context.read<AssessmentsCubit>().globalAssessmentKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  LabelAndWidget(
                    label: 'Assessment Title',
                    widget: AppTextFormField(
                      controller: context
                          .read<AssessmentsCubit>()
                          .assessmentTitleTextEditionController,
                      hintText: 'Assessment title',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Assessment Title';
                        }
                      },
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(15),
                        child: SvgPicture.asset(
                          'assets/svgs/annual_assessment_icon.svg',
                          color: ColorsManager.neutralGray,
                          width: 15,
                          height: 15,
                        ),
                      ),
                    ),
                  ),
                  LabelAndWidget(
                    label: 'Assessment Description',
                    widget: AppTextFormField(
                      controller: context
                          .read<AssessmentsCubit>()
                          .assessmentDescriptionTextEditionController,
                      maxLines: 5,
                      hintText: 'Assessment Description',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Assessment Description';
                        }
                      },
                      prefixIcon: Container(
                        height: 115,
                        width: 50,
                        alignment: AlignmentDirectional.topCenter,
                        child: const Icon(
                          Icons.message_outlined,
                          size: 20,
                          color: ColorsManager.neutralGray,
                        ),
                      ),
                    ),
                  ),
                  // Select Start And End Date Quiz Widget
                  DateAssessmentWidget(),
                  verticalSpace(16),
                  // Select Start And End Time Quiz Widget
                  TimeAssessmentWidget(),
                  verticalSpace(16),
                  LabelAndWidget(
                    label: 'Assessment Score',
                    widget: AppTextFormField(
                      textInputType: TextInputType.number,
                      controller: context
                          .read<AssessmentsCubit>()
                          .assessmentScoreTextEditionController,
                      hintText: 'assessment score',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter assessment score';
                        }
                      },
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(15),
                        child: SvgPicture.asset(
                          'assets/svgs/quiz_score_icon.svg',
                          color: ColorsManager.neutralGray,
                          width: 15,
                          height: 15,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            LoadingAddOrUpdateOrAssessmentQuizWidget(message: 'The assessment has been added successfully.'),
            BlocBuilder<AssessmentsCubit,AssessmentsState>(
              builder: (context, state) {
                if(state is ErrorMessageAddAssessment){
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSpace(10),
                      Text(state.message,style: TextStyles.font12Red400Weight),
                      verticalSpace(10),
                    ],
                  );
                }else{
                  return SizedBox.shrink();
                }
              },
            ),
            verticalSpace(10),
            Row(
              children: [
                Expanded(
                  child: AppTextButton(
                    onPressed: () {
                      if (context
                              .read<AssessmentsCubit>()
                              .globalAssessmentKey
                              .currentState!
                              .validate()&&context.read<AssessmentsCubit>().validateDateTimeAssessment() &&
                          context
                                  .read<AssessmentsCubit>()
                                  .isSuccessSelectDateTime ==
                              true) {
                              context.read<AssessmentsCubit>().emitAddAssessment(idCourse: idCourse);
                      }

                    },
                    buttonText: 'Add Ass',
                    buttonWidth: 147,
                  ),
                ),
                horizontalSpace(16),
                Expanded(
                  child: AppTextButton(
                    onPressed: () {
                      context.read<AssessmentsCubit>().assessmentTitleTextEditionController = TextEditingController();
                      context.read<AssessmentsCubit>().assessmentDescriptionTextEditionController = TextEditingController();
                      context.read<AssessmentsCubit>().assessmentScoreTextEditionController = TextEditingController();
                      context.read<AssessmentsCubit>().selectedStartDateAssessment = null;
                      context.read<AssessmentsCubit>().selectedEndDateAssessment = null;
                      context.read<AssessmentsCubit>().startDateTimeAssessment = null;
                      context.read<AssessmentsCubit>().endDateTimeAssessment = null;
                      context.read<AssessmentsCubit>().errorMessageAssessment = null;
                      context.pop();
                    },
                    buttonText: 'Cancel',
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
