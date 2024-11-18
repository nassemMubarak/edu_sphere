import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/widgets/app_text_button.dart';
import 'package:edu_sphere/core/widgets/app_text_form_field.dart';
import 'package:edu_sphere/core/widgets/label_and_widget.dart';
import 'package:edu_sphere/features/teacher/teacher_main/data/model/courses_model.dart';
import 'package:edu_sphere/features/teacher/teacher_main/logic/teacher_main_cubit.dart';
import 'package:edu_sphere/features/teacher/teacher_main/logic/teacher_main_state.dart';
import 'package:edu_sphere/features/teacher/teacher_main/ui/widgets/select_course_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class EditCourseInfoDialog extends StatelessWidget {
  CoursesModel coursesModel;
  int indexCourse;
  EditCourseInfoDialog({super.key, required this.coursesModel,required this.indexCourse});
  @override
  Widget build(BuildContext context) {
    context.read<TeacherMainCubit>().courseNameController =
        TextEditingController(text: coursesModel.title);
    context.read<TeacherMainCubit>().coursePriceController =
        TextEditingController(text: coursesModel.price);
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
      title: Text(AppLocalizations.of(context)!.editCoursesInformation,
        style: TextStyles.font16Black600Weight,
        textAlign: TextAlign.center,
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Form(
            key: context.read<TeacherMainCubit>().globalKey,
            child: Column(
              children: [
                LabelAndWidget(
                  label:  AppLocalizations.of(context)!.courseName,
                  widget: AppTextFormField(
                    controller:
                        context.read<TeacherMainCubit>().courseNameController,
                    hintText:  AppLocalizations.of(context)!.courseName,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return  AppLocalizations.of(context)!.enterCourseName;
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
                SelectCourseType(
                    isSelectedPaid:
                    coursesModel.subTitle == 'Paid'
                        ? true
                        : false),
                verticalSpace(24),
                BlocBuilder<TeacherMainCubit, TeacherMainState>(
                  builder: (context, state) {
                    if(state is changCourseType){
                      return Visibility(
                        visible:
                        state.type == 'Paid',
                        child: LabelAndWidget(
                          label:  AppLocalizations.of(context)!.coursePriceDollar,
                          widget: AppTextFormField(
                            textInputType: TextInputType.number,
                            controller: context
                                .read<TeacherMainCubit>()
                                .coursePriceController,
                            hintText:  AppLocalizations.of(context)!.coursePrice,
                            validator: (value) {
                              if (context.read<TeacherMainCubit>().courseType!='Paid'&&value!.isEmpty) {
                                return  AppLocalizations.of(context)!.enterCoursePrice;
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
                      );
                    }else{
                      return Visibility(
                        visible: coursesModel.subTitle == 'Paid',
                        child: LabelAndWidget(
                          label: AppLocalizations.of(context)!.coursePriceDollar,
                          widget: AppTextFormField(
                            textInputType: TextInputType.number,
                            controller: context
                                .read<TeacherMainCubit>()
                                .coursePriceController,
                            hintText: AppLocalizations.of(context)!.coursePrice,
                            validator: (value) {
                              if (context.read<TeacherMainCubit>().courseType!='Paid'&&value!.isEmpty) {
                                return AppLocalizations.of(context)!.enterCoursePrice;
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
                      );
                    }
                  },
                ),
              ],
            ),
          ),

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
                  buttonText: AppLocalizations.of(context)!.save,
                  buttonWidth: 147,
                ),
              ),
              horizontalSpace(16),
              Expanded(
                child: AppTextButton(
                  onPressed: () {
                    context.read<TeacherMainCubit>().courseType='Paid';
                    context.read<TeacherMainCubit>().coursePriceController=TextEditingController();
                    context.read<TeacherMainCubit>().courseNameController = TextEditingController();
                    context.pop();
                  },
                  buttonText: AppLocalizations.of(context)!.cancel,
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
