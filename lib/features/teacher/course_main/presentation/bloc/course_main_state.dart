part of 'course_main_cubit.dart';

@immutable
sealed class CourseMainState {}

final class CourseMainInitial extends CourseMainState {}

class ChangColorTextInTextField extends CourseMainState{
  final Color colorSelect;
  ChangColorTextInTextField({required this.colorSelect});
}

  class GetAllAds extends CourseMainState{
  final List<Ads> listAds;
  GetAllAds({required this.listAds});
  }
  class GetAllChapters extends CourseMainState{
    final List<Chapter> listChapter;
    GetAllChapters({required this.listChapter});
  }
  class GetAllLecture extends CourseMainState{
  final List<Lecture> lectures;
  GetAllLecture({required this.lectures});

  }
  class EditCourseDescription extends CourseMainState{
  final Course coursesModel;
  EditCourseDescription({required this.coursesModel});

  }
