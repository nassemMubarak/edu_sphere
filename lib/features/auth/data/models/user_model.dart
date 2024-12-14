import 'package:edu_sphere/features/auth/domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.name,
     super.specialization,
    required super.email,
    required super.age,
    required super.sex,
    required super.phoneNumber,
     super.level,
    required super.updatedAt,
    required super.createdAt,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      age: json['age'], // Assuming age is a String in the JSON
      sex: json['sex'],
      phoneNumber: json['phone_number'],
      level: json['level'],
      specialization: json['specialization'],
      updatedAt: DateTime.parse(json['updated_at']),
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'age': age.toString(), // Convert age back to String if needed
      'sex': sex,
      'specialization': specialization,
      'phone_number': phoneNumber,
      'level': level,
      'updated_at': updatedAt.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
    };
  }
}
