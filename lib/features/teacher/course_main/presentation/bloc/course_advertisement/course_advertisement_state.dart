part of 'course_advertisement_cubit.dart';

@immutable
sealed class CourseAdvertisementState {}

final class CourseAdvertisementInitial extends CourseAdvertisementState {}
class GetAllAdvertisementLoadingState extends CourseAdvertisementState{}
class AddOrUpdateOrDeleteLoadingState extends CourseAdvertisementState{}
class GetAllAdvertisementLoadedState extends CourseAdvertisementState{
  final List<Advertisement> advertisement;

  GetAllAdvertisementLoadedState({required this.advertisement});

  @override
  List<Object> get props => [advertisement];
}
class AdvertisementAddOrUpdateOrDeleteSuccessState extends CourseAdvertisementState{
  final String message;

  AdvertisementAddOrUpdateOrDeleteSuccessState({required this.message});

  @override
  List<Object> get props => [message];
}
class AdvertisementMessageErrorState extends CourseAdvertisementState{
  final String message;

  AdvertisementMessageErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
class ChangColorTextInTextField extends CourseAdvertisementState{
  final Color colorSelect;
  ChangColorTextInTextField({required this.colorSelect});
}


