import 'package:equatable/equatable.dart';

class Course extends Equatable{
   int id;
   String title;
   String description;
   int? teacherId;
   DateTime? createdAt;
   DateTime? updatedAt;
   String? deletedAt; // Nullable field
   String? type;
  bool isPending=false;
  bool isRejected=false;
  Course({
  required this.id,
  required this.title,
  required this.description,
  this.teacherId,
  this.createdAt,
  this.updatedAt,
  this.deletedAt,
  this.type,
  this.isPending=false,
  this.isRejected=false
  });
  @override
  List<Object?> get props => [
  id,
  title,
  description,
  teacherId,
  createdAt,
  updatedAt,
  deletedAt,
  type,
  isPending,
  isRejected
  ];


}