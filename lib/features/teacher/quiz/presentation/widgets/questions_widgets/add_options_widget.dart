import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/widgets/app_text_form_field.dart';
import 'package:edu_sphere/core/widgets/dropdown_widget.dart';
import 'package:edu_sphere/core/widgets/label_and_widget.dart';
import 'package:edu_sphere/features/auth/presentation/bloc/auth/auth_cubit.dart';
import 'package:edu_sphere/features/teacher/quiz/presentation/bloc/quiz_cubit.dart';
import 'package:edu_sphere/features/teacher/quiz/presentation/widgets/questions_widgets/dropdown_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';

class AddOptionsWidget extends StatelessWidget {
   AddOptionsWidget({super.key});
  List<String> correctChoiceList = [
    'First Choice',
    'Second Choice',
    'Third Choice',
    'Forth Choice',
  ];
  List<String> questionScoreList = [
    '1',
    '2',
    '3',
    '4',
    '5',
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: context.read<QuizCubit>().formOption1Key,
          child: LabelAndWidget(
            verticalUnderText: 12,
            label: 'First Choice',
            widget: AppTextFormField(
              controller: context.read<QuizCubit>().firstChoice,
              maxLines: 5,
              hintText: 'First Choice',
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter First Choice';
                }
              },
              prefixIcon: Container(
                height: 115,
                width: 50,
                alignment: AlignmentDirectional.topCenter,
                child: SvgPicture.asset('assets/svgs/choice_icon.svg'),
              ),
            ),
          ),
        ),
        Form(
          key: context.read<QuizCubit>().formOption2Key,
          child: LabelAndWidget(
            verticalUnderText: 12,
            label: 'Second Choice',
            widget: AppTextFormField(
              controller: context.read<QuizCubit>().secondChoice,
              maxLines: 5,
              hintText: 'Second Choice',
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter Second Choice';
                }
              },
              prefixIcon: Container(
                height: 115,
                width: 50,
                alignment: AlignmentDirectional.topCenter,
                child: SvgPicture.asset('assets/svgs/choice_icon.svg'),
              ),
            ),
          ),
        ),
        BlocBuilder<QuizCubit, QuizState>(
          builder: (context, state) {
            if (state is AddOrRemoveNewOption) {
              return Column(
                children: [
                  Visibility(
                    visible: state.numberOption >= 1,
                    child: Form(
                      key:context.read<QuizCubit>().formOption3Key ,
                      child: LabelAndWidget(
                        verticalUnderText: 12,
                        label: 'Third Choice',
                        widget: AppTextFormField(

                          controller: context.read<QuizCubit>().thirdChoice,
                          maxLines: 5,
                          hintText: 'Third Choice',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Third Choice';
                            }
                          },
                          prefixIcon: Container(
                            height: 115.h,
                            width: 50.w,
                            alignment: AlignmentDirectional.topCenter,
                            child:
                                SvgPicture.asset('assets/svgs/choice_icon.svg'),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: state.numberOption == 2,
                    child: Form(
                      key:context.read<QuizCubit>().formOption4Key ,
                      child: LabelAndWidget(
                        verticalUnderText: 12,
                        label: 'Forth Choice',
                        widget: AppTextFormField(

                          controller: context.read<QuizCubit>().forthChoice,
                          maxLines: 5,
                          hintText: 'Forth Choice',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Forth Choice';
                            }
                          },
                          prefixIcon: Container(
                            height: 115.h,
                            width: 50.w,
                            alignment: AlignmentDirectional.topCenter,
                            child:
                                SvgPicture.asset('assets/svgs/choice_icon.svg'),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: state.numberOption < 2,
                    child: ListTile(
                      onTap: () {
                        context.read<QuizCubit>().emitAddNewOptions();
                      },
                      contentPadding: EdgeInsets.zero,
                      leading: Container(
                        height: 24.h,
                        width: 24.w,
                        decoration: BoxDecoration(
                            color: ColorsManager.secondaryColor,
                            borderRadius: BorderRadius.circular(5)),
                        child: Icon(Icons.add, color: Colors.white),
                      ),
                      title: Text(
                        'Add new option',
                        style: TextStyles.font14Black400Weight,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: state.numberOption>0,
                    child: ListTile(
                      onTap: () {
                        context.read<QuizCubit>().emitRemoveOptions();
                      },
                      contentPadding: EdgeInsets.zero,
                      leading: Container(
                        height: 24.h,
                        width: 24.w,
                        decoration: BoxDecoration(
                            color: ColorsManager.secondaryColor,
                            borderRadius: BorderRadius.circular(5)),
                        child: Icon(Icons.remove, color: Colors.white),
                      ),
                      title: Text(
                        'Remove Option',
                        style: TextStyles.font14Black400Weight,
                      ),
                    ),
                  ),
                  LabelAndWidget(
                    label: 'Correct choice',
                    widget: DropdownWidget(items:  state.numberOption==0?correctChoiceList.sublist(0,2):state.numberOption==1?correctChoiceList.sublist(0,3):correctChoiceList,prefixIcon: SvgPicture.asset('assets/svgs/choice_icon.svg'),hintText: 'Correct choice',onChanged: (val){
                      context.read<QuizCubit>().correctChoice = val;
                    },),
                  ),
                ],
              );
            } else {
              return Column(
                children: [
                  ListTile(
                    onTap: () {
                      context.read<QuizCubit>().emitAddNewOptions();
                    },
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                      height: 24.h,
                      width: 24.w,
                      decoration: BoxDecoration(
                          color: ColorsManager.secondaryColor,
                          borderRadius: BorderRadius.circular(5)),
                      child: Icon(Icons.add, color: Colors.white),
                    ),
                    title: Text(
                      'Add new option',
                      style: TextStyles.font14Black400Weight,
                    ),
                  ),
                  verticalSpace(16),
                  LabelAndWidget(
                    label: 'Correct choice',
                    widget: DropdownWidget(items:  correctChoiceList.sublist(0,2),prefixIcon: SvgPicture.asset('assets/svgs/choice_icon.svg'),hintText: 'Correct choice',onChanged: (val){
                      context.read<QuizCubit>().correctChoice = val;
                    },),
                  ),
                ],
              );
            }
          },
        ),

        LabelAndWidget(
          label: 'Question Score',
          widget: DropdownWidget(items: questionScoreList,prefixIcon: SvgPicture.asset('assets/svgs/quiz_score_icon.svg'),hintText: 'Question Score',onChanged: (val){
            context.read<QuizCubit>().questionScore = val;
          },),
        ),
      ],
    );
  }
}
