import 'package:equatable/equatable.dart';

/// User model representing authenticated user data
/// 
/// This model is used across the app to represent user information
class UserModel extends Equatable {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final String? avatar;
  
  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.avatar,
  });
  
  /// Create UserModel from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String?,
      avatar: json['avatar'] as String?,
    );
  }
  
  /// Convert UserModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'avatar': avatar,
    };
  }
  
  /// Create a copy with updated fields
  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? avatar,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      avatar: avatar ?? this.avatar,
    );
  }
  
  @override
  List<Object?> get props => [id, name, email, phone, avatar];
  
  @override
  String toString() => 'UserModel(id: $id, name: $name, email: $email)';
}

