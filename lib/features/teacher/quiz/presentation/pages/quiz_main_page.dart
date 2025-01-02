import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/routing/routes.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/widgets/app_text_button.dart';
import 'package:edu_sphere/core/widgets/bread_crumb_widget.dart';
import 'package:edu_sphere/core/widgets/sliver_widget.dart';
import 'package:edu_sphere/core/widgets/toggle_text_widget.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/bloc/course_main_cubit.dart';
import 'package:edu_sphere/features/teacher/quiz/domain/entities/quize.dart';
import 'package:edu_sphere/features/teacher/quiz/presentation/bloc/question/question_cubit.dart';
import 'package:edu_sphere/features/teacher/quiz/presentation/widgets/quiz_widget/delete_quiz_info_dialog.dart';
import 'package:edu_sphere/features/teacher/quiz/presentation/widgets/quiz_widget/edit_quiz_dialog.dart';
import 'package:edu_sphere/features/teacher/quiz/presentation/widgets/quiz_widget/show_or_hid_quiz_info_dialog.dart';
import 'package:edu_sphere/features/teacher/quiz/domain/entities/quiz.dart';
import 'package:edu_sphere/features/teacher/quiz/presentation/bloc/quiz_cubit.dart';
import 'package:edu_sphere/features/teacher/quiz/presentation/widgets/questions_widgets/add_question_dialog.dart';
import 'package:edu_sphere/features/teacher/quiz/presentation/widgets/questions_widgets/show_question_widget.dart';
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
   int idCourse = context.read<CourseMainCubit>().coursesModel.id;

    return BlocBuilder<QuizCubit, QuizState>(
      builder: (context, state) {
        if (state is QuizeSelected) {
          return buildSliverWidget(context, state.quiz,idCourse: idCourse);
        }else if(state is GetAllQuizLoadedState){
          return buildSliverWidget(context, context.read<QuizCubit>().quize!,idCourse: idCourse);

        }
        else {
          return context.read<QuizCubit>().quize!=null?buildSliverWidget(context, context.read<QuizCubit>().quize!,idCourse: idCourse):const SizedBox.shrink();
        }
      },
    );
  }
  SliverWidget buildSliverWidget(BuildContext context, Quize quiz,{required int idCourse}) {
    context.read<QuestionCubit>().emitGetAllQuestion(idQuiz: quiz.id, idCourse: idCourse);
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
          actions: quiz.endIn.isBefore(DateTime.now())?[
            GestureDetector(
                onTap: (){
                  context.pushNamed(Routes.estimateQuizPage);
                },
                child: SvgPicture.asset('assets/svgs/assessment_estimates_color_icon.svg',color: Colors.white,)),
            horizontalSpace(30)
          ]:[],
          widget: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
               BreadCrumbWidget(
              items: ['Home', coursesModel.title, quiz.title],
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
                  child: !quiz.endIn.isBefore(DateTime.now()) &&
                          quiz.startIn
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
                                    seconds: quiz.startIn
                                        .difference(DateTime.now())
                                        .inSeconds),
                                showZeroValue: true,
                              ),
                            ),
                          ],
                        )
                      : quiz.endIn.isBefore(DateTime.now())
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
                          quiz.title,
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
                                    builder: (context) => ShowOrHidQuizInfoDialog(quiz: quiz,idCourse: idCourse),
                                  );
                                },
                                  child: Icon(quiz.visibility==0?Icons.visibility_off_outlined:
                                  Icons.visibility_outlined,
                                    color: Colors.black),
                              ),
                              horizontalSpace(8),
                              GestureDetector(
                                onTap: (){
                                  showDialog(
                                    context: context,
                                    builder: (context) => EditQuizDialog(quiz: quiz,idCourse: idCourse,),
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
                                    builder: (context) => DeleteQuizInfoDialog(quiz: quiz, idCourse: idCourse),
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
                              '${quiz.startIn.day}/${quiz.startIn.month}/${quiz.startIn.year}',
                          svgUrl: 'assets/svgs/quiz_date.svg',
                          title: 'Quiz start date'),
                      buildListTile(
                          subTitle:
                              '${quiz.endIn.day}/${quiz.endIn.month}/${quiz.endIn.year}',
                          svgUrl: 'assets/svgs/quiz_date.svg',
                          title: 'Quiz end date'),
                      buildListTile(
                          subTitle: DateFormat.jm()
                              .format(quiz.startIn),
                          svgUrl: 'assets/svgs/quiz_time.svg',
                          title: 'Quiz start time'),
                      buildListTile(
                          subTitle:
                              DateFormat.jm().format(quiz.endIn),
                          svgUrl: 'assets/svgs/quiz_time.svg',
                          title: 'Quiz end time'),
                      buildListTile(
                          subTitle: quiz.time.toString(),
                          svgUrl: 'assets/svgs/time_icon.svg',
                          title: 'Time lift'),
                      buildListTile(
                          subTitle: quiz.degree.toString(),
                          svgUrl: 'assets/svgs/quiz_score_icon.svg',
                          title: 'Quiz Score'),
                      Visibility(
                        visible: !quiz.endIn.isBefore(DateTime.now()),
                        child: AppTextButton(
                          onPressed: (){
                            showDialog(
                              context: context,
                              builder: (context) => AddQuestionDialog(idCourse: idCourse,idQuiz: quiz.id),
                            );
                          },
                            buttonText: 'Add Quiz Questions',
                            buttonWidth: 190.w),
                      ),
                    ],
                  ),
                ),
                /// Show Question Widget
                BlocBuilder<QuestionCubit,QuestionState>(builder: (context, state) {
                  if(state is GetAllQuestionLoadedState){
                    return state.listQuestion.isNotEmpty?Column(
                      children: [
                        verticalSpace(24),
                        ListView.builder(
                          itemCount: state.listQuestion.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => ShowQuestionWidget(idCourse: idCourse,idQuiz: quiz.id,question: state.listQuestion[index], index: index),
                        )
                      ],
                    ):SizedBox.shrink();
                  }else{
                    return context.read<QuestionCubit>().listOfQuestion.isNotEmpty?Column(
                      children: [
                        verticalSpace(24),
                        ListView.builder(
                          itemCount:context.read<QuestionCubit>().listOfQuestion.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => ShowQuestionWidget(idCourse: idCourse,idQuiz: quiz.id,question: context.read<QuestionCubit>().listOfQuestion[index], index: index),
                        )
                      ],
                    ):SizedBox.shrink();
                  }
                },),
                // verticalSpace(24),
                // quiz.questions!=null?ListView.builder(
                //   itemCount: quiz.questions!.length,
                //   shrinkWrap: true,
                //   physics: NeverScrollableScrollPhysics(),
                //   itemBuilder: (context, index) => ShowQuestionWidget(question: quiz.questions![index], index: index),
                // ):SizedBox.shrink(),
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

