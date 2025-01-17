import 'package:edu_sphere/features/teacher/assessments/domain/entities/document_assessment.dart';
import 'package:equatable/equatable.dart';

class Assessment extends Equatable{
   int id;
   String assignmentableType;
   int assignmentableId;
   String title;
   String description;
   String? type;
   int degree;
   bool visibility;
   DateTime startIn;
   DateTime endIn;
   String? relatedTo;
   DateTime? createdAt;
   DateTime? updatedAt;
   List<DocumentAssessment>? documents;

  Assessment({
    required this.id,
    required this.assignmentableType,
    required this.assignmentableId,
    required this.title,
    required this.description,
    this.type,
    required this.degree,
    required this.visibility,
    required this.startIn,
    required this.endIn,
    this.relatedTo,
    this.createdAt,
    this.updatedAt,
    this.documents,
  });

   @override
   List<Object?> get props => [
     id,
     assignmentableType,
     assignmentableId,
     title,
     description,
     type,
     degree,
     visibility,
     startIn,
     endIn,
     relatedTo,
     createdAt,
     updatedAt,
     documents,
   ];

}

