import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/widgets/app_text_button.dart';
import 'package:edu_sphere/core/widgets/app_text_form_field.dart';
import 'package:edu_sphere/core/widgets/dropdown_widget.dart';
import 'package:edu_sphere/core/widgets/label_and_widget.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/bloc/course_main_cubit.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/widgets/quize/slecte_date_widget.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/widgets/quize/slecte_time_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddQuizeDilog extends StatelessWidget {
  const AddQuizeDilog({super.key});

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
        'Quiz',
        style: TextStyles.font16Black600Weight,
        textAlign: TextAlign.center,
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Form(
            key: context.read<CourseMainCubit>().globalLectureKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                LabelAndWidget(
                  label: 'Quiz Title',
                  widget: AppTextFormField(
                    controller: context
                        .read<CourseMainCubit>()
                        .quizeTitleTextEditionController,
                    textStyle: TextStyles.font12Black700Weight,
                    hintText: 'Quiz title',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Quiz Title';
                      }
                    },
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(15),
                      child: SvgPicture.asset(
                        'assets/svgs/icon_quize_title.svg',
                        color: ColorsManager.neutralGray,
                        width: 15,
                        height: 15,
                      ),
                    ),
                  ),
                ),
                LabelAndWidget(
                  label: 'Quiz Description',
                  widget: AppTextFormField(
                    controller: context
                        .read<CourseMainCubit>()
                        .quizeDescriptionTextEditionController,
                    textStyle: TextStyles.font12Black700Weight,
                    maxLines: 5,
                    hintText: 'Quiz Description',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Quiz Description';
                      }
                    },
                    prefixIcon: Container(
                      height: 95,
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
                verticalSpace(8),
                const SlecteDateWidget(title: 'Quiz start date'),
                verticalSpace(16),
                const SlecteDateWidget(title: 'Quiz start date'),
                verticalSpace(8),
                SlecteTimeWidget(title: 'Quiz start time'),
                verticalSpace(16),
                SlecteTimeWidget(title: 'Quiz end time'),
              ],
            ),
          ),
          verticalSpace(24),
          Row(
            children: [
              Expanded(
                child: AppTextButton(
                  onPressed: () {
                    if (context
                        .read<CourseMainCubit>()
                        .globalQuizeKey
                        .currentState!
                        .validate()) {}
                  },
                  buttonText: 'Add Quize',
                  buttonWidth: 147,
                ),
              ),
              horizontalSpace(16),
              Expanded(
                child: AppTextButton(
                  onPressed: () {
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
    );
  }
}
