
import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/routing/routes.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/widgets/image_and_text_empty_data.dart';
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

import '../../../domain/entities/show_teacher_courses.dart';

class ShowLectureWidget extends StatelessWidget {
  ShowCourseTeacher? showCourseTeacher;
  ShowLectureWidget({super.key, this.showCourseTeacher});

  @override
  Widget build(BuildContext context) {
    return
          showCourseTeacher !=
          null &&
          showCourseTeacher!
              .lectures
              .isNotEmpty
          ? SectionCard(
        title: 'Lectures',
        icon: 'assets/svgs/video_lecture_icon.svg',
        widget: listViewLectureWidget(
            lectures: context
                .read<ShowCourseTeacherCubit>()
                .showCourseTeacher!
                .lectures),
      )
          : SectionCard(
        title: 'Lectures',
        icon: 'assets/svgs/video_lecture_icon.svg',
        widget: ImageAndTextEmptyData(
            message: 'There is no lectures yet'),
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
