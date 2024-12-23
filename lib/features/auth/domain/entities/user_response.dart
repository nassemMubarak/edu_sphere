import 'package:edu_sphere/features/auth/data/models/user_model.dart';
import 'package:edu_sphere/features/auth/domain/entities/user.dart';
import 'package:equatable/equatable.dart';

class UserResponse extends Equatable{
  final UserModel user;
  final String type;
  final String token;

  UserResponse({
    required this.user,
    required this.type,
    required this.token,
  });

  @override
  List<Object?> get props => [
    this.user,
    this.type,
    this.token
  ];


  }
