import 'package:equatable/equatable.dart';

class DocumentAssessment extends Equatable {
   int id;
   String documentableType;
   int documentableId;
   String? title;
   String? description;
   String type;
   DateTime? createdAt;
   DateTime? updatedAt;

   DocumentAssessment({
    required this.id,
    required this.documentableType,
    required this.documentableId,
    this.title,
    this.description,
    required this.type,
    this.createdAt,
    this.updatedAt,
  });


  @override
  List<Object?> get props => [
    id,
    documentableType,
    documentableId,
    title,
    description,
    type,
    createdAt,
    updatedAt,
  ];
}
