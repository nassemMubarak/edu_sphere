import 'package:edu_sphere/features/student/student_main/presentations/bloc/student_document_course/student_document_course_cubit.dart';
import 'package:edu_sphere/features/teacher/assessments/domain/entities/document_assessment.dart';
import 'package:edu_sphere/core/widgets/shimmer_loading_chapter_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/widgets/image_and_text_empty_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../teacher/teacher_main/presentation/widgets/section_card.dart';
class StudentDocumentToCourseWidget extends StatelessWidget {
  int idCourse;

  StudentDocumentToCourseWidget({super.key, required this.idCourse});

  @override
  Widget build(BuildContext context) {
    context.read<StudentDocumentCourseCubit>().emitGetAllDocumentToCourse(
        idCourse: idCourse);
    return BlocBuilder<StudentDocumentCourseCubit, StudentDocumentCourseState>(
        builder: (context, state) {
          if(state is GetAllStudentDocumentToCourseLoadingState){
            return const ShimmerLoadingChapterWidget();
          }
          if (state is GetAllStudentDocumentToCourseLoadedState) {
            if (state.documents.isNotEmpty) {
              return SectionCard(
                  title: 'Chapters',
                  icon: 'assets/svgs/chapter_icon.svg',
                  widget: buildListView(listChapter: state.documents));
            } else {
              return SectionCard(
                title: 'Chapters',
                icon: 'assets/svgs/chapter_icon.svg',
                widget: ImageAndTextEmptyData(
                  message: 'You have not added any chapters yet.',
                ),
              );
            }
          } else {
            return  context.read<StudentDocumentCourseCubit>().documentList.isNotEmpty?
            SectionCard(
                title: 'Chapters',
                icon: 'assets/svgs/chapter_icon.svg',

                widget: buildListView(listChapter: context.read<StudentDocumentCourseCubit>().documentList))
                :
            SectionCard(
              title: 'Chapters',
              icon: 'assets/svgs/chapter_icon.svg',
              widget: ImageAndTextEmptyData(
                message: 'You have not added any chapters yet.',
              ),
            );
          }
        }
      // builder: (context, state) {
      //   return SectionCard(
      //     title: 'Chapters',
      //     icon: 'assets/svgs/chapter_icon.svg',
      //     infoDialog: Container(),
      //     onTap: () {
      //       _showBottomSheet(context);
      //     },
      //
      //   );
      // },
    );
  }

  ListView buildListView({required List<DocumentAssessment> listChapter}) {
    return ListView.builder(
      itemCount: listChapter.length,
      padding: EdgeInsetsDirectional.only(
          top: 24.h, bottom: 40.h, end: 16.w, start: 16.w),
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) =>
          buildListTile(
              chapter: listChapter[index], context: context, index: index,idCourse: idCourse),
    );
  }

  ListTile buildListTile(
      {required DocumentAssessment chapter, required BuildContext context, required int index,required int idCourse}) {
    return ListTile(
      contentPadding: EdgeInsetsDirectional.zero,
      leading: GestureDetector(
          onTap: () {}, child: SvgPicture.asset('assets/svgs/pdf_icon.svg')),
      title: Text(
        chapter.title ?? 'Document $index',
        style: TextStyles.font14Black400Weight,
      ),
    );
  }
}
