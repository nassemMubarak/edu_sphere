import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/widgets/alert_dialog_widget.dart';
import 'package:edu_sphere/features/student/assessment_student/presesntations/bloc/student_assessment_cubit.dart';
import 'package:edu_sphere/features/student/assessment_student/presesntations/widgets/loading_add_or_delete_submit_assessment_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class DeleteSubmitDocumentAlert extends StatelessWidget {
   int idCourse; int idAssessment;
   DeleteSubmitDocumentAlert({super.key,required this.idAssessment,required this.idCourse});

  @override
  Widget build(BuildContext context) {
    return AlertDialogWidget(title: 'Delete Submit', textButton: 'Delete', widget: Column(
      children: [
        LoadingAddOrDeleteSubmitAssessmentWidget(message: 'submit assessment has been delete successfully'),
        Text('Do you really want to Edit file ?',style: TextStyles.font14Black500Weight,textAlign: TextAlign.center,),
      ],
    ), onTapButton: (){
      context.read<StudentAssessmentCubit>().emitDeleteSubmitStudentAssessment(idCourse: idCourse, idAssessment: idAssessment);

    });
  }
}
