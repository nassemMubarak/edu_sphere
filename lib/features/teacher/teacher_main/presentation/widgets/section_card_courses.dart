import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/routing/routes.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/util/snackbar_message.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/bloc/course_main_cubit.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/pages/course_main_screen.dart';
import 'package:edu_sphere/features/teacher/teacher_main/presentation/logic/teacher_main_cubit.dart';
import 'package:edu_sphere/features/teacher/teacher_main/presentation/logic/teacher_main_state.dart';
import 'package:edu_sphere/features/teacher/teacher_main/presentation/widgets/course_info_dialog.dart';
import 'package:edu_sphere/features/teacher/teacher_main/presentation/widgets/courses_shimmer_widget.dart';
import 'package:edu_sphere/features/teacher/teacher_main/presentation/widgets/section_card.dart';
import 'package:edu_sphere/core/widgets/image_and_text_empty_data.dart';
import 'package:edu_sphere/features/teacher/teacher_main/presentation/widgets/show_message_pinding_or_rejected_course_info_dialog.dart';
import 'package:edu_sphere/features/teacher/teacher_main/presentation/widgets/titel_and_icon_list_taile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SectionCardCourses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TeacherMainCubit, TeacherMainState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if(state is TeacherMainLoadingState){
          return SectionCard(
              // showAddButton: true,
                  title: AppLocalizations.of(context)!.yourCourses,
                  icon: 'assets/svgs/courses_icon.svg',
              widget: CoursesShimmerWidget());
        }
        if(state is TeacherMainMessageErrorState){
          SnackBarMessage().showSnackBarError(message: state.message, context: context);
        }
        if (state is AddCourseState) {
          if (state.courses.isEmpty) {
            return ImageAndTextEmptyData(
                message: AppLocalizations.of(context)!.noCoursesAdded);
          } else {
            return SectionCard(
              showAddButton: true,
                  title: AppLocalizations.of(context)!.yourCourses,
                  icon: 'assets/svgs/courses_icon.svg',
              widget: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.all(0),
                itemCount: state.courses.length,
                itemBuilder: (context, index) => Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: TitelAndIconListTaileWidget(
                    onTap: () {
                      if (state.courses[index].isRejected ||
                          state.courses[index].isPending) {
                        showDialog(
                          context: context,
                          builder: (context) =>
                              ShowMessagePindingOrRejectedCourseInfoDialog(
                                  isPending: state.courses[index].isPending),
                        );
                      } else {
                        context.pushNamed(Routes.courseMainScreen);
                        context.read<CourseMainCubit>().coursesModel = state.courses[index];
                        context.read<CourseMainCubit>().indexCourseInList = index;

                      }
                    },
                    iconUrl: 'assets/svgs/writing_education_learning_icon.svg',
                    title: state.courses[index].title,
                    isShowTrailing: true,
                    subTitle: state.courses[index].isPending
                        ? 'Pending'
                        : state.courses[index].isRejected == true
                        ? 'Rejected'
                        : state.courses[index].description,
                    coursesModel: context
                        .read<TeacherMainCubit>()
                        .coursesModelList[index],
                    subTitleStyle: state.courses[index].isPending
                        ? TextStyles.font12Yellow400Weight
                        : state.courses[index].isRejected
                        ? TextStyles.font12Red400Weight
                        : null,
                    isShowEditButton: state.courses[index].isRejected ||
                        state.courses[index].isPending,
                    indexCourse: index,
                  ),
                ),
              ),
            );
          }
        } else {
          return context.read<TeacherMainCubit>().coursesModelList.isEmpty
              ? SectionCard(
            showAddButton: true,
            title: AppLocalizations.of(context)!.yourCourses,
            icon: 'assets/svgs/courses_icon.svg',
                widget: ImageAndTextEmptyData(
                message: AppLocalizations.of(context)!.noCoursesAdded),
              )
              : SectionCard(
            showAddButton: true,
                title: AppLocalizations.of(context)!.yourCourses,
                icon: 'assets/svgs/courses_icon.svg',
                widget: ListView.builder(
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
                    onTap: () {
                      if (context
                          .read<TeacherMainCubit>()
                          .coursesModelList[index]
                          .isRejected ||
                          context
                              .read<TeacherMainCubit>()
                              .coursesModelList[index]
                              .isPending) {
                        showDialog(
                          context: context,
                          builder: (context) =>
                              ShowMessagePindingOrRejectedCourseInfoDialog(
                                  isPending: context
                                      .read<TeacherMainCubit>()
                                      .coursesModelList[index]
                                      .isPending),
                        );
                      } else {

                        context.pushNamed(Routes.courseMainScreen,argument: [
                          context
                              .read<TeacherMainCubit>()
                              .coursesModelList[index],
                          index
                        ]
                        );
                        context.read<CourseMainCubit>().coursesModel = context
                            .read<TeacherMainCubit>()
                            .coursesModelList[index];
                        context.read<CourseMainCubit>().indexCourseInList = index;
                      }
                    },
                    iconUrl:
                    'assets/svgs/writing_education_learning_icon.svg',
                    title: context
                        .read<TeacherMainCubit>()
                        .coursesModelList[index]
                        .title,
                    subTitle: context
                        .read<TeacherMainCubit>()
                        .coursesModelList[index]
                        .isPending
                        ? 'Pending'
                        : context
                        .read<TeacherMainCubit>()
                        .coursesModelList[index]
                        .isRejected ==
                        true
                        ? 'Rejected'
                        : context
                        .read<TeacherMainCubit>()
                        .coursesModelList[index]
                        .description,
                    isShowTrailing: true,
                    indexCourse: index,
                    coursesModel: context
                        .read<TeacherMainCubit>()
                        .coursesModelList[index],
                    subTitleStyle: context
                        .read<TeacherMainCubit>()
                        .coursesModelList[index]
                        .isPending
                        ? TextStyles.font12Yellow400Weight
                        : context
                        .read<TeacherMainCubit>()
                        .coursesModelList[index]
                        .isRejected
                        ? TextStyles.font12Red400Weight
                        : null,
                    isShowEditButton: context
                        .read<TeacherMainCubit>()
                        .coursesModelList[index]
                        .isPending ||
                        context
                            .read<TeacherMainCubit>()
                            .coursesModelList[index]
                            .isRejected),
                            ),
                          ),
              );
        }
      },
      // builder: (context, state) {
      //   return SectionCard(
      //     showAddButton: true,
      //     title: AppLocalizations.of(context)!.yourCourses,
      //     icon: 'assets/svgs/courses_icon.svg',
      //     widget: BlocConsumer<TeacherMainCubit, TeacherMainState>(
      //       listener: (context, state) {
      //         if (state is TeacherMainMessageErrorState) {
      //           SnackBarMessage()
      //               .showSnackBarError(
      //               message: state.message, context: context);
      //         }
      //       },
      //
      //     ),
      //   );
      // },
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
