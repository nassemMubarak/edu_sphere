import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:edu_sphere/core/error/exception.dart';
import 'package:edu_sphere/core/helpers/shared_pref_helper.dart';
import 'package:edu_sphere/features/auth/data/models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<UserModel> getCurrentUser();

  Future<Unit> saveUser({required UserModel userModel});

  Future<Unit> saveToken({required String token});

  Future<String> getToken();

  Future<Unit> logout();
}

const CACHED_USER = 'CACHED_USER';
const CACHED_TOKEN = 'CACHED_TOKEN';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  @override
  Future<Unit> saveUser({required UserModel userModel}) async {
    await SharedPrefHelper.setData(
        CACHED_USER, json.encode(userModel.toJson()));
    return unit;
  }

  @override
  Future<UserModel> getCurrentUser() async {
    final jsonString = await SharedPrefHelper.getString(CACHED_USER);
    if (jsonString != null) {
      return Future.value(UserModel.fromJson(
        json.decode(jsonString),
      ));
    } else {
      throw EmptyCacheException();
    }
  }

  @override
  Future<Unit> saveToken({required String token}) async {
    await SharedPrefHelper.setData(CACHED_TOKEN, token);
    return unit;
  }

  @override
  Future<String> getToken() async {
    final token = await SharedPrefHelper.getString(CACHED_TOKEN);
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
