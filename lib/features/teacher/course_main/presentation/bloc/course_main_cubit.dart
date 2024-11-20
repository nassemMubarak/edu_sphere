import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/features/teacher/course_main/domain/entities/ads.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'course_main_state.dart';

class CourseMainCubit extends Cubit<CourseMainState> {
  Color colorSelectedTextField = ColorsManager.mainBlue;
  TextEditingController adsTextEditionController = TextEditingController();
  final globalAdsKey = GlobalKey<FormState>();
  List<Ads> listAds = [];
  CourseMainCubit() : super(CourseMainInitial());

  emitChangColorTextField({required Color color}){
    colorSelectedTextField = color;
    emit(ChangColorTextInTextField(colorSelect: color));
  }
  emitAddAds(){
    listAds.add(Ads(colorText: colorSelectedTextField, text: adsTextEditionController.text));
    emit(GetAllAds(listAds: listAds));
    adsTextEditionController = TextEditingController();
    colorSelectedTextField = ColorsManager.mainBlue;
  }
  emitEditAds({required int index}){
    listAds[index].text = adsTextEditionController.text;
    listAds[index].colorText = colorSelectedTextField;
    emit(GetAllAds(listAds: listAds));
    adsTextEditionController = TextEditingController();
    colorSelectedTextField = ColorsManager.mainBlue;
  }
  emitDeleteAds({required int index}){
   listAds.remove(listAds[index]);
    emit(GetAllAds(listAds: listAds));

  }
}
