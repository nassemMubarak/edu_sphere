import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:edu_sphere/core/error/exception.dart';
import 'package:edu_sphere/core/helpers/constants.dart';
import 'package:edu_sphere/core/helpers/shared_pref_helper.dart';
import 'package:edu_sphere/features/teacher/course_main/data/models/advertisement_model.dart';
import 'package:logger/logger.dart';

abstract class CourseMainLocalDataSource {
  // Future<List<AdvertisementModel>> getAllAdvertisement();
  // Future<Unit> saveAdvertisements({required List<AdvertisementModel> listAdvertisementModels});
}
class CourseMainLocalDataSourceImpl implements CourseMainLocalDataSource{
  // @override
  // Future<List<AdvertisementModel>> getAllAdvertisement() async{
  //   try {
  //     // Ensure you await the result from SharedPrefHelper.getStringList
  //     List<String>? jsonString = await SharedPrefHelper.getStringList(SharedPrefKeys.cachedAdvertisement);
  //     Logger().d('Retrieved Advertisement: $jsonString');
  //     if (jsonString != null && jsonString.isNotEmpty) {
  //       // Decode JSON into a list of CourseModel objects
  //       return _decodeAdvertisement(jsonString);
  //     } else {
  //       throw EmptyCacheException();
  //     }
  //   } catch (e) {
  //     throw EmptyCacheException();
  //   }
  // }
  //
  // @override
  // Future<Unit> saveAdvertisements({required List<AdvertisementModel> listAdvertisementModels}) async{
  //   try {
  //     // Encode the list of CourseModel objects to JSON
  //     List<String> advertisementJson = _encodeAdvertisement(listAdvertisementModels);
  //     Logger().t('Advertisement to save: $advertisementJson');
  //
  //     // Save the JSON list to SharedPreferences
  //     await SharedPrefHelper.setStringList(SharedPrefKeys.cachedAdvertisement, advertisementJson);
  //     return unit;
  //   } catch (e) {
  //     Logger().e('Error saving Advertisement: $e');
  //   }
  //   return unit;
  // }
  // // Helper method to encode courses to JSON
  // List<String> _encodeAdvertisement(List<AdvertisementModel> listAdvertisement) {
  //   return listAdvertisement.map((advertisement) => json.encode(advertisement.toJson())).toList();
  // }
  //
  // // Helper method to decode JSON to CourseModel objects
  // List<AdvertisementModel> _decodeAdvertisement(List<String> jsonString) {
  //   return jsonString
  //       .map((advertisementJson) => AdvertisementModel.fromJson(json.decode(advertisementJson)))
  //       .toList();
  // }
}