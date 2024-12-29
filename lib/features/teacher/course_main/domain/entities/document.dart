import 'package:equatable/equatable.dart';

class Document extends Equatable{
  final int id;
  final String documentableType;
  final int documentableId;
  final String? title;
  final String? description;
  final String type;
  final DateTime createdAt;
  final DateTime updatedAt;

  Document({
    required this.id,
    required this.documentableType,
    required this.documentableId,
    this.title,
    this.description,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
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
    updatedAt
  ];

}