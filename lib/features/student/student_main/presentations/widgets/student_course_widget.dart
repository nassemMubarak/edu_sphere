import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/routing/routes.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/widgets/courses_shimmer_widget.dart';
import 'package:edu_sphere/core/widgets/image_and_text_empty_data.dart';
import 'package:edu_sphere/features/student/student_main/presentations/bloc/subscribe_student_courses/subscribe_student_courses_cubit.dart';
import 'package:edu_sphere/features/student/student_main/presentations/widgets/leave_student_course_dialog.dart';
import 'package:edu_sphere/features/teacher/teacher_main/presentation/widgets/show_message_pinding_or_rejected_course_info_dialog.dart';
import 'package:edu_sphere/features/teacher/teacher_main/presentation/widgets/titel_and_icon_list_taile_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:edu_sphere/l10n/app_localizations.dart';
import 'package:edu_sphere/features/teacher/teacher_main/presentation/widgets/section_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class StudentCourseWidget extends StatelessWidget {
  const StudentCourseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubscribeStudentCoursesCubit,SubscribeStudentCoursesState>(
      builder: (context, state) {
        if(state is GetAllStudentSubscribeCoursesLoadingState){
          return SectionCard(
              title: AppLocalizations.of(context)!.yourCourses,
              icon: 'assets/svgs/courses_icon.svg',
              widget: CoursesShimmerWidget());
        }else if(state is GetAllStudentSubscribeCoursesLoadedState){
         return state.courses.isNotEmpty?SectionCard(
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
                        context.pushNamed(Routes.courseStudentMainScreen);
                        context.read<SubscribeStudentCoursesCubit>().courseSelected = state.courses[index];
                      }
                    },
                    iconUrl: 'assets/svgs/writing_education_learning_icon.svg',
                    title: state.courses[index].title,
                    isShowTrailing: true,
                    onDeleteIconTap: (){
                      showDialog(context: context, builder: (context) => LeaveStudentCourseDialog(course: state.courses[index]));
                    },
                    subTitle: state.courses[index].isPending
                        ? 'Pending'
                        : state.courses[index].isRejected == true
                        ? 'Rejected'
                        : state.courses[index].description,
                    coursesModel: state.courses[index],
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
         ):SectionCard(
            title: AppLocalizations.of(context)!.yourCourses,
            icon: 'assets/svgs/courses_icon.svg',
            widget: ImageAndTextEmptyData(
                message: AppLocalizations.of(context)!.noCoursesAdded),
          );
        }else{
          return context.read<SubscribeStudentCoursesCubit>().listStudentCourse.isNotEmpty?
         ListView.builder(
           physics: const NeverScrollableScrollPhysics(),
           shrinkWrap: true,
           padding: const EdgeInsets.all(0),
           itemCount: context.read<SubscribeStudentCoursesCubit>().listStudentCourse.length,
           itemBuilder: (context, index) => Container(
             margin: const EdgeInsets.only(bottom: 16),
             child: TitelAndIconListTaileWidget(
               onTap: () {
                 if (context.read<SubscribeStudentCoursesCubit>().listStudentCourse[index].isRejected ||
                     context.read<SubscribeStudentCoursesCubit>().listStudentCourse[index].isPending) {
                   showDialog(
                     context: context,
                     builder: (context) =>
                         ShowMessagePindingOrRejectedCourseInfoDialog(
                             isPending: context.read<SubscribeStudentCoursesCubit>().listStudentCourse[index].isPending),
                   );
                 } else {
                   context.pushNamed(Routes.courseStudentMainScreen);
                   context.read<SubscribeStudentCoursesCubit>().courseSelected = context.read<SubscribeStudentCoursesCubit>().listStudentCourse[index];
                 }
               },
               iconUrl: 'assets/svgs/writing_education_learning_icon.svg',
               title: context.read<SubscribeStudentCoursesCubit>().listStudentCourse[index].title,
               isShowTrailing: true,
               onDeleteIconTap: (){
                 showDialog(context: context, builder: (context) => LeaveStudentCourseDialog(course: context.read<SubscribeStudentCoursesCubit>().listStudentCourse[index]));
               },
               subTitle: context.read<SubscribeStudentCoursesCubit>().listStudentCourse[index].isPending
                   ? 'Pending'
                   : context.read<SubscribeStudentCoursesCubit>().listStudentCourse[index].isRejected == true
                   ? 'Rejected'
                   : context.read<SubscribeStudentCoursesCubit>().listStudentCourse[index].description,
               coursesModel: context.read<SubscribeStudentCoursesCubit>().listStudentCourse[index],
               subTitleStyle: context.read<SubscribeStudentCoursesCubit>().listStudentCourse[index].isPending
                   ? TextStyles.font12Yellow400Weight
                   : context.read<SubscribeStudentCoursesCubit>().listStudentCourse[index].isRejected
                   ? TextStyles.font12Red400Weight
                   : null,
               isShowEditButton: context.read<SubscribeStudentCoursesCubit>().listStudentCourse[index].isRejected ||
                   context.read<SubscribeStudentCoursesCubit>().listStudentCourse[index].isPending,
               indexCourse: index,
             ),
           ),
         )
             :SectionCard(
         title: AppLocalizations.of(context)!.yourCourses,
         icon: 'assets/svgs/courses_icon.svg',
         widget: ImageAndTextEmptyData(
             message: AppLocalizations.of(context)!.noCoursesAdded),
         );
        }
      },
    );
    //   SectionCard(
    //   title: AppLocalizations.of(context)!.yourCourses,
    //   icon: 'assets/svgs/courses_icon.svg',
    //   widget: ImageAndTextEmptyData(
    //     message: AppLocalizations.of(context)!.noCoursesAdded),
    // );
  }
}
