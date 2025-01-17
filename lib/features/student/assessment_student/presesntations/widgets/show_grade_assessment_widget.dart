import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/features/student/assessment_student/presesntations/bloc/student_assessment_cubit.dart';
import 'package:edu_sphere/features/student/assessment_student/presesntations/widgets/shimmer_upload_file_widget.dart';
import 'package:edu_sphere/features/teacher/assessments/domain/entities/assessment.dart';
import 'package:edu_sphere/features/teacher/teacher_main/presentation/widgets/section_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class ShowGradeAssessmentWidget extends StatelessWidget {
  Assessment assessment;

  ShowGradeAssessmentWidget({super.key, required this.assessment});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentAssessmentCubit,StudentAssessmentState>(
      builder: (context, state) {
        if(state is GetDocumentSubmitAssessmentLoadingState){
          return Container(
            margin: EdgeInsets.only(top: 20),
            child: ShimmerUploadFileWidget(),);
        }else if(state is GetDocumentSubmitAssessmentLoadedState){
          return state.documentAssessment!=null&&state.documentAssessment!.grade!=null?Container(
            margin: EdgeInsetsDirectional.only(top: 24),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'status',
                      style: TextStyles.font14Black500Weight,
                    ),
                    verticalSpace(16),
                    Text(
                      'Finished',
                      style: TextStyles.font12Black400Weight,
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'mark',
                      style: TextStyles.font14Black500Weight,
                    ),
                    verticalSpace(16),
                    Row(
                      children: [
                        Text(
                          '${state.documentAssessment!.grade!.result}/${assessment.degree}',
                          style:
                          TextStyles.font12NeutralGray400Weight,
                        ),
                        horizontalSpace(8),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ): Container(
            margin: EdgeInsetsDirectional.only(top: 24),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'status',
                      style: TextStyles.font14Black500Weight,
                    ),
                    verticalSpace(16),
                    Text(
                      'Finished',
                      style: TextStyles.font12Black400Weight,
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'mark',
                      style: TextStyles.font14Black500Weight,
                    ),
                    verticalSpace(16),
                    Row(
                      children: [
                        Text(
                          'Not Rated',
                          style:
                          TextStyles.font12NeutralGray400Weight,
                        ),
                        horizontalSpace(8),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        }
        return Container(
          margin: EdgeInsetsDirectional.only(top: 24),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'status',
                    style: TextStyles.font14Black500Weight,
                  ),
                  verticalSpace(16),
                  Text(
                    'Finished',
                    style: TextStyles.font12Black400Weight,
                  ),
                ],
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'mark',
                    style: TextStyles.font14Black500Weight,
                  ),
                  verticalSpace(16),
                  Row(
                    children: [
                      Text(
                        'Not Rated',
                        style:
                        TextStyles.font12NeutralGray400Weight,
                      ),
                      horizontalSpace(8),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );

      },
    );
  }
}
