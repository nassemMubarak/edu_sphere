import 'package:edu_sphere/features/communication/domain/entities/communication.dart';

class CommunicationModel extends Communication {
  CommunicationModel({
    required super.id,
    required super.name,
    required super.type,
    required super.content,
     super.teacherId,
    required super.createdAt,
    required super.updatedAt,
  });
  // Factory method to create a Communication object from JSON
  factory CommunicationModel.fromJson(Map<String, dynamic> json) {
    return CommunicationModel(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      content: json['content'],
      teacherId: json['teacher_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }


}
