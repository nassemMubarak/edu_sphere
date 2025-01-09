import 'package:equatable/equatable.dart';

class User extends Equatable {
  String name;
  String email;
  String age;
  String sex;
  String phoneNumber;
  String? specialization;
  String? level;
  String? imageUrl; // URL field for image
  DateTime updatedAt;
  DateTime createdAt;
  String? type; // Nullable user type (e.g., Teacher, Student)
  String token;

  User({
    required this.name,
    required this.email,
    required this.age,
    required this.sex,
    required this.phoneNumber,
    this.level,
    required this.updatedAt,
    required this.createdAt,
    this.specialization,
    this.imageUrl,
    this.type, // Nullable type
    required this.token,
  });

  @override
  List<Object?> get props => [
    name,
    specialization,
    email,
    age,
    sex,
    phoneNumber,
    level,
    imageUrl,
    updatedAt,
    createdAt,
    type,
    token,
  ];
}
