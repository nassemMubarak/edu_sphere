import 'package:edu_sphere/features/teacher/course_main/domain/entities/document.dart';
import 'package:equatable/equatable.dart';

class Lecture extends Equatable{
   int id;
   String title;
   String description;
   String link; // Renamed from content to link
   int courseId;
   DateTime? createdAt; // Made optional
   DateTime? updatedAt; // Made optional
  Lecture({
    required this.id,
    required this.title,
    required this.description,
    required this.link,
    required this.courseId,
    this.createdAt, // Optional
    this.updatedAt, // Optional
  });

  @override
  // TODO: implement props
  List<Object?> get props =>[
    id,title,description,link,courseId,createdAt,updatedAt
  ];

  
}

