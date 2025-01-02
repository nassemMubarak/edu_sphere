import 'package:equatable/equatable.dart';

class DocumentQuestion extends Equatable {
  final int id;
  final String documentableType;
  final int documentableId;
  final String? title; // Nullable
  final String? description; // Nullable
  final String type;
  final DateTime? createdAt; // Nullable
  final DateTime? updatedAt; // Nullable
  final String url;

  DocumentQuestion({
    required this.id,
    required this.documentableType,
    required this.documentableId,
    this.title,
    this.description,
    required this.type,
    this.createdAt,
    this.updatedAt,
    required this.url,
  });

  @override
  List<Object?> get props => [
    id,documentableType,documentableId,title,description,type,createdAt,updatedAt,url
  ];
}