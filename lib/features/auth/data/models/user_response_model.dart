import 'package:edu_sphere/features/auth/data/models/user_model.dart';
import 'package:edu_sphere/features/auth/domain/entities/user.dart';
import 'package:edu_sphere/features/auth/domain/entities/user_response.dart';
import 'package:equatable/equatable.dart';

class UserResponseModel extends UserResponse{
  UserResponseModel({required super.user, required super.type, required super.token});
  // Factory method to create a UserResponse instance from JSON
  factory UserResponseModel.fromJson(Map<String, dynamic> json) {
    return UserResponseModel(
      user: UserModel.fromJson(json['user']),
      type: json['type'].toString(),
      token: json['token'],
    );
  }

  // Method to convert a UserResponse instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'type': type,
      'token': token,
    };
  }
  }
