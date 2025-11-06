/// Custom exceptions for API operations
/// 
/// These exceptions help distinguish between different types of errors
/// that can occur during API calls, making error handling more precise.

/// Base class for all API-related exceptions
class ApiException implements Exception {
  final String message;
  final int? statusCode;
  
  ApiException(this.message, [this.statusCode]);
  
  @override
  String toString() => 'ApiException: $message${statusCode != null ? ' (Status: $statusCode)' : ''}';
}

/// Thrown when server returns an error (5xx)
/// 
/// Example: 500 Internal Server Error, 503 Service Unavailable
class ServerException extends ApiException {
  ServerException([String message = 'Server error occurred', int? statusCode])
      : super(message, statusCode);
  
  @override
  String toString() => 'ServerException: $message${statusCode != null ? ' (Status: $statusCode)' : ''}';
}

/// Thrown when there's a network connectivity issue
/// 
/// Example: No internet connection, timeout
class NetworkException extends ApiException {
  NetworkException([String message = 'Network error occurred'])
      : super(message);
  
  @override
  String toString() => 'NetworkException: $message';
}

/// Thrown when authentication fails (401)
/// 
/// Example: Invalid credentials, token expired
class UnauthorizedException extends ApiException {
  UnauthorizedException([String message = 'Unauthorized access', int? statusCode = 401])
      : super(message, statusCode);
  
  @override
  String toString() => 'UnauthorizedException: $message';
}

/// Thrown when request validation fails (400)
/// 
/// Example: Missing required fields, invalid email format
class ValidationException extends ApiException {
  final Map<String, dynamic>? errors;
  
  ValidationException([
    String message = 'Validation error',
    this.errors,
    int? statusCode = 400,
  ]) : super(message, statusCode);
  
  @override
  String toString() {
    if (errors != null && errors!.isNotEmpty) {
      return 'ValidationException: $message - Errors: $errors';
    }
    return 'ValidationException: $message';
  }
}

/// Thrown when resource is not found (404)
class NotFoundException extends ApiException {
  NotFoundException([String message = 'Resource not found', int? statusCode = 404])
      : super(message, statusCode);
  
  @override
  String toString() => 'NotFoundException: $message';
}

/// Thrown when request timeout occurs
class TimeoutException extends ApiException {
  TimeoutException([String message = 'Request timeout'])
      : super(message);
  
  @override
  String toString() => 'TimeoutException: $message';
}

