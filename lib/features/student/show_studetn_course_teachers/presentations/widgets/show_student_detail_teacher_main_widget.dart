import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/widgets/image_and_text_empty_data.dart';
import 'package:edu_sphere/features/communication/domain/entities/communication.dart';
import 'package:edu_sphere/features/communication/presentation/pages/communication_main_page.dart';
import 'package:edu_sphere/features/student/show_studetn_course_teachers/presentations/bloc/show_student_teacher_cubit.dart';
import 'package:edu_sphere/features/student/show_studetn_course_teachers/presentations/widgets/courses_taught_widget.dart';
import 'package:edu_sphere/features/student/show_studetn_course_teachers/presentations/widgets/show_communication_teacher_widget.dart';
import 'package:edu_sphere/features/student/show_studetn_course_teachers/presentations/widgets/teacher_information_widget.dart';
import 'package:edu_sphere/features/teacher/teacher_main/presentation/widgets/section_card.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';

class ShowStudentDetailTeacherMainWidget extends StatelessWidget {
  const ShowStudentDetailTeacherMainWidget({super.key});

  Widget build(BuildContext context) {
    context.read<ShowStudentTeacherCubit>().emitShowTeacherInformationUse(
        idTeacher: context.read<ShowStudentTeacherCubit>().idTeacher!);
    return BlocBuilder<ShowStudentTeacherCubit, ShowStudentTeacherState>(
      buildWhen: (previous, current) =>
          current is ShowStudentTeacherLoadedState,
      builder: (context, state) {
        if (state is ShowStudentTeacherLoadingState) {
          return Column(
            children: [
              verticalSpace(24),
              _buildShimmerTeacherInfo(),
              verticalSpace(24),
              _buildShimmerCourses(),
              verticalSpace(24),
              _buildShimmerCommunication(),
            ],
          );
        } else if (state is ShowStudentTeacherLoadedState) {
          return Column(
            children: [
              TeacherInformationWidget(showStudentTeacher: state.showStudentTeacher),
              verticalSpace(24),
              CoursesTaughtWidget(corses: state.showStudentTeacher.courses),
              verticalSpace(24),
              ShowCommunicationTeacherWidget(communications: state.showStudentTeacher.communications),
            ],
          );
        } else {
          return SectionCard(
            title: 'teacher information',
            icon: 'assets/svgs/type_of_teaching.svg',
            isNotShowColorSvg: true,
            widget: ImageAndTextEmptyData(message: 'There is no teacher yet'),
          );
        }
      },
    );
  }
  Widget _buildShimmerTeacherInfo() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(height: 24, width: 200, color: Colors.grey),
          const SizedBox(height: 16),
          Row(
            children: [
              Container(height: 48, width: 48, color: Colors.grey),
              const SizedBox(width: 16),
              Container(height: 16, width: 150, color: Colors.grey),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildShimmerCourses() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          3, // Number of shimmer items
              (index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Container(height: 48, width: 48, color: Colors.grey),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(height: 16, width: 200, color: Colors.grey),
                    const SizedBox(height: 8),
                    Container(height: 16, width: 150, color: Colors.grey),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildShimmerCommunication() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Column(
        children: List.generate(
          4, // Number of shimmer communication options
              (index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Container(height: 24, width: 24, color: Colors.grey),
                const SizedBox(width: 16),
                Container(height: 16, width: 200, color: Colors.grey),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildShimmerList() {
    return ListView.builder(
      itemCount: 5, // Adjust the number of shimmer placeholders
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Container(
                    height: 16,
                    color: Colors.grey.shade300,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

}