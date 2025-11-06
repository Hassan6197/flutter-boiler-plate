import 'package:equatable/equatable.dart';

/// Login request model
/// 
/// This model represents the data sent to the API for login
class LoginRequestModel extends Equatable {
  final String email;
  final String password;
  
  const LoginRequestModel({
    required this.email,
    required this.password,
  });
  
  /// Convert to JSON for API request
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
  
  @override
  List<Object?> get props => [email, password];
  
  @override
  String toString() => 'LoginRequestModel(email: $email)';
}

