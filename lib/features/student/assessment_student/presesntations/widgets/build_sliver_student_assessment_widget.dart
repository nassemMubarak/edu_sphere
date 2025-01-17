import 'dart:io';

import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/routing/routes.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/util/file_utils.dart';
import 'package:edu_sphere/core/widgets/app_text_button.dart';
import 'package:edu_sphere/core/widgets/bread_crumb_widget.dart';
import 'package:edu_sphere/core/widgets/image_and_text_empty_data.dart';
import 'package:edu_sphere/core/widgets/toggle_text_widget.dart';
import 'package:edu_sphere/features/student/assessment_student/presesntations/bloc/student_assessment_cubit.dart';
import 'package:edu_sphere/features/student/assessment_student/presesntations/widgets/show_grade_assessment_widget.dart';
import 'package:edu_sphere/features/student/assessment_student/presesntations/widgets/upload_file_student_assessment_widget.dart';
import 'package:edu_sphere/features/student/student_main/presentations/bloc/subscribe_student_courses/subscribe_student_courses_cubit.dart';
import 'package:edu_sphere/features/teacher/assessments/domain/entities/assessment.dart';
import 'package:edu_sphere/features/teacher/assessments/domain/entities/document_assessment.dart';
import 'package:edu_sphere/features/teacher/assessments/presentation/bloc/assessments_cubit.dart';
import 'package:edu_sphere/features/teacher/assessments/presentation/widgets/assessment_widget/delete_assessments_info_dialog.dart';
import 'package:edu_sphere/features/teacher/assessments/presentation/widgets/assessment_widget/delete_file_assessment_info_dialog.dart';
import 'package:edu_sphere/features/teacher/assessments/presentation/widgets/assessment_widget/edit_assessment_dialog.dart';
import 'package:edu_sphere/features/teacher/assessments/presentation/widgets/assessment_widget/loading_add_or_update_or_assessment_quiz_widget.dart';
import 'package:edu_sphere/features/teacher/assessments/presentation/widgets/assessment_widget/show_or_hid_assessment_info_dialog.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/bloc/course_main_cubit.dart';
import 'package:edu_sphere/features/teacher/teacher_main/presentation/widgets/section_card.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:slide_countdown/slide_countdown.dart';

import '../../../../../../core/widgets/sliver_widget.dart';
class BuildSliverStudentAssessmentWidget extends StatelessWidget {
  Assessment assessment;
  BuildSliverStudentAssessmentWidget({super.key,required this.assessment});

  @override
  Widget build(BuildContext context) {
    var coursesModel = context
        .read<SubscribeStudentCoursesCubit>()
        .courseSelected;
    context.read<StudentAssessmentCubit>().emitGetAllSubmitStudentAssessment(idCourse: coursesModel!.id, idAssessment: assessment.id);

    return Padding(
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
            child:assessment.endIn.isAfter(DateTime.now())&&assessment.startIn.isBefore(DateTime.now())?Row(
              children: [
                Expanded(
                    child: Text(
                      'Remaining to ended assessment',
                      style: TextStyles.font12Red400Weight,
                    )),
                horizontalSpace(13),
                Expanded(
                  child: SlideCountdownSeparated(
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(5)),
                    style: TextStyles.font12White600Weight,
                    duration: Duration(
                        seconds: assessment.endIn
                            .difference(DateTime.now())
                            .inSeconds),
                    showZeroValue: true,
                  ),
                ),
              ],
            ):!assessment.endIn.isBefore(DateTime.now()) &&
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
                if(assessment.documents!=null&&assessment.documents!.isNotEmpty)
                  ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: assessment.documents!.length,

                      itemBuilder: (context, index) =>ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: SvgPicture.asset('assets/svgs/pdf_icon.svg'),
                        title: Text(assessment.documents![index].title??'Assessment $index',style: TextStyles.font14Black400Weight),
                      ) ,),

              ],
            ),
          ),
          verticalSpace(24),
          UploadFileStudentAssessmentWidget(assessment: assessment, idCourse: coursesModel.id),
          verticalSpace(24),
          Visibility(
            visible: assessment.endIn.isBefore(DateTime.now()),
            child: SectionCard(
              title: 'Assignment status',
              icon: 'assets/svgs/flag_quiz_status.svg',
              widget:ShowGradeAssessmentWidget(assessment: assessment),
            ),
          )
        ],
      ),
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
