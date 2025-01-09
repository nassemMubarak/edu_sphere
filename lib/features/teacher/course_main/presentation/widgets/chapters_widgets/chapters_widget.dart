import 'dart:io';

import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/util/file_utils.dart';
import 'package:edu_sphere/features/teacher/assessments/domain/entities/document_assessment.dart';
import 'package:edu_sphere/features/teacher/course_main/domain/entities/chapter.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/bloc/course_main_cubit.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/widgets/chapters_widgets/delete_chapter_info_dialog.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/widgets/chapters_widgets/loading_add_or_delete_chapter_widget.dart';
import 'package:edu_sphere/core/widgets/shimmer_loading_chapter_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/widgets/image_and_text_empty_data.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/widgets/section_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../bloc/document_course/document_course_cubit.dart';

class ChaptersWidget extends StatelessWidget {
  int idCourse;

  ChaptersWidget({super.key, required this.idCourse});

  @override
  Widget build(BuildContext context) {
    context.read<DocumentCourseCubit>().emitGetAllDocumentToCourse(
        idCourse: idCourse);
    return BlocBuilder<DocumentCourseCubit, DocumentCourseState>(
        builder: (context, state) {
          if(state is GetAllLectureLoadingState){
            return const ShimmerLoadingChapterWidget();
          }
          if (state is GetAllDocumentLoadedState) {
            if (state.listDocument.isNotEmpty) {
              return SectionCard(
                  title: 'Chapters',
                      icon: 'assets/svgs/chapter_icon.svg',
                      infoDialog: Container(),
                      onTap: () {
                        _showBottomSheet(context);
                      },
                  widget: buildListView(listChapter: state.listDocument));
            } else {
              return SectionCard(
                title: 'Chapters',
                icon: 'assets/svgs/chapter_icon.svg',
                infoDialog: Container(),
                onTap: () {
                  _showBottomSheet(context);
                },
                widget: ImageAndTextEmptyData(
                  message: 'You have not added any chapters yet.',
                ),
              );
            }
          } else {
            return  context.read<DocumentCourseCubit>().listDocumentToCourse.isNotEmpty?
             SectionCard(
                title: 'Chapters',
                icon: 'assets/svgs/chapter_icon.svg',
                infoDialog: Container(),
                onTap: () {
                  _showBottomSheet(context);
                },
                widget: buildListView(listChapter: context.read<DocumentCourseCubit>().listDocumentToCourse))
                :
             SectionCard(
               title: 'Chapters',
               icon: 'assets/svgs/chapter_icon.svg',
               infoDialog: Container(),
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
      trailing: GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) => DeleteChapterInfoDialog(chapter: chapter,idCourse: idCourse,));
        },
        child: SvgPicture.asset(
          'assets/svgs/delete_icon.svg',
        ),
      ),
    );
  }

  _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              LoadingAddOrDeleteChapterWidget(message: 'The file Document has been added successfully.'),
              Text('Add Chapters', style: TextStyles.font16Black600Weight),
              verticalSpace(10),
              Text(
                'Select the file you want to attach',
                style: TextStyles.font14Black500Weight,
              ),
              verticalSpace(10),
              Text(
                '(Only PDF files are allowed)',
                style: TextStyles.font14Black500WeightItalic,
              ),
              verticalSpace(24),
              GestureDetector(
                onTap: () async {
                    List<PlatformFile>? files =
                    await FileUtils.pickPdfFiles(context);
                    if (files != null && files.isNotEmpty) {

                      List<File> filesList  = files.map((platformFile) {
                        // Convert PlatformFile to File
                        return File(platformFile.path!);
                      }).toList();
                      context
                          .read<DocumentCourseCubit>()
                          .emitAddDocumentToAssessment(idCourse: idCourse, files: filesList);
                      // context
                      //     .read<AssessmentsCubit>()
                      //     .emitAddAssessmentFile(listAssessmentFile: listAssessmentFile);
                      // context.pop();
                    }
                },
                child: Container(
                  padding: EdgeInsetsDirectional.all(0),
                  alignment: Alignment.center,
                  height: 48.h,
                  width: 48.w,
                  decoration: BoxDecoration(
                    color: Color(0xFF0038FF),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.folder, color: Colors.white, size: 35),
                ),
              ),
              verticalSpace(24)
            ],
          ),
        );
      },
    );
  }

}
