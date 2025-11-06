import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_boilerplate/data/models/auth/user_model.dart';

/// Login response model
/// 
/// This model represents the data received from the API after successful login
class LoginResponseModel extends Equatable {
  final bool success;
  final String message;
  final LoginData? data;
  
  const LoginResponseModel({
    required this.success,
    required this.message,
    this.data,
  });
  
  /// Create LoginResponseModel from JSON
  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String? ?? '',
      data: json['data'] != null 
          ? LoginData.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }
  
  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data?.toJson(),
    };
  }
  
  @override
  List<Object?> get props => [success, message, data];
  
  @override
  String toString() => 'LoginResponseModel(success: $success, message: $message)';
}

/// Login data containing user and token
class LoginData extends Equatable {
  final UserModel user;
  final String token;
  final String? refreshToken;
  
  const LoginData({
    required this.user,
    required this.token,
    this.refreshToken,
  });
  
  /// Create LoginData from JSON
  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      token: json['token'] as String,
      refreshToken: json['refreshToken'] as String?,
    );
  }
  
  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'token': token,
      'refreshToken': refreshToken,
    };
  }
  
  @override
  List<Object?> get props => [user, token, refreshToken];
  
  @override
  String toString() => 'LoginData(user: ${user.name}, token: ${token.substring(0, 10)}...)';
}

