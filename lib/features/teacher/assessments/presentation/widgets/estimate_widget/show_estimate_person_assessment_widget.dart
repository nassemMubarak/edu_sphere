import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/features/teacher/assessments/domain/entities/estimate_assessment.dart';
import 'package:edu_sphere/features/teacher/assessments/presentation/widgets/estimate_widget/edit_assessment_evaluation_dialog.dart';
import 'package:edu_sphere/features/teacher/assessments/presentation/widgets/estimate_widget/loading_add_estimate_widgte.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logger/logger.dart';

import '../../../../../../core/routing/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShowEstimatePersonAssessmentWidget extends StatelessWidget {
  EstimateAssessment estimateAssessment;
  int idCourse;
  int idAssessment;
  int grade;
  int indexEstimateAssessment;
  Function()? onTapListTail;

    ShowEstimatePersonAssessmentWidget(
      {super.key,
      required this.estimateAssessment,
      this.onTapListTail,
      required this.indexEstimateAssessment,
      required this.idCourse,
      required this.grade,
      required this.idAssessment});

  @override
  Widget build(BuildContext context) {
    Logger().d('estimateAssessment------------->$estimateAssessment');
    return ListTile(
      onTap: onTapListTail ??
          () {
        if(estimateAssessment.assignmentAssessment.isNotEmpty){

            context.pushNamed(Routes.showReviewAssessmentPage);
        }
          },
      titleAlignment: ListTileTitleAlignment.center,
      contentPadding: EdgeInsetsDirectional.zero,
      leading: CircleAvatar(
          backgroundColor: ColorsManager.neutralGray.withOpacity(0.3),
          radius: 15,
          child: Icon(
            Icons.person,
            color: ColorsManager.neutralGray,
            size: 15,
          )),
      title: Text(
        estimateAssessment.name,
        style: TextStyles.font12Black400Weight,
      ),
      subtitle: Text(
        estimateAssessment.email,
        style: TextStyles.font10Black400Weight,
      ),
      trailing: SizedBox(
        width: 100.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              estimateAssessment.assignmentAssessment.isNotEmpty
                  ? estimateAssessment.assignmentAssessment.first.grade!=null? '${estimateAssessment.assignmentAssessment.first.grade!.result}/$grade':
                      'Not Rated'
                  : 'Not Rated',
              style: estimateAssessment.assignmentAssessment.isNotEmpty
                  ? estimateAssessment.assignmentAssessment.first.grade != null
                      ? TextStyles.font10Black400Weight
                      : TextStyles.font10NeutralGray400Weight
                  : TextStyles.font10NeutralGray400Weight,
            ),
            horizontalSpace(5),

          GestureDetector(
              onTap: () {
                if (estimateAssessment.assignmentAssessment.isNotEmpty) {
                  showDialog(
                      context: context,
                      builder: (context) => EditAssessmentEvaluationDialog(
                          idAssessment: idAssessment,
                          idStudent:estimateAssessment.id ,
                          idCourse: idCourse,
                          grade: grade,
                          idEstimate:
                              estimateAssessment.assignmentAssessment.first.id,
                          indexEstimateAssessment: indexEstimateAssessment,),);
                }
              },
              // child: Icon(quiz.isHideQuiz?Icons.visibility_off_outlined:Icons.visibility_outlined,
              child: SvgPicture.asset(
                'assets/svgs/edite_icon.svg',
                height: 18,
                width: 18,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
