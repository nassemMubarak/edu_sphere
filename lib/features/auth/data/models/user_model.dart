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
    super.imageUrl,
    super.type, // Nullable type
    required super.token,
  });

  // Method to convert from JSON to UserModel object
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['user']['name'],
      email: json['user']['email'],
      age: json['user']['age'].toString(), // Ensure age is a string
      sex: json['user']['sex'],
      phoneNumber: json['user']['phone_number'],
      specialization: json['user']['specialization'],
      updatedAt: DateTime.parse(json['user']['updated_at']),
      createdAt: DateTime.parse(json['user']['created_at']),
      type: json['type'], // Nullable type
      token: json['token'], // Add 'token' here
    );
  }
  // CopyWith method to modify certain fields (e.g., type)
  UserModel copyWith({
    String? name,
    String? email,
    String? age,
    String? sex,
    String? phoneNumber,
    String? specialization,
    String? level,
    DateTime? updatedAt,
    DateTime? createdAt,
    String? type,
    String? token,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      age: age ?? this.age,
      sex: sex ?? this.sex,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      specialization: specialization ?? this.specialization,
      level: level ?? this.level,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
      type: type ?? this.type, // Ensure type is updated if provided
      token: token ?? this.token,
    );
  }

  // Method to convert UserModel object to JSON
  Map<String, dynamic> toJson() {
    return {
      'user': {
        'name': name,
        'email': email,
        'age': age,
        'sex': sex,
        'phone_number': phoneNumber,
        'specialization': specialization,
        'updated_at': updatedAt.toIso8601String(),
        'created_at': createdAt.toIso8601String(),
      },
      'type': type, // Nullable type
      'token': token, // Add 'token' here
    };
  }
}
