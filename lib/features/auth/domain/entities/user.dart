import 'package:equatable/equatable.dart';

class User extends Equatable {
   int id;
   String name;
   String email;
   String? specialization; // Nullable for Teacher
   String sex;
   String phoneNumber; // Matches JSON key "phone_number"
   int age; // Updated to int to match JSON
   int? campId; // Nullable for Student
   int? level; // Nullable for Student
   DateTime createdAt;
   DateTime updatedAt;
   String? deletedAt; // Nullable
   String? campName; // Nullable for Student
   String? status; // Nullable for Student
   String type; // User type (e.g., Teacher, Student)
   String token; // Authentication token
   String? imageUrl;
   String? role;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.specialization,
    required this.sex,
    required this.phoneNumber,
    required this.age,
    this.campId,
    this.level,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.campName,
    this.status,
    required this.type,
    required this.token,
    this.imageUrl,
    this.role,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    email,
    specialization,
    sex,
    phoneNumber,
    age,
    campId,
    level,
    createdAt,
    updatedAt,
    deletedAt,
    campName,
    status,
    type,
    token,
    imageUrl,
    role,
  ];
}
