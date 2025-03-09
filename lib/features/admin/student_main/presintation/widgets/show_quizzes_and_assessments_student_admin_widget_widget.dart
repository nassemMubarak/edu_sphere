
import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/routing/routes.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/widgets/image_and_text_empty_data.dart';
import 'package:edu_sphere/features/admin/student_main/data/model/student_information_model.dart';
import 'package:edu_sphere/features/admin/teacher_admin/presintation/bloc/show_courrse_teacher/show_course_teacher_cubit.dart';
import 'package:edu_sphere/features/teacher/course_main/domain/entities/lecture.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/bloc/course_lecture/course_lecture_cubit.dart';
import 'package:edu_sphere/features/teacher/teacher_main/presentation/widgets/section_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


class ShowQuizzesAndAssessmentsStudentAdminWidgetWidget extends StatelessWidget {
  StudentInformationModel? studentInformationModel;
  ShowQuizzesAndAssessmentsStudentAdminWidgetWidget({super.key, this.studentInformationModel});

  @override
  Widget build(BuildContext context) {
    return
      studentInformationModel !=
          null&&(studentInformationModel!.quizAttempts.isNotEmpty||studentInformationModel!.assignments.isNotEmpty)?
           SectionCard(
        title: 'Your Quizzes & Assessment',
        icon: 'assets/svgs/quiz_on_computer_question_icon.svg',
        widget: Column(
          children: [
            ListView.builder(
              itemCount: studentInformationModel!.quizAttempts.length,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) => ListTile(
                onTap: (){
                },
                contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                leading: SvgPicture.asset('assets/svgs/quiz_leading_icon.svg'),
                title: Text('Quiz $index',style: TextStyles.font14Black500Weight),
              trailing: Text(studentInformationModel!.quizAttempts[index].grade!=null?studentInformationModel!.quizAttempts[index].grade.result.toString():'Not Grade',style:studentInformationModel!.quizAttempts[index].grade!=null?TextStyles.font14Black400Weight: TextStyles.font14NeutralGray400Weight),
              ),
            ),
            ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: studentInformationModel!.assignments.length,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) => ListTile(
                onTap: (){
                },
                contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                leading: SvgPicture.asset('assets/svgs/annual_assessment_icon.svg'),
                title: Text('${studentInformationModel!.assignments[index].title??'assessment $index'}',style: TextStyles.font14Black500Weight),
                trailing: Text('${studentInformationModel!.assignments[index].grade!=null?studentInformationModel!.assignments[index].grade!.result.toString():'Not Gradeed'}',style: studentInformationModel!.assignments[index].grade!=null?TextStyles.font14Black400Weight: TextStyles.font14NeutralGray400Weight,),
              ),
            ),
          ],
        ),
      )
          : SectionCard(
        title: 'Your Quizzes & Assessment',
        icon: 'assets/svgs/quiz_on_computer_question_icon.svg',
        widget: ImageAndTextEmptyData(
            message: 'You have not added any Quizzes & Ass yet.'),
      );
  }
  /// lecture
  ListView listViewLectureWidget({required List<Lecture> lectures}) {
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsetsDirectional.only(
          top: 24.h, bottom: 40.h, end: 16.w, start: 16.w),
      shrinkWrap: true,
      itemBuilder: (context, index) =>
          lectureWidgetShowDetailes(
              context,
              url:YoutubePlayer.convertUrlToId(lectures[index].link)!,
              title: lectures[index].title,
              description: lectures[index].description,
              index: index,
              idLecture: lectures[index].id
          ),
      separatorBuilder: (context, index) =>
          Divider(color: ColorsManager.neutralGray),
      itemCount: lectures.length,
    );
  }
  Container lectureWidgetShowDetailes(BuildContext context,
      {required String title,
        required int idLecture,
        required String url,
        required String description,
        required int index,
      }) {
    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: url,
      flags: YoutubePlayerFlags(
        autoPlay: false,
      ),
    );
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpace(24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(
                'assets/svgs/video_icon.svg',
                height: 24.h,
                width: 24.w,
              ),
              horizontalSpace(8),
              Container(
                  alignment: AlignmentDirectional.bottomStart,
                  width: 0.5.sw,
                  child: Text(title, style: TextStyles.font16Black500Weight)),
            ],
          ),
          verticalSpace(8),
          Text(
            description,
            style: TextStyles.font12Black400Weight,
            textAlign: TextAlign.start,
          ),
          verticalSpace(16),
          Container(
            child: Stack(
              children: [
                YoutubePlayer(
                  controller: _controller,
                  showVideoProgressIndicator: true,
                  progressIndicatorColor: Colors.amber,
                  progressColors: const ProgressBarColors(
                    playedColor: Colors.amber,
                    handleColor: Colors.amberAccent,
                  ),
                  onReady: () {
                    // _controller.addListener(listener);
                  },

                ),
                GestureDetector(
                  onTap: () {
                    context.read<CourseLectureCubit>().linkVideo = url;
                    context.pushNamed(Routes.showVideoWidget);
                  },
                  child: Container(
                    color: Colors.transparent,
                    height: 162,
                    width: double.infinity,
                  ),
                ),
              ],
            ),
          ),
          // Image.asset('assets/images/lecture_image.png'),
          verticalSpace(16),
        ],
      ),
    );
  }
}
