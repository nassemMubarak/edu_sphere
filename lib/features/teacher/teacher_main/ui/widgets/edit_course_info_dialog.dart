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

class EditCourseInfoDialog extends StatelessWidget {
  CoursesModel coursesModel;
  int indexCourse;
  EditCourseInfoDialog({super.key, required this.coursesModel,required this.indexCourse});
  @override
  Widget build(BuildContext context) {
    context.read<TeacherMainCubit>().courseNameController =
        TextEditingController(text: coursesModel.title);
    context.read<TeacherMainCubit>().courseType = coursesModel.subTitle;
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
        'Edit Courses Information',
        style: TextStyles.font16Black600Weight,
        textAlign: TextAlign.center,
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Form(
            key: context.read<TeacherMainCubit>().globalKey,
            child: LabelAndWidget(
              label: 'Courses Name',
              widget: AppTextFormField(
                controller:
                    context.read<TeacherMainCubit>().courseNameController,
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
          SelectCourseType(
              isSelectedPaid:
                  context.read<TeacherMainCubit>().courseType == 'Paid'
                      ? true
                      : false),
          verticalSpace(24),
          Row(
            children: [
              Expanded(
                child: AppTextButton(
                  onPressed: () {
                    if (context
                            .read<TeacherMainCubit>()
                            .globalKey
                            .currentState!
                            .validate() &&
                        context.read<TeacherMainCubit>().courseType != null) {
                      context.read<TeacherMainCubit>().emitEditCourse(indexCourse: indexCourse);
                      context.pop();
                    }
                  },
                  buttonText: 'Save',
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
