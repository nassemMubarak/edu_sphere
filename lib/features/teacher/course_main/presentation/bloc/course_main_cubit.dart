import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/features/teacher/course_main/domain/entities/ads.dart';
import 'package:edu_sphere/features/teacher/course_main/domain/entities/lecture.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'course_main_state.dart';

class CourseMainCubit extends Cubit<CourseMainState> {
  Color colorSelectedTextField = ColorsManager.mainBlue;
  // Quize
   TextEditingController quizeTitleTextEditionController =
      TextEditingController();
  TextEditingController quizeDescriptionTextEditionController =
      TextEditingController();


  TextEditingController adsTextEditionController = TextEditingController();
  TextEditingController lectureTitleTextEditionController =
      TextEditingController();
  TextEditingController lectureLinkTextEditionController =
      TextEditingController();
  TextEditingController lectureDescriptionTextEditionController =
      TextEditingController();
  final globalAdsKey = GlobalKey<FormState>();
  final globalLectureKey = GlobalKey<FormState>();
  final globalQuizeKey = GlobalKey<FormState>();
  List<Ads> listAds = [];
  List<Lecture> lectureList = [];
  CourseMainCubit() : super(CourseMainInitial());

  emitChangColorTextField({required Color color}) {
    colorSelectedTextField = color;
    emit(ChangColorTextInTextField(colorSelect: color));
  }

  emitAddLecture() {
    lectureList.add(
      Lecture(
        title: lectureTitleTextEditionController.text,
        description: lectureDescriptionTextEditionController.text,
        lectureLink: lectureLinkTextEditionController.text,
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
    lectureList[index].lectureLink = lectureLinkTextEditionController.text;
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
