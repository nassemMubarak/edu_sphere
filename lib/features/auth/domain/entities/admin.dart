import 'package:equatable/equatable.dart';
class Admin extends Equatable {
  final String name;
  final String email;
  final String sex;
  final String phoneNumber;
  final String age;
  final String updatedAt;
  final String createdAt;
  final int id;
  final int subscriptionPlanId;
  final SubscriptionPlan subscriptionPlan;

  Admin({
    required this.name,
    required this.email,
    required this.sex,
    required this.phoneNumber,
    required this.age,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
    required this.subscriptionPlanId,
    required this.subscriptionPlan,
  });


  @override
  List<Object?> get props => [
    name,
    email,
    sex,
    phoneNumber,
    age,
    updatedAt,
    createdAt,
    id,
    subscriptionPlanId,
    subscriptionPlan,
  ];
}

class SubscriptionPlan extends Equatable {
  final int id;
  final String name;
  final int teachers;
  final int students;
  final String createdAt;
  final String updatedAt;
  final int price;

  SubscriptionPlan({
    required this.id,
    required this.name,
    required this.teachers,
    required this.students,
    required this.createdAt,
    required this.updatedAt,
    required this.price,
  });

  // Factory constructor to create an instance from a map
  factory SubscriptionPlan.fromJson(Map<String, dynamic> json) {
    return SubscriptionPlan(
      id: json['id'],
      name: json['name'],
      teachers: json['teachers'],
      students: json['students'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      price: json['price'],
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    teachers,
    students,
    createdAt,
    updatedAt,
    price,
  ];
}

