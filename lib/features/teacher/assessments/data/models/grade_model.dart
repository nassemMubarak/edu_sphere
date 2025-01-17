import 'package:equatable/equatable.dart';

class Grade extends Equatable {
  final int id;
  final String gradeableType;
  final int gradeableId;
  final int result;
  final DateTime createdAt;
  final DateTime updatedAt;

  Grade({
    required this.id,
    required this.gradeableType,
    required this.gradeableId,
    required this.result,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Grade.fromJson(Map<String, dynamic> json) {
    return Grade(
      id: json['id'],
      gradeableType: json['gradeable_type'],
      gradeableId: json['gradeable_id'],
      result: json['result'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'gradeable_type': gradeableType,
      'gradeable_id': gradeableId,
      'result': result,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [id, gradeableType, gradeableId, result, createdAt, updatedAt];
}
