import 'dart:io';

import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/util/file_utils.dart';
import 'package:edu_sphere/core/widgets/app_text_button.dart';
import 'package:edu_sphere/features/student/assessment_student/presesntations/bloc/student_assessment_cubit.dart';
import 'package:edu_sphere/features/student/assessment_student/presesntations/widgets/delete_submit_document_alert.dart';
import 'package:edu_sphere/features/student/assessment_student/presesntations/widgets/loading_add_or_delete_submit_assessment_widget.dart';
import 'package:edu_sphere/features/student/assessment_student/presesntations/widgets/shimmer_upload_file_widget.dart';
import 'package:edu_sphere/features/teacher/assessments/domain/entities/assessment.dart';
import 'package:edu_sphere/features/teacher/teacher_main/presentation/widgets/section_card.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';
class UploadFileStudentAssessmentWidget extends StatelessWidget {
  Assessment assessment;
  int idCourse;
   UploadFileStudentAssessmentWidget({super.key,required this.assessment,required this.idCourse});

  @override
  Widget build(BuildContext context) {
    return SectionCard(title: 'Upload Files', icon: 'assets/svgs/upload_file_icon.svg', widget: Column(
      children: [
        verticalSpace(20),
        BlocBuilder<StudentAssessmentCubit,StudentAssessmentState>(
          // buildWhen: (previous, current) => current is GetDocumentSubmitAssessmentLoadedState,
          builder: (context, state) {
            if(state is ErrorMessageGetDocumentSubmitAssessmentState){
              return Container(
                width: double.infinity,
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
                    Column(
                      children: [
                        Image.asset('assets/images/upload_file_image.png',width: 70.w,height: 70.h,),
                        verticalSpace(8),
                        Text('Upload images and files',style: TextStyles.font12Black400Weight),
                        verticalSpace(8),
                      ],
                    ),
                    verticalSpace(24),
                    Visibility(
                        visible: assessment.endIn.isAfter(DateTime.now())&&assessment.startIn.isBefore(DateTime.now()),
                        child: AppTextButton(buttonText: 'Submit File',onPressed:()=> _showBottomSheet(context,idAssessment: assessment.id,idCourse: idCourse),)),

                  ],
                ),
              );
            }
            if(state is GetDocumentSubmitAssessmentLoadingState){
              return Container(
                  margin: EdgeInsets.only(top: 20),
                  child: ShimmerUploadFileWidget(),);
            }
            else if(state is GetDocumentSubmitAssessmentLoadedState){
              return state.documentAssessment!=null? Container(
                width: double.infinity,
                padding:  EdgeInsetsDirectional.only(start: 10),
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
                child: ListTile(
                  trailing:assessment.endIn.isBefore(DateTime.now())?null: IconButton(onPressed: (){
                    showDialog(context: context, builder: (context) => DeleteSubmitDocumentAlert(idCourse: idCourse, idAssessment: assessment.id));
                  }, icon: SvgPicture.asset('assets/svgs/delete_icon.svg')),
                  contentPadding: EdgeInsets.zero,
                  leading: SvgPicture.asset('assets/svgs/pdf_icon.svg'),
                  title: Text(state.documentAssessment!.title??'Assessment ',style: TextStyles.font14Black400Weight),
                ),
              ):Container(
                width: double.infinity,
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
                    Column(
                      children: [
                        Image.asset('assets/images/upload_file_image.png',width: 70.w,height: 70.h,),
                        verticalSpace(8),
                        Text('Upload images and files',style: TextStyles.font12Black400Weight),
                        verticalSpace(8),
                      ],
                    ),
                    verticalSpace(24),
                    Visibility(
                        visible: assessment.endIn.isAfter(DateTime.now())&&assessment.startIn.isBefore(DateTime.now()),
                        child: AppTextButton(buttonText: 'Submit File',onPressed:()=> _showBottomSheet(context,idAssessment: assessment.id,idCourse: idCourse),)),

                  ],
                ),
              );
            }else{
              return Container(
                width: double.infinity,
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
                    Column(
                      children: [
                        Image.asset('assets/images/upload_file_image.png',width: 70.w,height: 70.h,),
                        verticalSpace(8),
                        Text('Upload images and files',style: TextStyles.font12Black400Weight),
                        verticalSpace(8),
                      ],
                    ),
                    verticalSpace(24),
                    Visibility(
                        visible: assessment.endIn.isAfter(DateTime.now())&&assessment.startIn.isBefore(DateTime.now()),
                        child: AppTextButton(buttonText: 'Submit File',onPressed:()=> _showBottomSheet(context,idAssessment: assessment.id,idCourse: idCourse),)),

                  ],
                ),
              );
            }
              return  SizedBox.shrink();
          },
        ),

      ],
    ));
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
              LoadingAddOrDeleteSubmitAssessmentWidget(message: 'submit assessment has been added successfully'),
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
                        .read<StudentAssessmentCubit>()
                        .emitSubmitStudentAssessment(idCourse: idCourse, idAssessment: idAssessment, files: filesList);
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
