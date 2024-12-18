import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/routing/routes.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/widgets/image_and_text_empty_data.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/bloc/course_main_cubit.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/widgets/lecture_widgets/add_lectures_dilog.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/widgets/lecture_widgets/delete_lecture_info_dialog.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/widgets/lecture_widgets/edit_lectures_dilog.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/widgets/section_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class LecturesWidget extends StatelessWidget {
  LecturesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: 'Lectures',
      icon: 'assets/svgs/video_lecture_icon.svg',
      infoDialog: const AddLecturesDilog(),
      widget: BlocBuilder<CourseMainCubit, CourseMainState>(
        builder: (context, state) {
          if (state is GetAllLecture) {
            if (state.lectures.isNotEmpty) {
              return listViewLectureWidget(state);
            } else {
              return  ImageAndTextEmptyData(
                message: 'You have not added any Lectures yet.',
              );
            }
          } else {
            return  ImageAndTextEmptyData(
              message: 'You have not added any Lectures yet.',
            );
          }
        },
      ),
    );
  }

  ListView listViewLectureWidget(GetAllLecture state) {
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsetsDirectional.only(
          top: 24.h, bottom: 40.h, end: 16.w, start: 16.w),
      shrinkWrap: true,
      itemBuilder: (context, index) => lectureWidgetShowDetailes(
        context,
        url: state.lectures[index].lectureLink,
        title: state.lectures[index].title,
        description: state.lectures[index].description,
        index: index,
      ),
      separatorBuilder: (context, index) =>
          const Divider(color: ColorsManager.neutralGray),
      itemCount: state.lectures.length,
    );
  }

  Container lectureWidgetShowDetailes(BuildContext context,
      {required String title,
        required String url,
      required String description,
      required int index,
      }) {
    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: 'GJ4TqV156Qg',
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: true,
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
              const Spacer(),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => EditLecturesDilog(index: index),
                  );
                },
                child: SvgPicture.asset('assets/svgs/edite_icon.svg',
                    color: ColorsManager.neutralGray),
              ),
              horizontalSpace(8),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) =>
                        DeleteLectureInfoDialog(indexLecture: index),
                  );
                },
                child: SvgPicture.asset(
                  'assets/svgs/delete_icon.svg',
                  color: ColorsManager.neutralGray,
                ),
              ),
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
                  onTap: (){
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
