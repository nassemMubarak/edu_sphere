import 'dart:ui';
import 'package:bloc/bloc.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/features/teacher/course_main/domain/entities/ads.dart';
import 'package:edu_sphere/features/teacher/course_main/domain/entities/chapter.dart';
import 'package:edu_sphere/features/teacher/course_main/domain/entities/lecture.dart';
import 'package:edu_sphere/features/teacher/quiz/domain/entities/quiz.dart';
import 'package:edu_sphere/features/teacher/quiz/presentation/bloc/quiz_cubit.dart';
import 'package:edu_sphere/features/teacher/teacher_main/data/model/courses_model.dart';
import 'package:edu_sphere/features/teacher/teacher_main/domain/entities/course.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'course_main_state.dart';

class CourseMainCubit extends Cubit<CourseMainState> {
  late Course coursesModel;
  late int indexCourseInList;

  emitEditCourseDescription({required Course course}) {
    coursesModel = course;
    emit(EditCourseDescription(coursesModel: course));
  }

  Color colorSelectedTextField = ColorsManager.mainBlue;


  TextEditingController adsTextEditionController = TextEditingController();
  TextEditingController lectureTitleTextEditionController =
      TextEditingController();
  TextEditingController lectureLinkTextEditionController =
      TextEditingController();
  TextEditingController lectureDescriptionTextEditionController =
      TextEditingController();
  final globalAdsKey = GlobalKey<FormState>();
  final globalLectureKey = GlobalKey<FormState>();

  List<Ads> listAds = [];
  List<Lecture> lectureList = [];
  List<Chapter> chapterList = [];

  CourseMainCubit() : super(CourseMainInitial());

  emitAddChapter({required List<Chapter> chapters}) {
    chapterList.addAll(chapters);
    emit(GetAllChapters(listChapter: chapterList));
  }

  emitDeleteChapter({required Chapter chapter}) {
    chapterList.remove(chapter);
    emit(GetAllChapters(listChapter: chapterList));
  }

  emitChangColorTextField({required Color color}) {
    colorSelectedTextField = color;
    emit(ChangColorTextInTextField(colorSelect: color));
  }

  String? extractYouTubeVideoId(String url) {
    final RegExp videoIdPattern = RegExp(
      r'^(?:https?:\/\/)?(?:www\.)?(?:youtube\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?)\/|\S*?[?&]v=)|youtu\.be\/)([a-zA-Z0-9_-]{11})',
      caseSensitive: false,
    );

    final Match? match = videoIdPattern.firstMatch(url);
    return match != null ? match.group(1) : null;
  }

  emitAddLecture() {
    lectureList.add(
      Lecture(
        title: lectureTitleTextEditionController.text,
        description: lectureDescriptionTextEditionController.text,
        lectureLink:
            extractYouTubeVideoId(lectureLinkTextEditionController.text)!,
      ),
    );
    emit(GetAllLecture(lectures: lectureList));
    lectureTitleTextEditionController = TextEditingController();
    lectureDescriptionTextEditionController = TextEditingController();
    lectureLinkTextEditionController = TextEditingController();
  }

  emitEditLecture(int index) {
    lectureList[index].title = lectureTitleTextEditionController.text;
    lectureList[index].description =
        lectureDescriptionTextEditionController.text;
    lectureList[index].lectureLink =
        extractYouTubeVideoId(lectureLinkTextEditionController.text)!;
    emit(GetAllLecture(lectures: lectureList));
    lectureTitleTextEditionController = TextEditingController();
    lectureDescriptionTextEditionController = TextEditingController();
    lectureLinkTextEditionController = TextEditingController();
  }

  emitDeleteLecture({required int index}) {
    lectureList.remove(lectureList[index]);
    emit(GetAllLecture(lectures: lectureList));
  }

  emitAddAds() {
    listAds.add(Ads(
        colorText: colorSelectedTextField,
        text: adsTextEditionController.text));
    emit(GetAllAds(listAds: listAds));
    adsTextEditionController = TextEditingController();
    colorSelectedTextField = ColorsManager.mainBlue;
  }

  emitEditAds({required int index}) {
    listAds[index].text = adsTextEditionController.text;
    listAds[index].colorText = colorSelectedTextField;
    emit(GetAllAds(listAds: listAds));
    adsTextEditionController = TextEditingController();
    colorSelectedTextField = ColorsManager.mainBlue;
  }

  emitDeleteAds({required int index}) {
    listAds.remove(listAds[index]);
    emit(GetAllAds(listAds: listAds));
  }
}
