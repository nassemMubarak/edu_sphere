import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/widgets/app_text_button.dart';
import 'package:edu_sphere/core/widgets/app_text_form_field.dart';
import 'package:edu_sphere/core/widgets/label_and_widget.dart';
import 'package:edu_sphere/edu_sphere_app.dart';
import 'package:edu_sphere/features/teacher/quiz/presentation/bloc/question/question_cubit.dart';
import 'package:edu_sphere/features/teacher/quiz/presentation/bloc/quiz_cubit.dart';
import 'package:edu_sphere/features/teacher/quiz/presentation/widgets/questions_widgets/add_options_widget.dart';
import 'package:edu_sphere/features/teacher/quiz/presentation/widgets/questions_widgets/loading_add_or_update_or_delete_question_widget.dart';
import 'package:edu_sphere/features/teacher/quiz/presentation/widgets/questions_widgets/upload_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';

class AddQuestionDialog extends StatelessWidget {
  int idCourse;
  int idQuiz;
   AddQuestionDialog({super.key,required this.idQuiz,required this.idCourse});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      insetPadding: const EdgeInsets.all(16),
      backgroundColor: Colors.white,
      scrollable: true,
      title: Text(
        'Add question',
        style: TextStyles.font16Black600Weight,
        textAlign: TextAlign.center,
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Form(
            key: context.read<QuestionCubit>().formQuestionKey,
            child: LabelAndWidget(
              verticalUnderText: 12,
              label: 'Question Title',
              widget: AppTextFormField(
                controller: context.read<QuestionCubit>().questionTitle,
                maxLines: 5,
                hintText: 'questions Title',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter Question Title';
                  }
                },
                prefixIcon: Container(
                  height: 115,
                  width: 50,
                  alignment: AlignmentDirectional.topCenter,
                  child:
                      SvgPicture.asset('assets/svgs/question_message_icon.svg'),
                ),
              ),
            ),
          ),
          UploadImageWidget(),
          verticalSpace(16),
          AddOptionsWidget(),
          BlocBuilder<QuestionCubit,QuestionState>(
            builder: (context, state) {
              if(state is ErrorAddOptions){
                return state.error!=null?Column(
                  children: [
                    Text(state.error!,style: TextStyles.font12Red400Weight),
                    verticalSpace(15),
                  ],
                ):SizedBox.shrink();
              }else{
                return SizedBox.shrink();
              }
            },
          ),
          Row(
            children: [
              Expanded(
                child: AppTextButton(
                  onPressed: () {
                    if (context
                            .read<QuestionCubit>()
                            .formQuestionKey
                            .currentState!
                            .validate() &&
                        context
                            .read<QuestionCubit>()
                            .formOption1Key
                            .currentState!
                            .validate() &&

                        context
                            .read<QuestionCubit>()
                            .formOption2Key
                            .currentState!
                            .validate()&&context.read<QuestionCubit>().addOrRemoveNumberOption>=2?context
                        .read<QuestionCubit>()
                        .formOption3Key
                        .currentState!.validate()&&context
                        .read<QuestionCubit>()
                        .formOption4Key
                        .currentState!.validate():context.read<QuestionCubit>().addOrRemoveNumberOption>=1?context
                        .read<QuestionCubit>()
                        .formOption3Key.currentState!.validate():true&&context.read<QuestionCubit>().emitValidateCorrectChoiceAndQuestionScore()
                    ) {
                      ///
                      context.read<QuestionCubit>().emitAddQuestion(idCourse: idCourse, idQuiz: idQuiz);
                      // context.pop();
                    }
                    // context
                    //     .read<CourseMainCubit>()
                    //     .emitChangShoeOrHidQuiz(context: context, quiz: quiz);
                  },
                  buttonText: 'Add Question',
                  textStyle: TextStyles.font12White400Weight,
                  buttonWidth: 160,
                ),
              ),
              LoadingAddOrUpdateOrDeleteQuestionWidget(message: 'The question has been added successfully.'),
              horizontalSpace(16),
              Expanded(
                child: AppTextButton(
                  onPressed: () {
                    context.read<QuestionCubit>().emitClearOptions();
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
