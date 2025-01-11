  import 'package:edu_sphere/core/helpers/extenshions.dart';
  import 'package:edu_sphere/core/helpers/spacing.dart';
  import 'package:edu_sphere/core/routing/routes.dart';
  import 'package:edu_sphere/core/theming/colors.dart';
  import 'package:edu_sphere/core/theming/styles.dart';
  import 'package:edu_sphere/core/util/toast_notification_message.dart';
  import 'package:edu_sphere/core/widgets/alert_dialog_widget.dart';
  import 'package:edu_sphere/core/widgets/app_text_button.dart';
  import 'package:edu_sphere/core/widgets/bread_crumb_widget.dart';
  import 'package:edu_sphere/core/widgets/sliver_widget.dart';
  import 'package:edu_sphere/core/widgets/toggle_text_widget.dart';
  import 'package:edu_sphere/features/student/student_main/presentations/bloc/subscribe_student_courses/subscribe_student_courses_cubit.dart';
  import 'package:edu_sphere/features/student/student_quiz/presentation/bloc/student_quiz_cubit.dart';
  import 'package:edu_sphere/features/teacher/quiz/domain/entities/quiz.dart';
  import 'package:edu_sphere/features/teacher/teacher_main/presentation/widgets/section_card.dart';
  import 'package:flutter/cupertino.dart';
  import 'package:flutter/material.dart';
  import 'package:flutter_svg/flutter_svg.dart';
  import 'package:intl/intl.dart';
  import 'package:flutter_screenutil/flutter_screenutil.dart';
  import 'package:flutter_bloc/flutter_bloc.dart';
  import 'package:shimmer/shimmer.dart';
  import 'package:slide_countdown/slide_countdown.dart';

  class StudentQuizMainPage extends StatelessWidget {
    const StudentQuizMainPage({super.key});

    @override
    Widget build(BuildContext context) {
      final quiz = context.read<StudentQuizCubit>().quizSelected!;
      return _buildSliverWidget(context, quiz);
    }

    SliverWidget _buildSliverWidget(BuildContext context, Quiz quiz) {
      context.read<StudentQuizCubit>().emitIsShowStudentQuizUseCase(
            idCourse: quiz.courseId,
            idQuiz: quiz.id,
          );
      final coursesModel =
          context.read<SubscribeStudentCoursesCubit>().courseSelected;

      return SliverWidget(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back),
        ),
        widget: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              BreadCrumbWidget(items: ['Home', coursesModel!.title, quiz.title]),
              verticalSpace(24),
              _buildQuizTimerCard(context, quiz),
              verticalSpace(24),
              _buildQuizDetailsCard(context, quiz),
              verticalSpace(24),
              BlocBuilder<StudentQuizCubit, StudentQuizState>(
                buildWhen: (previous, current) =>
                    current is IsShowStudentQuizLoadedState ||
                    current is IsShowStudentQuizLoadingState,
                builder: (context, state) {
                  if (state is IsShowStudentQuizLoadedState) {
                    return state.estimateQuiz.quizAttempts.isEmpty
                        ? SectionCard(
                            title: 'Quiz status',
                            icon: 'assets/svgs/flag_quiz_status.svg',
                            widget: Container(
                              width: double.infinity,
                              alignment: Alignment.center,
                              margin: EdgeInsetsDirectional.only(top: 20,bottom: 20),
                              child: AppTextButton(
                                buttonText: 'Start Quiz',
                                onPressed: () => showDialog(
                                  context: context,
                                  builder: (context) => AlertDialogWidget(
                                    title: 'Start Quiz',
                                    textButton: 'Start Quiz',
                                    widget: Text(
                                      'Do you really want to start quiz?',
                                      textAlign: TextAlign.center,
                                      style: TextStyles.font14Black400Weight,
                                    ),
                                    onTapButton: () {
                                      context.pop();
                                      context
                                          .pushNamed(Routes.showStudentQuizPage);
                                    },
                                  ),
                                ),
                              ),
                            ),
                          )
                        : SectionCard(
                            title: 'Quiz status',
                            icon: 'assets/svgs/flag_quiz_status.svg',
                            widget: Container(
                              margin: EdgeInsetsDirectional.only(top: 24),
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Quiz status',
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
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Quiz mark',
                                        style: TextStyles.font14Black500Weight,
                                      ),
                                      verticalSpace(16),
                                      Text(
                                        state.estimateQuiz.quizAttempts.first.grade==null?'Not Rated':'${state.estimateQuiz.quizAttempts.first.grade!.result}/${quiz.degree}',
                                        style:
                                            TextStyles.font12NeutralGray400Weight,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ));
                  }
                  if (state is IsShowStudentQuizLoadingState) {
                    return SectionCard(
                      title: 'Quiz status',
                      icon: 'assets/svgs/flag_quiz_status.svg',
                      widget: SizedBox(
                        width: 143.w,
                        child: Container(
                          width: double.infinity,
                          margin: EdgeInsetsDirectional.only(top: 20,bottom: 20),
                          alignment: Alignment.center,
                          child: Text(
                            'Please Wait...',
                            textAlign: TextAlign.center,
                            style: TextStyles.font14Black400Weight,
                          ),
                        ),
                      ),
                    );
                  }
                  return SectionCard(
                    title: 'Quiz status',
                    icon: 'assets/svgs/flag_quiz_status.svg',
                    widget: SizedBox(
                      width: 143.w,
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        margin: EdgeInsetsDirectional.only(top: 20,bottom: 20),
                        child: Text(
                          'Please Wait...',
                          textAlign: TextAlign.center,
                          style: TextStyles.font14Black400Weight,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      );
    }

    Widget _buildQuizTimerCard(BuildContext context, Quiz quiz) {
      final now = DateTime.now();

      Widget getTimerContent() {
        if (!quiz.endIn.isBefore(now) && quiz.startIn.isBefore(now)) {
          return _buildTimerRow(
              'Remaining to end Quiz', quiz.endIn.difference(now), Colors.red,
              context: context, idQuiz: quiz.id, iddCourse: quiz.courseId);
        } else if (!quiz.endIn.isBefore(now) &&
            quiz.startIn.difference(now).inDays < 5) {
          return _buildTimerRow(
              'Remaining to start Quiz',
              quiz.startIn.difference(now),
              context: context,
              Colors.blue,
              idQuiz: quiz.id,
              iddCourse: quiz.courseId);
        } else if (quiz.endIn.isBefore(now)) {
          return Text(
            'Quiz submission deadline is over',
            textAlign: TextAlign.center,
            style: TextStyles.font12Red400Weight,
          );
        } else {
          return Text(
            'Quiz has started and you cannot add questions',
            style: TextStyles.font12Red400Weight,
          );
        }
      }

      return Container(
        width: 1.sw,
        padding: const EdgeInsets.all(16.0),
        decoration: _buildBoxDecoration(),
        child: getTimerContent(),
      );
    }

    Widget _buildTimerRow(String label, Duration duration, Color color,
        {required BuildContext context,
        required int idQuiz,
        required int iddCourse}) {
     return BlocBuilder<StudentQuizCubit, StudentQuizState>(
        buildWhen: (previous, current) =>
        current is IsShowStudentQuizLoadedState ||
            current is IsShowStudentQuizLoadingState,
        builder: (context, state) {
          if (state is IsShowStudentQuizLoadedState) {
            return state.estimateQuiz.quizAttempts.isEmpty
                ? Row(
              children: [
                Expanded(
                  child: Text(
                    label,
                    style: TextStyles.font10Red400Weight,
                  ),
                ),
                horizontalSpace(13),
                Expanded(
                  child: SlideCountdownSeparated(
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    style: TextStyles.font12White600Weight,
                    duration: duration,
                    showZeroValue: true,
                    onDone: () {
                      context.read<StudentQuizCubit>().emitIsShowStudentQuizUseCase(
                          idCourse: iddCourse, idQuiz: idQuiz);
                    },
                  ),
                ),
              ],
            )
              :Row(
              children: [
                Expanded(
                  child: Text(
                    'I have finished the test and submitted it.',
                    style: TextStyles.font12Red400Weight,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            );
          }
          if (state is IsShowStudentQuizLoadingState) {
            return Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: 200,
                  height: 10,
                  color: Colors.white,
                ));
          }
          return Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: TextStyles.font10Red400Weight,
                ),
              ),
              horizontalSpace(13),
              Expanded(
                child: SlideCountdownSeparated(
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  style: TextStyles.font12White600Weight,
                  duration: duration,
                  showZeroValue: true,
                  onDone: () {
                    context.read<StudentQuizCubit>().emitIsShowStudentQuizUseCase(
                        idCourse: iddCourse, idQuiz: idQuiz);
                  },
                ),
              ),
            ],
          );
        },

      );
    }

    Widget _buildQuizDetailsCard(BuildContext context, Quiz quiz) {
      return Container(
        padding: const EdgeInsets.all(16.0),
        decoration: _buildBoxDecoration(),
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
            ),
            verticalSpace(24),
            _buildQuizDescription(quiz),
            _buildQuizDetailTiles(quiz),
            // _buildStartQuizButton(context, quiz),
          ],
        ),
      );
    }

    Widget _buildQuizDescription(Quiz quiz) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset('assets/svgs/message_icon.svg'),
          horizontalSpace(8),
          SizedBox(
            width: 0.6.sw,
            child: ToggleText(text: quiz.description),
          ),
        ],
      );
    }

    Widget _buildQuizDetailTiles(Quiz quiz) {
      return Column(
        children: [
          _buildListTile(
            title: 'Quiz start date',
            subTitle:
                '${quiz.startIn.day}/${quiz.startIn.month}/${quiz.startIn.year}',
            svgUrl: 'assets/svgs/quiz_date.svg',
          ),
          _buildListTile(
            title: 'Quiz end date',
            subTitle: '${quiz.endIn.day}/${quiz.endIn.month}/${quiz.endIn.year}',
            svgUrl: 'assets/svgs/quiz_date.svg',
          ),
          _buildListTile(
            title: 'Quiz start time',
            subTitle: DateFormat.jm().format(quiz.startIn),
            svgUrl: 'assets/svgs/quiz_time.svg',
          ),
          _buildListTile(
            title: 'Quiz end time',
            subTitle: DateFormat.jm().format(quiz.endIn),
            svgUrl: 'assets/svgs/quiz_time.svg',
          ),
          _buildListTile(
            title: 'Time left',
            subTitle: quiz.time.toString(),
            svgUrl: 'assets/svgs/time_icon.svg',
          ),
          _buildListTile(
            title: 'Quiz Score',
            subTitle: quiz.degree.toString(),
            svgUrl: 'assets/svgs/quiz_score_icon.svg',
          ),
        ],
      );
    }

    Widget _buildStartQuizButton(BuildContext context, Quiz quiz) {
      if (!quiz.endIn.isBefore(DateTime.now()) &&
          quiz.startIn.isBefore(DateTime.now())) {
        return Column(
          children: [
            verticalSpace(24),
            BlocBuilder<StudentQuizCubit, StudentQuizState>(
              buildWhen: (previous, current) =>
                  current is IsShowStudentQuizLoadedState ||
                  current is IsShowStudentQuizLoadingState,
              builder: (context, state) {
                return _buildQuizButton(context, state);
              },
            ),
          ],
        );
      }
      return SizedBox.shrink();
    }

    Widget _buildQuizButton(BuildContext context, StudentQuizState state) {
      if (state is IsShowStudentQuizErrorState) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ToastNotificationMessage().showToastNotificationError(
            message: state.message,
            context: context,
          );
        });
        return SizedBox.shrink();
      }

      if (state is IsShowStudentQuizLoadingState) {
        // Automatically update the widget for loading state
        return SizedBox(
          width: 143.w,
          child: AppTextButton(
            buttonText: 'Please Wait...',
            textStyle: TextStyles.font10White400Weight,
            onPressed: () {},
          ),
        );
      }

      if (state is IsShowStudentQuizLoadedState) {
        return state.estimateQuiz.quizAttempts.isEmpty
            ? SizedBox(
                width: 143.w,
                child: AppTextButton(
                  buttonText: 'Start Quiz',
                  onPressed: () => showDialog(
                    context: context,
                    builder: (context) => AlertDialogWidget(
                      title: 'Start Quiz',
                      textButton: 'Start Quiz',
                      widget: Text(
                        'Do you really want to start quiz?',
                        textAlign: TextAlign.center,
                        style: TextStyles.font14Black400Weight,
                      ),
                      onTapButton: () {
                        context.pop();
                        context.pushNamed(Routes.showStudentQuizPage);
                      },
                    ),
                  ),
                ),
              )
            : SizedBox(
                width: 143.w,
                child: AppTextButton(
                  backgroundColor: ColorsManager.neutralGray,
                  textStyle: TextStyles.font10White400Weight,
                  buttonText: 'Not Rated',
                  onPressed: () {},
                ),
              );
      }

      return SizedBox(
        width: 143.w,
        child: AppTextButton(
          buttonText: 'Loading Questions...',
          textStyle: TextStyles.font10White400Weight,
          onPressed: () {},
        ),
      );
    }

    ListTile _buildListTile(
        {required String title,
        required String subTitle,
        required String svgUrl}) {
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

    BoxDecoration _buildBoxDecoration() {
      return BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            spreadRadius: 2,
            blurRadius: 4,
            color: ColorsManager.shadowColor.withOpacity(0.3),
          ),
        ],
      );
    }
  }
