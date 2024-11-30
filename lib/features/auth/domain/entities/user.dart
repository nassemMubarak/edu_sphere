import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String name;
  final String email;
  final int age;
  final String sex;
  final String phoneNumber;
  final int level;
  final DateTime updatedAt;
  final DateTime createdAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.age,
    required this.sex,
    required this.phoneNumber,
    required this.level,
    required this.updatedAt,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        age,
        sex,
        phoneNumber,
        level,
        updatedAt,
        createdAt,
      ];
}
