
import 'dart:io';

import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/widgets/full_screen_image_widget.dart';
import 'package:edu_sphere/features/teacher/quiz/domain/entities/question.dart';
import 'package:edu_sphere/features/teacher/quiz/presentation/widgets/questions_widgets/delete_question_info_dialog.dart';
import 'package:edu_sphere/features/teacher/quiz/presentation/widgets/questions_widgets/edit_question_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
class ShowQuestionWidget extends StatelessWidget {
  Question question;
  int index;
  bool isHideEditAndDeleteIcon = true;
   ShowQuestionWidget({
    super.key,
     required this.question,
     required this.index,
     this.isHideEditAndDeleteIcon = true
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(bottom: 20.h),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // show question Text Or Text And Image
          ListTile(
            titleAlignment: ListTileTitleAlignment.center,
            contentPadding: EdgeInsetsDirectional.zero,
            leading: SvgPicture.asset(
              'assets/svgs/question_message_icon.svg',
              width: 24.w,
              height: 24.h,
              color: ColorsManager.mainBlue,
            ),
            title: Text(
              'Questions ${index+1}',
              style: TextStyles.font14Black500Weight,
            ),
            trailing: Visibility(
              visible: isHideEditAndDeleteIcon,
              child: SizedBox(
                width: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: (){
                        showDialog(
                          context: context,
                          builder: (context) => EditQuestionDialog(question: question,indexQuestion: index,),
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
                          builder: (context) => DeleteQuestionInfoDialog(question: question),
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
          ),
          verticalSpace(16),
          ListTile(
            titleAlignment: ListTileTitleAlignment.top,
            leading: Container(
              margin: EdgeInsets.only(top: 15.h),
              height: 4.h,
              width: 4.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2.r),
                  color: Colors.black
              ),
            ),
            title:Text(question.questionText,style: TextStyles.font14Black500Weight,) ,
          ),
          question.questionPathImage!=null?GestureDetector(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FullScreenImageWidget(imagePath: question.questionPathImage!),
                ),
              );
            },
            child: Container(
              margin: EdgeInsetsDirectional.only(bottom: 16,start: 15.w),
              width: 105.0.h,
              height: 115.0.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                // border: Border.all(color: ColorsManager.mainBlue,width: 2),
                borderRadius: BorderRadius.circular(10),

              ),
              // padding: EdgeInsetsDirectional.only(start: 30),
              child: ClipRRect(
              borderRadius: BorderRadius.circular(10),  // Image border radius
              child: Image.file(
                File(question.questionPathImage!),
                width: double.infinity,
                height: 115.0.w,
                fit: BoxFit.cover, // Crop the image to cover the container
              ),
                        ),
            ),
          ):SizedBox.shrink(),
          // choices
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: SvgPicture.asset('assets/svgs/choice_icon.svg'),
            title:Text('Choices',style: TextStyles.font14Black500Weight,),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: question.options.length,
            itemBuilder: (context, index) => ListTile(
            // contentPadding: EdgeInsets.zero,
            titleAlignment: ListTileTitleAlignment.top,
            leading: Container(
              margin: EdgeInsets.only(top: 15.h),
              height: 4.h,
              width: 4.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2.r),
                  color: Colors.black
              ),
            ),
            title:Text(question.options[index],style: TextStyles.font14Black400Weight,) ,
          ),),
          // Correct choice
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: SvgPicture.asset('assets/svgs/choice_icon.svg'),
            title:Text('Correct Choice',style: TextStyles.font14Black500Weight,),
          ),
          ListTile(
            // contentPadding: EdgeInsets.zero,
            titleAlignment: ListTileTitleAlignment.top,
            leading: Container(
              margin: EdgeInsets.only(top: 15.h),
              height: 4.h,
              width: 4.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2.r),
                  color: Colors.black
              ),
            ),
            title:Text(question.correctAnswer,style: TextStyles.font14Black400Weight,) ,
          ),
          // Question Score
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: SvgPicture.asset('assets/svgs/quiz_score_icon.svg'),
            title:Text('Question Score',style: TextStyles.font14Black500Weight,),
          ),
          ListTile(
            // contentPadding: EdgeInsets.zero,
            titleAlignment: ListTileTitleAlignment.top,
            leading: Container(
              margin: EdgeInsets.only(top: 15.h),
              height: 4.h,
              width: 4.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2.r),
                  color: Colors.black
              ),
            ),
            title:Text(question.questionScore,style: TextStyles.font14Black400Weight,) ,
          ),
        ],
      ),
    );
  }
}
