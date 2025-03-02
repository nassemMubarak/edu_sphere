import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/routing/routes.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/widgets/courses_shimmer_widget.dart';
import 'package:edu_sphere/core/widgets/image_and_text_empty_data.dart';
import 'package:edu_sphere/features/student/student_main/presentations/bloc/student_lecture/student_lecture_cubit.dart';
import 'package:edu_sphere/features/student/student_main/presentations/bloc/subscribe_student_courses/subscribe_student_courses_cubit.dart';
import 'package:edu_sphere/features/teacher/course_main/domain/entities/lecture.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/bloc/course_lecture/course_lecture_cubit.dart';
import 'package:edu_sphere/core/widgets/shimmer_loading_lecture.dart';
import 'package:edu_sphere/features/teacher/teacher_main/presentation/widgets/show_message_pinding_or_rejected_course_info_dialog.dart';
import 'package:edu_sphere/features/teacher/teacher_main/presentation/widgets/titel_and_icon_list_taile_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:edu_sphere/l10n/app_localizations.dart';
import 'package:edu_sphere/features/teacher/teacher_main/presentation/widgets/section_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../../core/theming/colors.dart';
class StudentLectureWidget extends StatelessWidget {
  int idCourse;
   StudentLectureWidget({super.key,required this.idCourse});

  @override
  Widget build(BuildContext context) {
    context.read<StudentLectureCubit>().emitGetAllStudentLecturesLoadingState(idCourse: idCourse);
    return BlocBuilder<StudentLectureCubit,StudentLectureState>(
      builder: (context, state) {
        if(state is GetAllStudentLecturesLoadingState){
          return ShimmerLoadingLecture();
        }else if(state is GetAllStudentLecturesLoadedState){
          return state.lecture.isNotEmpty?SectionCard(
              title: 'Lectures',
              icon: 'assets/svgs/video_lecture_icon.svg',
              widget: listViewLectureWidget(state.lecture)
          ):SectionCard(
            title: AppLocalizations.of(context)!.yourCourses,
            icon: 'assets/svgs/courses_icon.svg',
            widget: ImageAndTextEmptyData(
                message: AppLocalizations.of(context)!.noCoursesAdded),
          );
        }else{
          return context.read<StudentLectureCubit>().lectureList.isNotEmpty?
          SectionCard(
              title: 'Lectures',
              icon: 'assets/svgs/video_lecture_icon.svg',
              widget: listViewLectureWidget(context.read<StudentLectureCubit>().lectureList)
          )
              :SectionCard(
            title: 'Lectures',
            icon: 'assets/svgs/video_lecture_icon.svg',
            widget: ImageAndTextEmptyData(
                message: AppLocalizations.of(context)!.noCoursesAdded),
          );
        }
      },
    );
    //   SectionCard(
    //   title: AppLocalizations.of(context)!.yourCourses,
    //   icon: 'assets/svgs/courses_icon.svg',
    //   widget: ImageAndTextEmptyData(
    //     message: AppLocalizations.of(context)!.noCoursesAdded),
    // );
  }
  ListView listViewLectureWidget(List<Lecture> lectures) {
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
      const Divider(color: ColorsManager.neutralGray),
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
