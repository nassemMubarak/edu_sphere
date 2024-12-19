import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/features/teacher/quiz/presentation/widgets/estimate_widget/edit_quiz_evaluation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../core/routing/routes.dart';
class ShowEstimatePersonWidget extends StatelessWidget {
  String name;
  String grad;
  Function()? onTapListTail;
   ShowEstimatePersonWidget({super.key,required this.name,required this.grad,this.onTapListTail});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTapListTail??(){
        context.pushNamed(Routes.showReviewQuizPage);
      },
      titleAlignment: ListTileTitleAlignment.center,
      contentPadding: EdgeInsetsDirectional.zero,

      leading: CircleAvatar(
          backgroundColor: ColorsManager.neutralGray.withOpacity(0.3),
          radius: 15,
          child: Icon(Icons.person,color: ColorsManager.neutralGray,size: 15,)),
      title: Text(
        name,
        style: TextStyles.font10Black400Weight,
      ),
      trailing: SizedBox(
        width: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(grad,style: TextStyles.font10Black400Weight,),
            horizontalSpace(5),
            GestureDetector(
              onTap: (){
                showDialog(context: context, builder: (context) => EditQuizEvaluationDialog());
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
