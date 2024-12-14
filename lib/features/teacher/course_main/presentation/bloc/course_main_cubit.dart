import 'dart:ui';
import 'package:bloc/bloc.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/features/teacher/course_main/domain/entities/ads.dart';
import 'package:edu_sphere/features/teacher/course_main/domain/entities/chapter.dart';
import 'package:edu_sphere/features/teacher/course_main/domain/entities/lecture.dart';
import 'package:edu_sphere/features/teacher/course_main/domain/entities/quiz.dart';
import 'package:edu_sphere/features/teacher/teacher_main/data/model/courses_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
part 'course_main_state.dart';

class CourseMainCubit extends Cubit<CourseMainState> {
  late CoursesModel coursesModel;
  late int indexCourseInList;

  emitEditCourseDescription({required CoursesModel course}) {
    coursesModel = course;
    emit(EditCourseDescription(coursesModel: course));
  }

  Color colorSelectedTextField = ColorsManager.mainBlue;

  // Quize
  TextEditingController quizTitleTextEditionController =
      TextEditingController();
  TextEditingController quizTimeLiftTextEditionController =
      TextEditingController();
  TextEditingController quizQuizScoreTextEditionController =
      TextEditingController();
  TextEditingController quizDescriptionTextEditionController =
      TextEditingController();
  DateTime? selectedStartDateQuiz;
  DateTime? selectedEndDateQuiz;
  DateTime? startDateTimeQuiz;
  DateTime? endDateTimeQuiz;
  String? errorMessageQuiz;
  DateTime? startTime;
  DateTime? endTime;


  validateDateTimeQuiz() {
    if (selectedStartDateQuiz == null) {
      emit(ErrorMessageAddQuiz(message: 'Please Enter Start Date'));
      return false;
    }
    else if (selectedEndDateQuiz == null) {
      emit(ErrorMessageAddQuiz(message: 'Please Enter End Date'));
      return false;
    }
    else if (startTime == null) {
      emit(ErrorMessageAddQuiz(message: 'Please Enter Start Time'));
      return false;
    } else if (endTime == null) {
      emit(ErrorMessageAddQuiz(message: 'Please Enter End Time'));
      return false;
    }else if(selectedStartDateQuiz!.isBefore(DateTime.now())){
      emit(ErrorMessageAddQuiz(message: 'Selected date cannot be before the current date.'));
      return false;
    }
    else if(selectedEndDateQuiz!.isBefore(selectedStartDateQuiz!)){
      emit(ErrorMessageAddQuiz(message: 'end date cannot be before the start date'));
      return false;
    }
    else if(selectedStartDateQuiz != null&&selectedEndDateQuiz != null&&startTime != null&&endTime != null){
      TimeOfDay timeOfDayEnd = TimeOfDay.fromDateTime(endTime!);
      TimeOfDay timeOfDayStart = TimeOfDay.fromDateTime(startTime!);
      return validateEndTime(selectedStartDateQuiz!, timeOfDayStart, selectedEndDateQuiz!, timeOfDayEnd);
    } else if(endDateTimeQuiz!.isBefore(startDateTimeQuiz!)){
      emit(ErrorMessageAddQuiz(message: 'Start time or start date cannot be before the current date or time.'));

      return false;
    }else{
      return true;
    }
  }

// Function to validate the end Time
  bool? validateEndTime(DateTime startDate, TimeOfDay startTime, DateTime endDate, TimeOfDay endTime) {
    DateTime startDateTime = DateTime(
      startDate.year,
      startDate.month,
      startDate.day,
      startTime.hour,
      startTime.minute,
    );
    DateTime endDateTime = DateTime(
      endDate.year,
      endDate.month,
      endDate.day,
      endTime.hour,
      endTime.minute,
    );
    startDateTimeQuiz = startDateTime;
    endDateTimeQuiz = endDateTime;
    if (endDateTime.isBefore(startDateTime)) {
      emit(ErrorMessageAddQuiz(
          message: 'End time cannot be before start time.'));
      return false;
    }
    if (endDateTime.isAtSameMomentAs(startDateTime)) {
      emit(ErrorMessageAddQuiz(
          message: 'End time cannot be Same start time.'));
      return false;
    }
    isSuccessSelectDateTime = true;
    return true;
  }

  bool? isSuccessSelectDateTime;

// add Quiz
  List<Quiz> listQuiz = [];

  emitAddQuiz() {
    listQuiz.add(
      Quiz(
        quizTitle: quizTitleTextEditionController.text,
        description: quizDescriptionTextEditionController.text,
        passingScore: int.parse(quizQuizScoreTextEditionController.text),
        timeLift: int.parse(quizTimeLiftTextEditionController.text),
        startDateTime: startDateTimeQuiz!,
        endDateTime: endDateTimeQuiz!,
      ),
    );
    quizTitleTextEditionController = TextEditingController();

    quizTimeLiftTextEditionController = TextEditingController();

    quizQuizScoreTextEditionController = TextEditingController();

    quizDescriptionTextEditionController = TextEditingController();

    selectedStartDateQuiz = null;

    selectedEndDateQuiz = null;

    startDateTimeQuiz = null;

    endDateTimeQuiz = null;
    errorMessageQuiz = null;
    emit(GetAllQuiz(listQuiz: listQuiz));
  }

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
