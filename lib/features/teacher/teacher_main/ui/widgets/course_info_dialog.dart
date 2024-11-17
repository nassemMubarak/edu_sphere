import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/widgets/app_text_button.dart';
import 'package:edu_sphere/core/widgets/app_text_form_field.dart';
import 'package:edu_sphere/core/widgets/label_and_widget.dart';
import 'package:edu_sphere/features/teacher/teacher_main/data/model/courses_model.dart';
import 'package:edu_sphere/features/teacher/teacher_main/logic/teacher_main_cubit.dart';
import 'package:edu_sphere/features/teacher/teacher_main/ui/widgets/select_course_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseInfoDialog extends StatelessWidget {
  CourseInfoDialog({super.key});
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
        'Courses Information',
        textAlign: TextAlign.center,
        style: TextStyles.font16Black600Weight,
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Form(
            key: context.read<TeacherMainCubit>().globalKey,
            child: LabelAndWidget(
              label: 'Course Name',
              widget: AppTextFormField(
                controller: context
                    .read<TeacherMainCubit>()
                    .courseNameController,
                hintText: 'Courses Name',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter course name';
                  }
                },
                prefixIcon: Padding(
                  padding: EdgeInsets.all(14),
                  child: SvgPicture.asset(
                    'assets/svgs/courses_icon.svg',
                    color: ColorsManager.neutralGray,
                    width: 5,
                    height: 5,
                  ),
                ),
              ),
            ),
          ),
          SelectCourseType(),
          verticalSpace(24),
          Row(
            children: [
              Expanded(
                child: AppTextButton(
                  onPressed: () {
                    print(context.read<TeacherMainCubit>().courseType);
                    if (context
                            .read<TeacherMainCubit>()
                            .globalKey
                            .currentState!
                            .validate() &&
                        context.read<TeacherMainCubit>().courseType != null) {
                      context.read<TeacherMainCubit>().emitAddCourse();
                      context.pop();
                    }
                  },
                  buttonText: 'Add Courses',
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
