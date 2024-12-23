import 'package:edu_sphere/core/theming/colors.dart';
import 'package:flutter/material.dart';

extension Navigation on BuildContext {
  Future<dynamic> pushNamed(String routName, {Object? argument}) {
    return Navigator.of(this).pushNamed(routName, arguments: argument);
  }

  Future<dynamic> pushReplacementNamed(String routName, {Object? argument}) {
    return Navigator.of(this)
        .pushReplacementNamed(routName, arguments: argument);
  }

  Future<dynamic> pushNamedAndRemoveUntil(String routName, {Object? argument,required RoutePredicate predicate}) {
    return Navigator.of(this)
        .pushNamedAndRemoveUntil(routName,predicate, arguments: argument);
  }

  void pop() => Navigator.of(this).pop();

  void loading()=>showDialog(
      barrierColor: ColorsManager.neutralGray.withOpacity(0.5),
      barrierDismissible: false,
      context: this, builder: (context) => const AlertDialog(
    backgroundColor: Colors.transparent,
    title: Center(
      child: SizedBox(
        height: 30,
        width: 30,
        child: CircularProgressIndicator(),
      ),
    ),
  ));
}


