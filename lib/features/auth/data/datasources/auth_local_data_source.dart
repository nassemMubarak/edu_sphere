import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:edu_sphere/core/error/exception.dart';
import 'package:edu_sphere/core/helpers/constants.dart';
import 'package:edu_sphere/core/helpers/shared_pref_helper.dart';
import 'package:edu_sphere/features/auth/data/models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<UserModel> getCurrentUser();

  Future<Unit> saveUser({required UserModel userModel});

  Future<Unit> saveToken({required String token});

  Future<String> getToken();

  Future<Unit> logout();
}


class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  @override
  Future<Unit> saveUser({required UserModel userModel}) async {
    await SharedPrefHelper.setData(
        SharedPrefKeys.cachedUser, json.encode(userModel.toJson()));
    return unit;
  }

  @override
  Future<UserModel> getCurrentUser() async {
    String jsonString = await SharedPrefHelper.getString(SharedPrefKeys.cachedUser);
    if (jsonString.isNotEmpty) {
      return Future.value(UserModel.fromJson(
        json.decode(jsonString),
      ));
    } else {
      throw EmptyCacheException();
    }
  }

  @override
  Future<Unit> saveToken({required String token}) async {
    await SharedPrefHelper.setData(SharedPrefKeys.cachedToken, token);
    return unit;
  }

  @override
  Future<String> getToken() async {
    final token = await SharedPrefHelper.getString(SharedPrefKeys.cachedToken);
    if (token != null) {
      return token;
    } else {
      throw EmptyCacheException();
    }
  }

  @override
  Future<Unit> logout() {
    SharedPrefHelper.clearAllData();
    return Future.value(unit);
  }
}
