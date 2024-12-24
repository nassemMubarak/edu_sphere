import 'package:equatable/equatable.dart';

class Advertisement extends Equatable{
   int id;
   int courseId;
   String text;
   String color;
   DateTime? createdAt;
   DateTime? updatedAt;
   Advertisement({
     required this.id,
     required this.courseId,
     required this.text,
     required this.color,
     this.createdAt,
     this.updatedAt,
   });

  @override
  List<Object?> get props => [
    id,
    courseId,
    text,
    color,
    createdAt,
    updatedAt


  ];
}