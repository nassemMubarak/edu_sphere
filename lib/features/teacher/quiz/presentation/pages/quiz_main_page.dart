import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/widgets/app_text_button.dart';
import 'package:edu_sphere/core/widgets/sliver_widget.dart';
import 'package:edu_sphere/core/widgets/toggle_text_widget.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/widgets/quiz_widgets/delete_quiz_info_dialog.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/widgets/quiz_widgets/edit_quiz_dialog.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/widgets/quiz_widgets/show_or_hid_quiz_info_dialog.dart';
import 'package:edu_sphere/features/teacher/quiz/domain/entities/quiz.dart';
import 'package:edu_sphere/features/teacher/quiz/presentation/bloc/quiz_cubit.dart';
import 'package:edu_sphere/features/teacher/quiz/presentation/widgets/add_question_dialog.dart';
import 'package:edu_sphere/features/teacher/quiz/presentation/widgets/show_question_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuizMainPage extends StatelessWidget {
  const QuizMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizCubit, QuizState>(
      builder: (context, state) {
        if (state is QuizSelected) {
          return buildSliverWidget(context, state.quiz);
        } else {
          return context.read<QuizCubit>().quiz!=null?buildSliverWidget(context, context.read<QuizCubit>().quiz!):const SizedBox.shrink();
        }
      },
    );
  }

  SliverWidget buildSliverWidget(BuildContext context, Quiz quiz) {
    return SliverWidget(
          leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: Icon(Icons.arrow_back),
          ),
          widget: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Text('Home',
                        style: TextStyles.font12NeutralGray400Weight),
                    horizontalSpace(8),
                    Icon(Icons.arrow_forward_ios_sharp,
                        color: ColorsManager.darkLightBlue, size: 15),
                    horizontalSpace(8),
                    Text('Data Science',
                        style: TextStyles.font12NeutralGray400Weight),
                    horizontalSpace(8),
                    Icon(Icons.arrow_forward_ios_sharp,
                        color: ColorsManager.darkLightBlue, size: 15),
                    horizontalSpace(8),
                    Text(quiz.quizTitle,
                        style: TextStyles.font12Black500Weight),
                  ],
                ),
                verticalSpace(24),
                // card show time quiz
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
                  child: !quiz.endDateTime.isBefore(DateTime.now()) &&
                          quiz.startDateTime
                                  .difference(DateTime.now())
                                  .inDays <
                              5
                      ? Row(
                          children: [
                            Expanded(
                                child: Text(
                              'Remaining to start Quiz',
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
                                    minutes: quiz.startDateTime
                                        .difference(DateTime.now())
                                        .inMinutes),
                                showZeroValue: true,
                              ),
                            ),
                          ],
                        )
                      : quiz.endDateTime.isBefore(DateTime.now())
                          ? Text(
                              'Quiz submission deadline is over',
                              textAlign: TextAlign.center,
                              style: TextStyles.font12Red400Weight,
                            )
                          : Text(
                              'َQuiz has started and you cannot add questions',
                              style: TextStyles.font12Red400Weight,
                            ),
                ),
                verticalSpace(24),
                // card show detail quiz
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
                          'assets/svgs/quiz_leading_icon.svg',
                          width: 24.w,
                          height: 24.h,
                          color: ColorsManager.mainBlue,
                        ),
                        title: Text(
                          quiz.quizTitle,
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
                                    builder: (context) => ShowOrHidQuizInfoDialog(quiz: quiz),
                                  );
                                },
                                child: Icon(quiz.isHideQuiz?Icons.visibility_off_outlined:Icons.visibility_outlined,
                                    color: Colors.black),
                              ),
                              horizontalSpace(8),
                              GestureDetector(
                                onTap: (){
                                  showDialog(
                                    context: context,
                                    builder: (context) => EditQuizDialog(quiz: quiz),
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
                                    builder: (context) => DeleteQuizInfoDialog(quiz: quiz),
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
                                  ToggleText(text: quiz.description)),
                        ],
                      ),
                      buildListTile(
                          subTitle:
                              '${quiz.startDateTime.day}/${quiz.startDateTime.month}/${quiz.startDateTime.year}',
                          svgUrl: 'assets/svgs/quiz_date.svg',
                          title: 'Quiz start date'),
                      buildListTile(
                          subTitle:
                              '${quiz.endDateTime.day}/${quiz.endDateTime.month}/${quiz.endDateTime.year}',
                          svgUrl: 'assets/svgs/quiz_date.svg',
                          title: 'Quiz end date'),
                      buildListTile(
                          subTitle: DateFormat.jm()
                              .format(quiz.startDateTime),
                          svgUrl: 'assets/svgs/quiz_time.svg',
                          title: 'Quiz start time'),
                      buildListTile(
                          subTitle:
                              DateFormat.jm().format(quiz.endDateTime),
                          svgUrl: 'assets/svgs/quiz_time.svg',
                          title: 'Quiz end time'),
                      buildListTile(
                          subTitle: quiz.timeLift.toString(),
                          svgUrl: 'assets/svgs/time_icon.svg',
                          title: 'Time lift'),
                      buildListTile(
                          subTitle: quiz.passingScore.toString(),
                          svgUrl: 'assets/svgs/quiz_score_icon.svg',
                          title: 'Quiz Score'),
                      Visibility(
                        visible: !quiz.endDateTime.isBefore(DateTime.now()),
                        child: AppTextButton(
                          onPressed: (){
                            showDialog(
                              context: context,
                              builder: (context) => AddQuestionDialog(),
                            );
                          },
                            buttonText: 'Add Quiz Questions',
                            buttonWidth: 190.w),
                      ),
                    ],
                  ),
                ),
                // verticalSpace(24),
                quiz.questions!=null?ListView.builder(
                  itemCount: quiz.questions!.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => ShowQuestionWidget(question: quiz.questions![index], index: index),
                ):SizedBox.shrink(),
              ],
            ),
          ),
        );
  }

  ListTile buildListTile(
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

