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
}
