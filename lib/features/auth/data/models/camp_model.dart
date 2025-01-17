import 'package:edu_sphere/features/auth/domain/entities/camp.dart';

class CampModel extends Camp{
  CampModel({required super.id, required super.name, required super.location, required super.createdAt, required super.updatedAt,super.deletedAt});
  factory CampModel.fromJson(Map<String, dynamic> json) {
    return CampModel(
      id: json['id'],
      name: json['name'],
      location: json['location'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      deletedAt: json['deleted_at'] != null ? DateTime.parse(json['deleted_at']) : null,
    );
  }

  // Method to convert a Camp instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
    };
  }
}