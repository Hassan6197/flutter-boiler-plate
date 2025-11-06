import 'package:flutter_bloc_boilerplate/core/errors/api_exceptions.dart';
import 'package:flutter_bloc_boilerplate/core/network/network_info.dart';
import 'package:flutter_bloc_boilerplate/data/apiClient/api_client.dart';
import 'package:flutter_bloc_boilerplate/data/models/auth/login_request_model.dart';
import 'package:flutter_bloc_boilerplate/data/models/auth/login_response_model.dart';

/// Authentication Repository
/// 
/// Handles all authentication-related operations including login, logout, etc.
/// This repository follows the repository pattern, acting as a mediator
/// between the data layer (API) and the business logic layer (BLoC).
/// 
/// Dependencies are injected through constructor for testability.
class AuthRepository {
  final ApiClient apiClient;
  final NetworkInfo networkInfo;
  
  AuthRepository({
    required this.apiClient,
    required this.networkInfo,
  });
  
  /// Login with email and password
  /// 
  /// Returns [LoginResponseModel] on success
  /// Throws appropriate exceptions on failure:
  /// - [NetworkException] when no internet connection
  /// - [UnauthorizedException] when credentials are invalid
  /// - [ValidationException] when request validation fails
  /// - [ServerException] when server error occurs
  /// 
  /// Example usage:
  /// ```dart
  /// try {
  ///   final response = await authRepository.login(
  ///     email: 'test@example.com',
  ///     password: 'password123',
  ///   );
  ///   print('Logged in as: ${response.data?.user.name}');
  /// } on UnauthorizedException {
  ///   print('Invalid credentials');
  /// } on NetworkException {
  ///   print('No internet connection');
  /// }
  /// ```
  Future<LoginResponseModel> login({
    required String email,
    required String password,
  }) async {
    // Check internet connectivity first
    final isConnected = await networkInfo.isConnected();
    if (!isConnected) {
      throw NetworkException('No internet connection');
    }
    
    try {
      // Create request model
      final request = LoginRequestModel(
        email: email,
        password: password,
      );
      
      // Make API call
      final response = await apiClient.post(
        '/api/auth/login',
        body: request.toJson(),
      );
      
      // Parse response
      final loginResponse = LoginResponseModel.fromJson(response);
      
      // Store token if needed (example)
      if (loginResponse.success && loginResponse.data != null) {
        // You can store the token in SharedPreferences here
        // await _storeAuthToken(loginResponse.data!.token);
        print('🔐 Token received: ${loginResponse.data!.token.substring(0, 20)}...');
      }
      
      return loginResponse;
    } on ApiException {
      // Re-throw API exceptions as-is
      rethrow;
    } catch (e) {
      // Catch any other errors and wrap them
      throw ServerException('Unexpected error during login: $e');
    }
  }
  
  /// Logout the current user
  /// 
  /// Clears stored authentication data
  Future<void> logout() async {
    try {
      // Clear stored token
      // await _clearAuthToken();
      
      // Optionally call logout API endpoint
      // await apiClient.post('/api/auth/logout');
      
      print('👋 User logged out successfully');
    } catch (e) {
      print('⚠️ Error during logout: $e');
      // Don't throw error on logout failure - just clear local data
    }
  }
  
  /// Check if user is authenticated
  /// 
  /// Returns true if valid auth token exists
  Future<bool> isAuthenticated() async {
    // In a real app, check if valid token exists
    // final token = await _getAuthToken();
    // return token != null && !_isTokenExpired(token);
    return false;
  }
  
  /// Get current user info
  /// 
  /// Returns user data if authenticated
  Future<dynamic> getCurrentUser() async {
    final isAuth = await isAuthenticated();
    if (!isAuth) {
      throw UnauthorizedException('User not authenticated');
    }
    
    // In a real app, fetch user data from API or local storage
    // final response = await apiClient.get('/api/auth/me');
    // return UserModel.fromJson(response['data']);
    
    return null;
  }
  
  // Example: Store auth token (implement with SharedPreferences)
  // Future<void> _storeAuthToken(String token) async {
  //   await PrefUtils().setString('auth_token', token);
  // }
  
  // Example: Get auth token
  // Future<String?> _getAuthToken() async {
  //   return await PrefUtils().getString('auth_token');
  // }
  
  // Example: Clear auth token
  // Future<void> _clearAuthToken() async {
  //   await PrefUtils().remove('auth_token');
  // }
}

