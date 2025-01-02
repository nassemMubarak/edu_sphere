import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/widgets/app_text_button.dart';
import 'package:edu_sphere/core/widgets/app_text_form_field.dart';
import 'package:edu_sphere/core/widgets/label_and_widget.dart';
import 'package:edu_sphere/edu_sphere_app.dart';
import 'package:edu_sphere/features/teacher/quiz/domain/entities/question.dart';
import 'package:edu_sphere/features/teacher/quiz/domain/entities/question1.dart';
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

class EditQuestionDialog extends StatelessWidget {
  Question question;
  int indexQuestion;
  int idCourse;
  int idQuiz;
   EditQuestionDialog({super.key,required this.question,required this.indexQuestion,required this.idQuiz,required this.idCourse});

  @override
  Widget build(BuildContext context) {
    Logger().w(question);
   context.read<QuestionCubit>().questionTitle = TextEditingController(text: question.title);
   context.read<QuestionCubit>().firstChoice = TextEditingController(text: question.options[0]);
   context.read<QuestionCubit>().secondChoice = TextEditingController(text: question.options[1]);
   context.read<QuestionCubit>().thirdChoice = TextEditingController(text: question.options.length>2?question.options[2]:null);
   context.read<QuestionCubit>().forthChoice = TextEditingController(text: question.options.length>3?question.options[3]:null);
   context.read<QuestionCubit>().correctChoice = question.correctAnswer;
   context.read<QuestionCubit>().questionScore = question.mark.toString();
   // context.read<QuestionCubit>().questionPathImage = question.documents!=null&&question.documents!.isNotEmpty?question.documents![0].url:null;
   context.read<QuestionCubit>().addOrRemoveNumberOption = question.options.length;
   context.read<QuestionCubit>().emitNumberOption(question.options.length-2);

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
        'Edit question',
        style: TextStyles.font16Black600Weight,
        textAlign: TextAlign.center,
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LoadingAddOrUpdateOrDeleteQuestionWidget(message: 'The Question has been successfully update'),
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
          // UploadImageWidget(imagePath: context.read<QuestionCubit>().questionPathImage),
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
                      context.read<QuestionCubit>().emitEditQuestion(idCourse: idCourse, idQuiz: idQuiz, idQuestion: question.id, indexQuestion: indexQuestion);
                    }
                    // context
                    //     .read<CourseMainCubit>()
                    //     .emitChangShoeOrHidQuiz(context: context, quiz: quiz);
                  },
                  buttonText: 'Edit Question',
                  textStyle: TextStyles.font12White400Weight,
                  buttonWidth: 160,
                ),
              ),
              horizontalSpace(16),
              Expanded(
                child: AppTextButton(
                  onPressed: () {
                    context.read<QuestionCubit>().emitClearOptions();
                    context.read<QuestionCubit>().emitClearQuestionInputs();
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
