import 'package:edu_sphere/features/auth/domain/entities/admin.dart';

class AdminModel extends Admin {
  AdminModel({
    required super.name,
    required super.email,
    required super.sex,
    required super.phoneNumber,
    required super.age,
    required super.updatedAt,
    required super.createdAt,
    required super.id,
    required super.subscriptionPlanId,
    required super.subscriptionPlan,
  });
  // Factory constructor to create an instance from a map
  factory AdminModel.fromJson(Map<String, dynamic> json) {
    return AdminModel(
      name: json['name'],
      email: json['email'],
      sex: json['sex'],
      phoneNumber: json['phone_number'],
      age: json['age'],
      updatedAt: json['updated_at'],
      createdAt: json['created_at'],
      id: json['id'],
      subscriptionPlanId: json['subscription_plan_id'],
      subscriptionPlan: SubscriptionPlan.fromJson(json['subscription_plan']),
    );
  }
}
