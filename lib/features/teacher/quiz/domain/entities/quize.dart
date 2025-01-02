import 'package:equatable/equatable.dart';
class Quize extends Equatable{
   int id;
   String title;
   String description;
   int courseId;
   String degree;
   String time;
   int visibility;
   DateTime startIn; // DateTime instead of String
   DateTime endIn; // DateTime instead of String
   String? createdAt; // Nullable
   String? updatedAt; // Nullable
   int? resultVisible; // Optional field (nullable)
  Quize({
    required this.id,
    required this.title,
    required this.description,
    required this.time,
    required this.degree,
    required this.visibility,
    required this.startIn,
    required this.endIn,
    required this.courseId,
     this.createdAt,
     this.updatedAt,
    this.resultVisible
  });
  @override
  List<Object?> get props => [
   id,
    title,
    description,
    time,
    degree,
    visibility,
    startIn,
    endIn,
    courseId,
    createdAt,
    updatedAt,
    resultVisible

  ];
}