import 'package:equatable/equatable.dart';

class Communication extends Equatable {
  final int id;
  final String name;
  final String type;
   String content;
   int? teacherId;
  final DateTime createdAt;
  final DateTime updatedAt;

   Communication({
    required this.id,
    required this.name,
    required this.type,
    required this.content,
     this.teacherId,
    required this.createdAt,
    required this.updatedAt,
  });


  @override
  List<Object?> get props => [
    id,
    name,
    type,
    content,
    teacherId,
    createdAt,
    updatedAt,
  ];
}
