import 'dart:io';

import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/routing/routes.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/util/file_utils.dart';
import 'package:edu_sphere/core/widgets/bread_crumb_widget.dart';
import 'package:edu_sphere/core/widgets/image_and_text_empty_data.dart';
import 'package:edu_sphere/core/widgets/toggle_text_widget.dart';
import 'package:edu_sphere/features/teacher/assessments/domain/entities/assessment.dart';
import 'package:edu_sphere/features/teacher/assessments/domain/entities/document_assessment.dart';
import 'package:edu_sphere/features/teacher/assessments/presentation/bloc/assessments_cubit.dart';
import 'package:edu_sphere/features/teacher/assessments/presentation/widgets/assessment_widget/delete_assessments_info_dialog.dart';
import 'package:edu_sphere/features/teacher/assessments/presentation/widgets/assessment_widget/delete_file_assessment_info_dialog.dart';
import 'package:edu_sphere/features/teacher/assessments/presentation/widgets/assessment_widget/edit_assessment_dialog.dart';
import 'package:edu_sphere/features/teacher/assessments/presentation/widgets/assessment_widget/loading_add_or_update_or_assessment_quiz_widget.dart';
import 'package:edu_sphere/features/teacher/assessments/presentation/widgets/assessment_widget/show_or_hid_assessment_info_dialog.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/bloc/course_main_cubit.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:slide_countdown/slide_countdown.dart';

import '../../../../../../core/widgets/sliver_widget.dart';
class BuildSliverAssessmentWidget extends StatelessWidget {
  Assessment assessment;
   BuildSliverAssessmentWidget({super.key,required this.assessment});

  @override
  Widget build(BuildContext context) {
    int idCourse = context.read<CourseMainCubit>().coursesModel.id;

    var coursesModel = context
        .read<CourseMainCubit>()
        .coursesModel;
    return SliverWidget(
      leading: IconButton(
        onPressed: () {
          context.pop();
        },
        icon: Icon(Icons.arrow_back),
      ),
      actions: assessment.startIn.isBefore(DateTime.now())?[
        GestureDetector(
            onTap: (){
              context.pushNamed(Routes.estimateAssessmentPage);
            },
            child: SvgPicture.asset('assets/svgs/assessment_estimates_color_icon.svg',color: Colors.white,)),
        horizontalSpace(30)
      ]:[],
      widget: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            BreadCrumbWidget(
              items: ['Home', coursesModel.title, assessment.title],
            ),
            verticalSpace(24),
            // card show time Assessment
            Container(
              width: 1.sw,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 2,
                    blurRadius: 4,
                    color: ColorsManager.shadowColor.withOpacity(0.3),
                  ),
                ],
              ),
              child: !assessment.endIn.isBefore(DateTime.now()) &&
                  assessment.startIn
                      .difference(DateTime.now())
                      .inDays <
                      5
                  ? Row(
                children: [
                  Expanded(
                      child: Text(
                        'Remaining to start Assessment',
                        style: TextStyles.font10Red400Weight,
                      )),
                  horizontalSpace(13),
                  Expanded(
                    child: SlideCountdownSeparated(
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(5)),
                      style: TextStyles.font12White600Weight,
                      duration: Duration(
                          seconds: assessment.startIn
                              .difference(DateTime.now())
                              .inSeconds),
                      showZeroValue: true,
                    ),
                  ),
                ],
              )
                  : assessment.endIn.isBefore(DateTime.now())
                  ? Text(
                'Assessment submission deadline is over',
                textAlign: TextAlign.center,
                style: TextStyles.font12Red400Weight,
              )
                  : Text(
                'Assessment has started and you cannot add questions',
                style: TextStyles.font12Red400Weight,
              ),
            ),
            verticalSpace(24),
            // card show detail Assessment
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 2,
                    blurRadius: 4,
                    color: ColorsManager.shadowColor.withOpacity(0.3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  ListTile(
                    titleAlignment: ListTileTitleAlignment.center,
                    contentPadding: EdgeInsetsDirectional.zero,
                    leading: SvgPicture.asset(
                      'assets/svgs/annual_assessment_icon.svg',
                      width: 24.w,
                      height: 24.h,
                      color: ColorsManager.mainBlue,
                    ),
                    title: Text(
                      assessment.title,
                      style: TextStyles.font14Black500Weight,
                    ),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: (){
                              showDialog(
                                context: context,
                                builder: (context) => ShowOrHidAssessmentInfoDialog(assessment: assessment,idCourse: idCourse,),
                              );
                            },
                            child: Icon(assessment.visibility?Icons.visibility_outlined: Icons.visibility_off_outlined,
                                color: Colors.black),
                          ),
                          horizontalSpace(8),
                          GestureDetector(
                            onTap: (){
                              showDialog(
                                context: context,
                                builder: (context) => EditAssessmentDialog(assessment: assessment,idCourse: idCourse),
                              );
                            },
                            child: SvgPicture.asset(
                              'assets/svgs/edite_icon.svg',
                              height: 24,
                              width: 24,
                              color: Colors.black,
                            ),
                          ),
                          horizontalSpace(8),
                          GestureDetector(
                            onTap: (){
                              showDialog(
                                context: context,
                                builder: (context) => DeleteAssessmentsInfoDialog(assessment: assessment,idCourse: idCourse),
                              );
                            },
                            child: SvgPicture.asset(
                              'assets/svgs/delete_icon.svg',
                              height: 24,
                              width: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  verticalSpace(24),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset('assets/svgs/message_icon.svg'),
                      horizontalSpace(8),
                      SizedBox(
                          width: 0.6.sw,
                          child:
                          ToggleText(text: assessment.description)),
                    ],
                  ),
                  buildListTileText(
                      subTitle:
                      '${assessment.startIn.day}/${assessment.startIn.month}/${assessment.startIn.year}',
                      svgUrl: 'assets/svgs/quiz_date.svg',
                      title: 'Assessment start date'),
                  buildListTileText(
                      subTitle:
                      '${assessment.endIn.day}/${assessment.endIn.month}/${assessment.endIn.year}',
                      svgUrl: 'assets/svgs/quiz_date.svg',
                      title: 'Assessment end date'),
                  buildListTileText(
                      subTitle: DateFormat.jm()
                          .format(assessment.startIn),
                      svgUrl: 'assets/svgs/quiz_time.svg',
                      title: 'Assessment start time'),
                  buildListTileText(
                      subTitle:
                      DateFormat.jm().format(assessment.endIn),
                      svgUrl: 'assets/svgs/quiz_time.svg',
                      title: 'Assessment end time'),
                  buildListTileText(
                      subTitle: assessment.degree.toString(),
                      svgUrl: 'assets/svgs/quiz_score_icon.svg',
                      title: 'Assessment Score'),
                ],
              ),
            ),
            verticalSpace(24),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 2,
                    blurRadius: 4,
                    color: ColorsManager.shadowColor.withOpacity(0.3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  ListTile(
                    titleAlignment: ListTileTitleAlignment.center,
                    contentPadding: EdgeInsetsDirectional.zero,
                    leading: SvgPicture.asset(
                      'assets/svgs/annual_assessment_icon.svg',
                      width: 24.w,
                      height: 24.h,
                      color: ColorsManager.mainBlue,
                    ),
                    title: Text(
                      assessment.title,
                      style: TextStyles.font14Black500Weight,
                    ),
                    trailing: GestureDetector(
                      onTap: () {
                        _showBottomSheet(context,idAssessment: assessment.id,idCourse: idCourse);
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
                    ),
                  ),
                  verticalSpace(10),
                  ///TOODO
                  BlocBuilder<AssessmentsCubit,AssessmentsState>(builder: (context, state) {
                    if(state is SelectedAssessment){
                      final listDocument = state.assessment.documents;
                      // Check if listFilesUrl is not null and not empty
                      if (listDocument != null && listDocument.isNotEmpty) {
                        return buildListView(listDocumentAssessment: listDocument,idCourse:idCourse ,idAssessment: state.assessment.id);
                      } else {
                        return ImageAndTextEmptyData(
                          imageUrl: 'assets/images/no_download_image.png',
                          message: 'You have not uploaded any file yet.',
                        );
                      }
                    }else{
                     return context.read<AssessmentsCubit>().assessment!.documents!=null&&context.read<AssessmentsCubit>().assessment!.documents!.isNotEmpty?buildListView(listDocumentAssessment: context.read<AssessmentsCubit>().assessment!.documents!,idAssessment:context.read<AssessmentsCubit>().assessment!.id ,idCourse: idCourse):ImageAndTextEmptyData(imageUrl:'assets/images/no_download_image.png',message:'You have not uploaded any file yet.');
                    }
                  },),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  ListView buildListView({required List<DocumentAssessment> listDocumentAssessment,required int idCourse,required int idAssessment}) {
    return ListView.builder(
      itemCount: listDocumentAssessment.length,
      padding: EdgeInsetsDirectional.only(
          top: 0.h, bottom: 40.h, end: 16.w, start: 16.w),
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) =>
          buildListTile(documentAssessment: listDocumentAssessment[index], context: context,index: index,idAssessment: idAssessment,idCourse: idCourse),
    );
  }
  ListTile buildListTile(
      {required DocumentAssessment documentAssessment, required BuildContext context,required int index,required int idCourse,required int idAssessment}) {
    return ListTile(
      onTap: (){
        // context.read<AssessmentsCubit>().emitDownloadADocumentToAssessment(idCourse: idCourse, idAssessment: idAssessment, idDocument: documentAssessment.id, indexDocument: index);

      },
      contentPadding: EdgeInsetsDirectional.zero,
      leading: GestureDetector(
          onTap: () {
          }, child: SvgPicture.asset('assets/svgs/pdf_icon.svg')),
      title: Text(
        documentAssessment.title??'Document $index',
        style: TextStyles.font14Black400Weight,
      ),
      trailing: GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) => DeleteFileAssessmentInfoDialog(idAssessment: idAssessment,idCourse: idCourse,documentAssessment:documentAssessment,indexDocument: index),);
        },
        child: SvgPicture.asset(
          'assets/svgs/delete_icon.svg',
        ),
      ),
    );
  }

  _showBottomSheet(BuildContext context,{required int idCourse,required int idAssessment }) {
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
              Text('Select Assignment File', style: TextStyles.font16Black600Weight),
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
              LoadingAddOrUpdateOrAssessmentQuizWidget(message: 'The file assessment has been added successfully.'),
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
                        .read<AssessmentsCubit>()
                        .emitAddDocumentToAssessment(idCourse: idCourse, idAssessment: idAssessment, files: filesList);
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

  ListTile buildListTileText(
      {required String subTitle,
        required String svgUrl,
        required String title}) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: SvgPicture.asset(svgUrl),
      title: Text(title, style: TextStyles.font14Black400Weight),
      trailing: Text(
        subTitle,
        style: TextStyles.font12Black400Weight,
      ),
    );
  }
}
