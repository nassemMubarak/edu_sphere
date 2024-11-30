import 'package:edu_sphere/features/auth/domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.id,
    required super.name,
    required super.email,
    required super.age,
    required super.sex,
    required super.phoneNumber,
    required super.level,
    required super.updatedAt,
    required super.createdAt,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      age: int.parse(json['age']), // Assuming age is a String in the JSON
      sex: json['sex'],
      phoneNumber: json['phone_number'],
      level: json['level'],
      updatedAt: DateTime.parse(json['updated_at']),
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'age': age.toString(), // Convert age back to String if needed
      'sex': sex,
      'phone_number': phoneNumber,
      'level': level,
      'updated_at': updatedAt.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
    };
  }
}
