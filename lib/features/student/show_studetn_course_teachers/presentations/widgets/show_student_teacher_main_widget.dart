import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/routing/routes.dart';
import 'package:edu_sphere/core/widgets/image_and_text_empty_data.dart';
import 'package:edu_sphere/features/student/show_studetn_course_teachers/presentations/bloc/show_student_teacher_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:edu_sphere/l10n/app_localizations.dart';
import 'package:edu_sphere/features/teacher/teacher_main/presentation/widgets/section_card.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart';
import 'package:shimmer/shimmer.dart';
class ShowStudentTeacherMainWidget extends StatelessWidget {
  const ShowStudentTeacherMainWidget({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ShowStudentTeacherCubit>().emitGetAllStudentTeacher();
    return BlocBuilder<ShowStudentTeacherCubit, ShowStudentTeacherState>(
      buildWhen: (previous, current) => current is GetAllStudentTeacherLoadedState,
      builder: (context, state) {
        if(state is GetAllStudentTeacherLoadingState){
        return  SectionCard(
            title: 'Course teachers',
            icon: 'assets/svgs/type_of_teaching.svg',
            isNotShowColorSvg: true,
            widget: _buildShimmerList(),
          );
        }else if(state is GetAllStudentTeacherLoadedState){
          return state.listTeacherToStudent.isNotEmpty?SectionCard(
            title: 'Course teachers',
            icon: 'assets/svgs/type_of_teaching.svg',
            isNotShowColorSvg: true,
            widget: ListView.builder(
              itemCount: state.listTeacherToStudent.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => ListTile(
                onTap: (){
                  context.read<ShowStudentTeacherCubit>().idTeacher = state.listTeacherToStudent[index].id;
                  context.pushNamed(Routes.showStudentDetailTeacherMainPage);
                },
                contentPadding: EdgeInsets.zero,
                title: Text(state.listTeacherToStudent[index].name),
                leading: state.listTeacherToStudent[index].imageUrl!=null?Image.network(state.listTeacherToStudent[index].imageUrl!):SvgPicture.asset('assets/svgs/type_of_teaching.svg'),
              ),
            ),
          ):SectionCard(
            title: 'Course teachers',
            icon: 'assets/svgs/type_of_teaching.svg',
            isNotShowColorSvg: true,
            widget: ImageAndTextEmptyData(
                message: 'There is no teacher yet'),
          );
        }else{
          return SectionCard(
            title: 'Course teachers',
            icon: 'assets/svgs/type_of_teaching.svg',
            isNotShowColorSvg: true,
            widget: ImageAndTextEmptyData(
                message: 'There is no teacher yet'),
          );
        }

      },
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
