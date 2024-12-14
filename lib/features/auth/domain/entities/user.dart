import 'package:equatable/equatable.dart';

class User extends Equatable {
  String name;
  String email;
  String age;
  String sex;
  String phoneNumber;
  String? specialization;
  String? level;
  DateTime updatedAt;
  DateTime createdAt;

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
        updatedAt,
        createdAt,
      ];
}
