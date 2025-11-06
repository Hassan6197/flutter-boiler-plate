import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc_boilerplate/core/errors/api_exceptions.dart';

/// API Client for making HTTP requests
/// 
/// This is a simple implementation for demonstration.
/// In production, consider using packages like dio or http.
/// 
/// This client simulates API calls with dummy data for the boilerplate.
class ApiClient {
  final String baseUrl;
  final Duration timeout;
  
  ApiClient({
    required this.baseUrl,
    this.timeout = const Duration(seconds: 30),
  });
  
  /// Common headers for all requests
  Map<String, String> get _headers => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
  
  /// POST request
  /// 
  /// Example usage:
  /// ```dart
  /// final response = await apiClient.post('/auth/login', body: {
  ///   'email': 'user@example.com',
  ///   'password': 'password123'
  /// });
  /// ```
  Future<Map<String, dynamic>> post(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 2));
      
      // Combine default headers with custom headers
      final requestHeaders = {..._headers, ...?headers};
      
      print('📤 POST Request: $baseUrl$endpoint');
      print('📦 Body: ${jsonEncode(body)}');
      print('📋 Headers: $requestHeaders');
      
      // Handle different endpoints with dummy responses
      if (endpoint.contains('/auth/login')) {
        return _handleLoginRequest(body);
      }
      
      // Default response for other endpoints
      return {
        'success': true,
        'message': 'Request successful',
        'data': {}
      };
    } on TimeoutException {
      throw TimeoutException('Request timeout');
    } catch (e) {
      throw ServerException('Error making POST request: $e');
    }
  }
  
  /// GET request
  /// 
  /// Example usage:
  /// ```dart
  /// final response = await apiClient.get('/users/profile');
  /// ```
  Future<Map<String, dynamic>> get(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      
      final requestHeaders = {..._headers, ...?headers};
      
      print('📤 GET Request: $baseUrl$endpoint');
      print('📋 Headers: $requestHeaders');
      if (queryParameters != null) {
        print('🔍 Query Parameters: $queryParameters');
      }
      
      return {
        'success': true,
        'message': 'Request successful',
        'data': {}
      };
    } on TimeoutException {
      throw TimeoutException('Request timeout');
    } catch (e) {
      throw ServerException('Error making GET request: $e');
    }
  }
  
  /// PUT request
  Future<Map<String, dynamic>> put(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      
      final requestHeaders = {..._headers, ...?headers};
      
      print('📤 PUT Request: $baseUrl$endpoint');
      print('📦 Body: ${jsonEncode(body)}');
      
      return {
        'success': true,
        'message': 'Request successful',
        'data': {}
      };
    } catch (e) {
      throw ServerException('Error making PUT request: $e');
    }
  }
  
  /// DELETE request
  Future<Map<String, dynamic>> delete(
    String endpoint, {
    Map<String, String>? headers,
  }) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      
      final requestHeaders = {..._headers, ...?headers};
      
      print('📤 DELETE Request: $baseUrl$endpoint');
      
      return {
        'success': true,
        'message': 'Request successful',
        'data': {}
      };
    } catch (e) {
      throw ServerException('Error making DELETE request: $e');
    }
  }
  
  // ============================================
  // DUMMY API RESPONSES
  // ============================================
  
  /// Handle login request with dummy response
  /// 
  /// This simulates a real API login endpoint
  /// 
  /// Success credentials:
  /// - Email: test@example.com
  /// - Password: password123
  /// 
  /// Any other credentials will return an error
  Map<String, dynamic> _handleLoginRequest(Map<String, dynamic>? body) {
    if (body == null) {
      throw ValidationException('Request body is required');
    }
    
    final email = body['email'] as String?;
    final password = body['password'] as String?;
    
    // Validate required fields
    if (email == null || email.isEmpty) {
      throw ValidationException('Email is required', {'email': ['Email field is required']});
    }
    
    if (password == null || password.isEmpty) {
      throw ValidationException('Password is required', {'password': ['Password field is required']});
    }
    
    // Simulate successful login with specific credentials
    if (email == 'test@example.com' && password == 'password123') {
      print('✅ Login successful for: $email');
      
      return {
        'success': true,
        'message': 'Login successful',
        'data': {
          'user': {
            'id': 'user_12345',
            'name': 'John Doe',
            'email': email,
            'phone': '+1234567890',
            'avatar': 'https://via.placeholder.com/150',
          },
          'token': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.dummy_token_here',
          'refreshToken': 'refresh_token_dummy_12345',
        }
      };
    }
    
    // Simulate invalid credentials
    print('❌ Login failed for: $email');
    throw UnauthorizedException('Invalid email or password');
  }
}
