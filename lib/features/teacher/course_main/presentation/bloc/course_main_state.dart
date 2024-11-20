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
