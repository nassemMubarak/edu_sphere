class RequestModel {
  final int id;
  final String requestableType;
  final int requestableId;
  final String type;
  final RequestDataModel data;
  final String createdAt;
  final String updatedAt;
  final RequestableModel requestable;

  RequestModel({
    required this.id,
    required this.requestableType,
    required this.requestableId,
    required this.type,
    required this.data,
    required this.createdAt,
    required this.updatedAt,
    required this.requestable,
  });

  factory RequestModel.fromJson(Map<String, dynamic> json) {
    return RequestModel(
      id: json['id'],
      requestableType: json['requestable_type'],
      requestableId: json['requestable_id'],
      type: json['type'],
      data: RequestDataModel.fromJson(json['data']),
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      requestable: RequestableModel.fromJson(json['requestable']),
    );
  }
}

class RequestDataModel {
  final String model;
  final int userId;
  final int campId;

  RequestDataModel({
    required this.model,
    required this.userId,
    required this.campId,
  });

  factory RequestDataModel.fromJson(Map<String, dynamic> json) {
    return RequestDataModel(
      model: json['model'],
      userId: json['user_id'],
      campId: json['camp_id'],
    );
  }
}

class RequestableModel {
  final int id;
  final String name;
  final String email;
  final String? specialization;
  final String sex;
  final String phoneNumber;
  final int age;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;
  final String? campName;
  final String? status;
  final int? level; // For Student level

  RequestableModel({
    required this.id,
    required this.name,
    required this.email,
    this.specialization,
    required this.sex,
    required this.phoneNumber,
    required this.age,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.campName,
    this.status,
    this.level, // For Student
  });

  factory RequestableModel.fromJson(Map<String, dynamic> json) {
    return RequestableModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      specialization: json['specialization'],
      sex: json['sex'],
      phoneNumber: json['phone_number'] ?? '',
      age: json['age'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],
      campName: json['camp_name'],
      status: json['status'],
      level: json['level'], // For Student level
    );
  }
}
