import 'package:edu_sphere/features/auth/domain/entities/user.dart';
import 'package:logger/logger.dart';

class UserModel extends User {
  UserModel({
    required super.name,
    super.specialization,
    required super.email,
    required super.age,
    required super.sex,
    required super.phoneNumber,
    super.level,
     super.updatedAt,
     super.createdAt,
    super.imageUrl,
    required super.token,
    super.campId,
    super.campName,
    super.deletedAt,
    required super.id,
    super.status,
    required super.type,
    super.role,
  });

  // Factory method to create a UserModel from a JSON Map (with logging)
  factory UserModel.fromJsonUpdate(Map<String, dynamic> json) {
    Logger().e('--------------------------------$json'); // Log the JSON for debugging
    return UserModel(
      id: json['id'] ?? 0,
      name: json['name']??'',
      email: json['email']??'',
      specialization: json['specialization'],
      sex: json['sex']??'',
      phoneNumber: json['phone_number'] ?? '', // Handle missing field
      age: json['age']??0,
      campId: json['camp_id'],
      level:json['level']==null?null:int.parse(json['level'].toString()),
      createdAt:json['created_at']==null?null: DateTime.parse(json['created_at']),
      updatedAt: json['updated_at']==null?null:DateTime.parse(json['updated_at']),
      deletedAt: json['deleted_at'],
      campName: json['camp_name'],
      status: json['status'],
      type: json['type']??'',
      token: json['token']??'',
      imageUrl: json['image_url'],
      role: json['role'],
    );
  }

  // Factory method to create a UserModel from a JSON Map
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['user']['id'],
      name: json['user']['name'],
      email: json['user']['email'],
      specialization: json['user']['specialization'],
      sex: json['user']['sex'],
      phoneNumber: json['user']['phone_number'] ?? '', // Handle missing field
      age: int.parse((json['user']['age']).toString()),
      campId: json['user']['camp_id'],
      level: json['user']['level']==null?null:int.parse(json['user']['level'].toString()),
      createdAt: DateTime.parse(json['user']['created_at']),
      updatedAt: DateTime.parse(json['user']['updated_at']),
      deletedAt: json['user']['deleted_at'],
      campName: json['user']['camp_name'],
      status: json['user']['status'],
      type: json['type']??'',
      token: json['token'] ?? '',
      imageUrl: json['user']['image_url'],
      role: json['user']['role'],
    );
  }

  // Method to create a copy of the UserModel with updated fields
  UserModel copyWith({
    int? id,
    String? name,
    String? email,
    String? specialization,
    String? sex,
    String? phoneNumber,
    String? age,
    int? campId,
    int? level,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? deletedAt,
    String? campName,
    String? status,
    String? type,
    String? token,
    String? imageUrl,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      specialization: specialization ?? this.specialization,
      sex: sex ?? this.sex,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      age: age==null?this.age:int.parse(age),
      campId: campId ?? this.campId,
      level: level ?? this.level,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      campName: campName ?? this.campName,
      status: status ?? this.status,
      type: type ?? this.type,
      token: token ?? this.token,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  // Method to convert UserModel object to JSON
  Map<String, dynamic> toJson() {
    return {
      'user': {
        'id': id,
        'name': name,
        'email': email,
        'specialization': specialization,
        'sex': sex,
        'phone_number': phoneNumber,
        'age': age,
        'camp_id': campId,
        'level': level,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'deleted_at': deletedAt,
        'camp_name': campName,
        'status': status,
        'image_url': imageUrl,
      },
      'type': type,
      'token': token,
    };
  }
}