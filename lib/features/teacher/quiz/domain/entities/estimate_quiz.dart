import 'dart:convert';

class EstimateQuiz {
   int id;
   int quizId;
   DateTime createdAt;
   DateTime updatedAt;
   Student student;
   Grade grade;

  EstimateQuiz({
    required this.id,
    required this.quizId,
    required this.createdAt,
    required this.updatedAt,
    required this.student,
    required this.grade,
  });


}

class Student {
  final int id;
  final String name;
  final String email;
  final String? campId;
  final String sex;
  final String phoneNumber;
  final int age;
  final int level;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  Student({
    required this.id,
    required this.name,
    required this.email,
    this.campId,
    required this.sex,
    required this.phoneNumber,
    required this.age,
    required this.level,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      campId: json['camp_id']?.toString(),
      sex: json['sex'],
      phoneNumber: json['phone_number'],
      age: json['age'],
      level: json['level'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      deletedAt: json['deleted_at'] != null ? DateTime.parse(json['deleted_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'camp_id': campId,
      'sex': sex,
      'phone_number': phoneNumber,
      'age': age,
      'level': level,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
    };
  }
}

class Grade {
  final int id;
  final String gradeableType;
  final int gradeableId;
   int result;
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
}
