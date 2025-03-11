import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/widgets/full_screen_image_widget.dart';
import 'package:edu_sphere/features/student/student_quiz/domain/entities/review_student_quiz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ShowquestiontoReviewstudentquiz extends StatelessWidget {
  QuestionData question;
  int index;

  ShowquestiontoReviewstudentquiz(
      {super.key, required this.question, required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsetsDirectional.only(bottom: 25.h),
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
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildQuestionRow(
                  context,
                  // imageUrl:question.documents.isNotEmpty? question.documents.first.url:null,
                  imageUrl: question.documents.isNotEmpty
                      ? 'assets/images/quiz_image.jpg'
                      : null,
                  number: (index + 1).toString(),
                  text: question.title,
                  isSelected: true,
                  isFirstRow: true,
                ),
                verticalSpace(15),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: question.options.length,
                  itemBuilder: (context, index) => _buildQuestionRow(
                      // imageUrl:question.documents.isNotEmpty? question.documents.first.url:null,
                      imageUrl: question.documents.isNotEmpty
                          ? 'assets/images/quiz_image.jpg'
                          : null,
                      context,
                      indexChoice: index,
                      text: question.options[index],
                      isSelected:
                          question.options[index] == question.studentAnswer,
                      isFirstRow: false,
                      isAnswerTrue:
                          question.options[index] == question.studentAnswer
                              ? question.isCorrect
                              : null),
                ),
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsetsDirectional.only(bottom: 30.h),
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
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: SvgPicture.asset('assets/svgs/quiz_score_icon.svg'),
                  title: Text('Correct choice',
                      style: TextStyles.font14Black500Weight),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  // titleAlignment: ListTileTitleAlignment.top,
                  leading: Container(
                    margin: REdgeInsetsDirectional.only(start: 10),
                    height: 4.h,
                    width: 4.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2.r),
                      color: Colors.black,
                    ),
                  ),
                  title: Text(question.correctAnswer,
                      style: TextStyles.font14Black400Weight),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: SvgPicture.asset('assets/svgs/quiz_score_icon.svg'),
                  title: Text('Your Score',
                      style: TextStyles.font14Black500Weight),
                ),
                ListTile(
                  contentPadding: EdgeInsetsDirectional.only(start: 48.w,bottom: 0,top: 0),
                  title: Text(question.isCorrect?question.mark.toString():'0',
                      style: TextStyles.font14Black500Weight),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuestionRow(
    BuildContext context, {
    String? number,
    String? imageUrl,
    required String text,
    required bool isSelected,
    bool? isAnswerTrue,
    int? indexChoice,
    bool isFirstRow = false,
  }) {
    return Padding(
      padding: EdgeInsetsDirectional.only(bottom: isFirstRow ? 0 : 15),
      child: GestureDetector(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                isFirstRow
                    ? Column(
                        children: [
                          CircleAvatar(
                            radius: 12,
                            backgroundColor: ColorsManager.mainBlue,
                            child: Text(
                              number ?? '',
                              style: TextStyles.font15White500Weight,
                            ),
                          ),
                          verticalSpace(10),
                        ],
                      )
                    : Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(color: Colors.blue, width: 2),
                          shape: BoxShape.circle,
                        ),
                        child: CircleAvatar(
                          radius: 8,
                          backgroundColor: isSelected && !isFirstRow
                              ? Colors.grey
                              : Colors.transparent,
                        ),
                      ),
                horizontalSpace(8),
                Expanded(
                  child: Stack(
                    children: [
                      Text(
                        text,
                        textAlign: TextAlign.start,
                        style: isFirstRow
                            ? TextStyles.font14Black500Weight
                            : TextStyles.font14Black400Weight,
                      ),
                      Visibility(
                        visible: isFirstRow,
                        child: PositionedDirectional(
                          end: 0,
                          bottom: 0,
                          child: Container(
                            padding: EdgeInsets.all(2),
                            alignment: Alignment.center,
                            width: 70.w,
                            decoration: BoxDecoration(
                              color: ColorsManager.secondaryColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'mark : ${question.mark}',
                              style: TextStyles.font10White400Weight,
                            ),
                          ),
                        ),
                      ),
                      if (isSelected && isAnswerTrue != null)
                        PositionedDirectional(
                                end: 0,
                                bottom: 0,
                                child:isAnswerTrue? Icon(
                                  Icons.check_circle,
                                  size: 24,
                                  color: Colors.green,
                                ):CircleAvatar(child: Icon(Icons.clear_outlined,size: 12,color: Colors.white,),radius: 10,backgroundColor: Colors.red,),),

                    ],
                  ),
                ),
              ],
            ),
            imageUrl != null && isFirstRow
                ? GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          // builder: (context) => FullScreenImageWidget(networkImageUrl: question.documents![0].url,),
                          builder: (context) => FullScreenImageWidget(
                            networkImageUrl: imageUrl,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin:
                          EdgeInsetsDirectional.only(bottom: 16, start: 15.w),
                      width: 105.0.h,
                      height: 115.0.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        // border: Border.all(color: ColorsManager.mainBlue,width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      // padding: EdgeInsetsDirectional.only(start: 30),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(imageUrl)),
                    ),
                  )
                : SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
