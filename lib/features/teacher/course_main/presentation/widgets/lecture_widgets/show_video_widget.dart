import 'package:edu_sphere/features/teacher/course_main/presentation/bloc/course_lecture/course_lecture_cubit.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class ShowVideoWidget extends StatelessWidget {
  ShowVideoWidget({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    final YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: context.read<CourseLectureCubit>().linkVideo, // Replace with a valid YouTube video ID
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,

      ),
    );
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.black,
          alignment: Alignment.center,
          height: 1.sh,
          child: Column(
            children: [
              const Spacer(),
              YoutubePlayerBuilder(

                player: YoutubePlayer(
                  onReady: () {},
                  controller: _controller,
                ),
                builder: (context, player) {
                  return Column(
                    children: [
                      player, // YouTube player widget
                      const SizedBox(height: 16), // Add spacing for better UI
                      Text(
                        "Playing video...",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                        ),
                      ),
                    ],
                  );
                },
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

  // @override
  // Widget build(BuildContext context) {
  //   final _controller = YoutubePlayerController.fromVideoId(
  //     videoId: 'GJ4TqV156Qg',
  //     autoPlay: false,
  //     params: const YoutubePlayerParams(showFullscreenButton: true),
  //   );
  //
  //     return Scaffold(
  //       body: Center(
  //         child: YoutubePlayer(
  //           controller: _controller,
  //           aspectRatio: 16 / 9,
  //         ),
  //       ),
  //     );
  //   }
  // }
/*

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.black,
          alignment: Alignment.center,
          height: 1.sh,
          child: Column(
            children: [
              const Spacer(),
              YoutubePlayerBuilder(

                player: YoutubePlayer(
                  onReady: (){
                  },
                  controller: _controller,
                ),
                builder: (context, player) {
                  return Column(
                    children: [
                      player, // YouTube player widget
                      const SizedBox(height: 16), // Add spacing for better UI
                      Text(
                        "Playing video...",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                        ),
                      ),
                    ],
                  );
                },
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
 */