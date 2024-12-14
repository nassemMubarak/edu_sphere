part of 'course_main_cubit.dart';

@immutable
sealed class CourseMainState {}

final class CourseMainInitial extends CourseMainState {}

class ChangColorTextInTextField extends CourseMainState{
  final Color colorSelect;
  ChangColorTextInTextField({required this.colorSelect});
}
class ErrorMessageValidateEndDateQuiz extends CourseMainState{
  final String message;
  ErrorMessageValidateEndDateQuiz({required this.message});
}
class ErrorMessageValidateStartDateQuiz extends CourseMainState{
  final String message;
  ErrorMessageValidateStartDateQuiz({required this.message});
}
class ErrorMessageValidateEndTimeQuiz extends CourseMainState{
  final String message;
  ErrorMessageValidateEndTimeQuiz({required this.message});
}
class GetAllQuiz extends CourseMainState{
  List<Quiz> listQuiz;
  GetAllQuiz({required this.listQuiz});
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
  final CoursesModel coursesModel;
  EditCourseDescription({required this.coursesModel});

  }
