import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/routing/routes.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/features/teacher/teacher_main/logic/teacher_main_cubit.dart';
import 'package:edu_sphere/features/teacher/teacher_main/logic/teacher_main_state.dart';
import 'package:edu_sphere/features/teacher/teacher_main/ui/widgets/course_info_dialog.dart';
import 'package:edu_sphere/core/widgets/image_and_text_empty_data.dart';
import 'package:edu_sphere/features/teacher/teacher_main/ui/widgets/section_card.dart';
import 'package:edu_sphere/features/teacher/teacher_main/ui/widgets/titel_and_icon_list_taile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class SectionCardCourses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SectionCard(
      showAddButton: true,
      title: AppLocalizations.of(context)!.yourCourses,
      message: AppLocalizations.of(context)!.noCoursesAdded,
      icon: 'assets/svgs/courses_icon.svg',
      widget: BlocBuilder<TeacherMainCubit, TeacherMainState>(
        builder: (context, state) {
          if (state is addCouseState) {
            if (state.courses.isEmpty) {
              return ImageAndTextEmptyData(message:  AppLocalizations.of(context)!.noCoursesAdded);
            } else {
              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.all(0),
                itemCount: state.courses.length,
                itemBuilder: (context, index) => Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: TitelAndIconListTaileWidget(
                    onTap: (){
                      context.pushNamed(Routes.courseMainScreen);
                    },
                    iconUrl: 'assets/svgs/writing_education_learning_icon.svg',
                    title: state.courses[index].title,
                    subTitle: state.courses[index].subTitle=='Paid'?'${ AppLocalizations.of(context)!.paid } ${state.courses[index].price} \$':state.courses[index].subTitle=='Free'? AppLocalizations.of(context)!.free: AppLocalizations.of(context)!.paid,
                    isShowTrailing: true,
                    coursesModel:  context
                            .read<TeacherMainCubit>()
                            .coursesModelList[index],
                    subTitleStyle: state.courses[index].subTitle == 'Free'
                        ? TextStyles.font12Green400Weight
                        : null,
                        indexCourse: index,
                  ),
                ),
              );
            }
          } else {
            return context.read<TeacherMainCubit>().coursesModelList.isEmpty
                ? ImageAndTextEmptyData(message:  AppLocalizations.of(context)!.noCoursesAdded)
                : ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(0),
                    itemCount: context
                        .read<TeacherMainCubit>()
                        .coursesModelList
                        .length,
                    itemBuilder: (context, index) => Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: TitelAndIconListTaileWidget(
                        onTap: (){
                          context.pushNamed(Routes.courseMainScreen);
                        },
                        iconUrl: 'assets/svgs/writing_education_learning_icon.svg',
                        title: context
                            .read<TeacherMainCubit>()
                            .coursesModelList[index]
                            .title,
                        subTitle: context
                            .read<TeacherMainCubit>()
                            .coursesModelList[index]
                            .subTitle=='Free'? AppLocalizations.of(context)!.free: AppLocalizations.of(context)!.paid,
                        isShowTrailing: true,
                        indexCourse: index,
                        coursesModel:  context
                            .read<TeacherMainCubit>()
                            .coursesModelList[index],
                        subTitleStyle: context
                                    .read<TeacherMainCubit>()
                                    .coursesModelList[index]
                                    .subTitle ==
                                'Free'
                            ? TextStyles.font12Green400Weight
                            : null,
                      ),
                    ),
                  );
          }
        },
      ),
    );
  }

  GestureDetector addButtonWidget(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => CourseInfoDialog(),
        );
      },
      child: Container(
        height: 32.h,
        width: 32.w,
        decoration: BoxDecoration(
          color: ColorsManager.secondaryColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
