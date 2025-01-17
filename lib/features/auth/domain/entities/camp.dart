import 'package:equatable/equatable.dart';

class Camp extends Equatable{
  final int id;
  final String name;
  final String location;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  Camp({
    required this.id,
    required this.name,
    required this.location,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  @override
  List<Object?> get props => [id,name,location,createdAt,updatedAt,deletedAt];

}