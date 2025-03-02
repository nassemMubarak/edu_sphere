import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/util/toast_notification_message.dart';
import 'package:edu_sphere/core/widgets/app_text_form_field.dart';
import 'package:edu_sphere/core/widgets/courses_shimmer_widget.dart';
import 'package:edu_sphere/core/widgets/image_and_text_empty_data.dart';
import 'package:edu_sphere/core/widgets/sliver_widget.dart';
import 'package:edu_sphere/features/student/student_main/presentations/bloc/subscribe_student_courses/subscribe_student_courses_cubit.dart';
import 'package:edu_sphere/l10n/app_localizations.dart';
import 'package:edu_sphere/features/student/student_main/presentations/bloc/student_search_course/student_search_course_cubit.dart';
import 'package:edu_sphere/features/teacher/teacher_main/presentation/widgets/section_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import '../../../../../core/widgets/alert_dialog_widget.dart';
import '../../../../teacher/teacher_main/domain/entities/course.dart';

class AddCourseStudentSearch extends StatelessWidget {
  const AddCourseStudentSearch({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<StudentSearchCourseCubit>();
    cubit.emitGetAllCourses();
    return SliverWidget(
      leading: IconButton(onPressed: (){
        context.pop();
    }, icon: Icon(Icons.arrow_back_ios),),
      widget: Padding(
        padding: EdgeInsets.only(top: 10.h, left: 16.w, right: 16.w),
        child: Column(
          children: [
            verticalSpace(20),
            BlocBuilder<StudentSearchCourseCubit, StudentSearchCourseState>(
              builder: (context, state) {
                if (state is GetAllCoursesSearchLoadingState) {
                  return _buildLoadingSection();
                } else if (state is GetAllCoursesSearchLoadedState) {
                  return _buildLoadedSection(context, state.courses);
                } else if(state is GetAllSearchCoursesSearchLoadedState){
                  return _buildLoadedSearchSection(context, state.courses);
                  // return _buildLoadedSection(context, state.courses);
                }else{
                  return _buildFallbackSection(context, cubit.filteredCourses);
                }
              },
            ),
            verticalSpace(50),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingSection() {
    return SectionCard(
      title: 'All Courses',
      icon: 'assets/svgs/courses_icon.svg',
      widget: Column(
        children: [
          verticalSpace(20),
          CoursesShimmerWidget(),
        ],
      ),
    );
  }
  Widget _buildLoadedSearchSection(BuildContext context, List<Course> courses) {
      return SectionCard(
        title: 'All Courses',
        icon: 'assets/svgs/courses_icon.svg',
        widget: Column(
          children: [
            verticalSpace(16.h),
            _buildSearchField(context),
            verticalSpace(32.h),
            courses.isNotEmpty?_buildCoursesList(context, courses):Text('Course Not Founde'),
          ],
        ),
      );
  }

  Widget _buildLoadedSection(BuildContext context, List<Course> courses) {
    if (courses.isNotEmpty) {
      return SectionCard(
        title: 'All Courses',
        icon: 'assets/svgs/courses_icon.svg',
        widget: Column(
          children: [
            verticalSpace(16.h),
            _buildSearchField(context),
            verticalSpace(32.h),
            _buildCoursesList(context, courses),
          ],
        ),
      );
    }else{
      return SectionCard(
        title: AppLocalizations.of(context)!.yourCourses,
        icon: 'assets/svgs/courses_icon.svg',
        widget: ImageAndTextEmptyData(
          message: AppLocalizations.of(context)!.noCoursesAdded,
        ),
      );
    }
  }

  Widget _buildFallbackSection(BuildContext context, List<Course> courses) {
    if (courses.isNotEmpty) {
      return SectionCard(
        title: 'All Courses',
        icon: 'assets/svgs/courses_icon.svg',
        widget: Column(
          children: [
            verticalSpace(16.h),
            _buildSearchField(context),
            verticalSpace(32.h),
            _buildCoursesList(context, courses),
          ],
        ),
      );
    } else {
      return SectionCard(
        title: AppLocalizations.of(context)!.yourCourses,
        icon: 'assets/svgs/courses_icon.svg',
        widget: ImageAndTextEmptyData(
          message: AppLocalizations.of(context)!.noCoursesAdded,
        ),
      );
    }
  }

  Widget _buildSearchField(BuildContext context) {
    final cubit = context.read<StudentSearchCourseCubit>();
    return Form(
      key: cubit.searchCourseKey,
      child: AppTextFormField(
        controller: cubit.searchCourseController,
        prefixIcon: Icon(Icons.search, color: ColorsManager.neutralGray, size: 24),
        hintText: 'Find a course',
        validator: (v) {},
        onChanged: (value) => cubit.emitGetAllSearchCourses(), // Trigger search on text change
      ),
    );
  }

  Widget _buildCoursesList(BuildContext context, List<Course> courses) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: courses.length,
      itemBuilder: (context, index) {
        final course = courses[index];
        return ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(course.title, style: TextStyles.font14Black400Weight),
          subtitle: Text('Teacher Name', style: TextStyles.font12NeutralGray400Weight),
          trailing: GestureDetector(
            onTap: () => _showAddCourseDialog(context,course),
            child: Container(
              height: 32.h,
              width: 32.w,
              decoration: BoxDecoration(
                color: ColorsManager.secondaryColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Icon(Icons.add, color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  void _showAddCourseDialog(BuildContext context,Course course) {

    showDialog(
      context: context,
      builder: (context) => AlertDialogWidget(
        title: 'Add Courses',
        textButton: 'Add Courses',
        widget: Column(
          children: [
          BlocConsumer<StudentSearchCourseCubit,StudentSearchCourseState>(listener: (context, state) {
          if(state is AddStudentToCourseLoadingState){
            context.loading();
          }else if(state is GetAllCoursesSearchMessageErrorState){
            context.pop();
            ToastNotificationMessage().showToastNotificationError(message: state.message, context: context);
          }else if(state is GetAllCoursesSearchLoadedState){
            context.pop();
            context.pop();
            ToastNotificationMessage().showNotificationSuccess(message: 'Success Add Course', context: context);
         context.read<SubscribeStudentCoursesCubit>().emitGetAllSubscribeStudentCourses();
          }
        },builder: (context, state) {
          return SizedBox.shrink();
        },),
            Text(
              'Do you really want to add Data Science?',
              textAlign: TextAlign.center,
              style: TextStyles.font14Black400Weight,
            ),
          ],
        ),

        onTapButton: () {
          context.read<StudentSearchCourseCubit>().emitSubscribeStudentCourse(course);
        },
      ),
    );
  }
}
