# API Integration Guide

Complete guide for integrating REST APIs in this Flutter boilerplate.

## Table of Contents
- [Overview](#overview)
- [API Client](#api-client)
- [Making API Calls](#making-api-calls)
- [Error Handling](#error-handling)
- [Repository Pattern](#repository-pattern)
- [Complete Example](#complete-example)
- [Testing API Calls](#testing-api-calls)
- [Best Practices](#best-practices)

## Overview

This boilerplate uses a clean architecture approach for API integration:

```
UI (Widget) → BLoC → Repository → API Client → Server
```

### Key Components:

1. **API Client** (`lib/data/apiClient/api_client.dart`) - Handles HTTP requests
2. **Repository** (`lib/data/repositories/`) - Business logic and data transformation
3. **Models** (`lib/data/models/`) - Request/Response data structures
4. **BLoC** (`lib/presentation/*/bloc/`) - State management and UI logic

## API Client

The API Client handles all HTTP communications.

### Configuration

```dart
// lib/core/di/injection_container.dart
locator.registerSingleton<ApiClient>(
  ApiClient(
    baseUrl: 'https://api.example.com', // Your API base URL
    timeout: const Duration(seconds: 30),
  ),
);
```

### Available Methods

```dart
// GET request
final response = await apiClient.get('/users/profile');

// POST request
final response = await apiClient.post('/auth/login', body: {
  'email': 'user@example.com',
  'password': 'password123'
});

// PUT request
final response = await apiClient.put('/users/profile', body: {
  'name': 'John Doe'
});

// DELETE request
final response = await apiClient.delete('/users/account');
```

### Custom Headers

```dart
final response = await apiClient.post(
  '/api/endpoint',
  body: {...},
  headers: {
    'Authorization': 'Bearer $token',
    'Custom-Header': 'value',
  },
);
```

## Making API Calls

### Step 1: Create Request/Response Models

```dart
// lib/data/models/auth/login_request_model.dart
class LoginRequestModel {
  final String email;
  final String password;
  
  const LoginRequestModel({
    required this.email,
    required this.password,
  });
  
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}

// lib/data/models/auth/login_response_model.dart
class LoginResponseModel {
  final bool success;
  final String message;
  final LoginData? data;
  
  const LoginResponseModel({
    required this.success,
    required this.message,
    this.data,
  });
  
  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: json['data'] != null 
          ? LoginData.fromJson(json['data'])
          : null,
    );
  }
}
```

### Step 2: Create Repository

```dart
// lib/data/repositories/auth_repository.dart
class AuthRepository {
  final ApiClient apiClient;
  final NetworkInfo networkInfo;
  
  AuthRepository({
    required this.apiClient,
    required this.networkInfo,
  });
  
  Future<LoginResponseModel> login({
    required String email,
    required String password,
  }) async {
    // Check internet connectivity
    final isConnected = await networkInfo.isConnected();
    if (!isConnected) {
      throw NetworkException('No internet connection');
    }
    
    try {
      // Create request
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
      return LoginResponseModel.fromJson(response);
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ServerException('Unexpected error: $e');
    }
  }
}
```

### Step 3: Use in BLoC

```dart
// lib/presentation/login_screen/bloc/login_bloc.dart
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;
  
  LoginBloc({required this.authRepository}) : super(LoginInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }
  
  Future<void> _onLoginButtonPressed(
    LoginButtonPressed event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    
    try {
      final response = await authRepository.login(
        email: event.email,
        password: event.password,
      );
      
      if (response.success) {
        emit(LoginSuccess(user: response.data!.user));
      } else {
        emit(LoginError(message: response.message));
      }
    } on UnauthorizedException {
      emit(LoginError(message: 'Invalid credentials'));
    } on NetworkException {
      emit(LoginError(message: 'No internet connection'));
    } catch (e) {
      emit(LoginError(message: 'An error occurred'));
    }
  }
}
```

## Error Handling

### Custom Exceptions

The boilerplate includes several custom exceptions:

```dart
// lib/core/errors/api_exceptions.dart

// Server errors (5xx)
throw ServerException('Server error', 500);

// Network errors
throw NetworkException('No internet connection');

// Authentication errors (401)
throw UnauthorizedException('Invalid credentials');

// Validation errors (400)
throw ValidationException('Invalid input', {
  'email': ['Email is required']
});

// Not found (404)
throw NotFoundException('Resource not found');

// Timeout errors
throw TimeoutException('Request timeout');
```

### Handling in Repository

```dart
Future<UserModel> getUser(String id) async {
  try {
    final response = await apiClient.get('/users/$id');
    return UserModel.fromJson(response['data']);
  } on NotFoundException {
    throw NotFoundException('User not found');
  } on NetworkException {
    throw NetworkException('Cannot connect to server');
  } on ApiException catch (e) {
    throw ServerException('Error: ${e.message}');
  }
}
```

### Handling in BLoC

```dart
Future<void> _onLoadUser(LoadUser event, Emitter emit) async {
  emit(UserLoading());
  
  try {
    final user = await repository.getUser(event.userId);
    emit(UserLoaded(user: user));
  } on NotFoundException {
    emit(UserError(message: 'User not found'));
  } on NetworkException {
    emit(UserError(message: 'Check your internet connection'));
  } on ApiException catch (e) {
    emit(UserError(message: e.message));
  }
}
```

## Repository Pattern

### Why Use Repositories?

1. **Separation of Concerns**: BLoC doesn't know about API details
2. **Testability**: Easy to mock repositories
3. **Flexibility**: Can switch data sources (API, local DB, cache)
4. **Consistency**: Centralized data access logic

### Repository Interface (Optional but Recommended)

```dart
// Define interface
abstract class UserRepository {
  Future<UserModel> getProfile();
  Future<void> updateProfile(UserModel user);
  Future<void> deleteAccount();
}

// Implement
class UserRepositoryImpl implements UserRepository {
  final ApiClient apiClient;
  
  UserRepositoryImpl({required this.apiClient});
  
  @override
  Future<UserModel> getProfile() async {
    final response = await apiClient.get('/user/profile');
    return UserModel.fromJson(response['data']);
  }
  
  @override
  Future<void> updateProfile(UserModel user) async {
    await apiClient.put('/user/profile', body: user.toJson());
  }
  
  @override
  Future<void> deleteAccount() async {
    await apiClient.delete('/user/account');
  }
}
```

## Complete Example

Let's add a feature to fetch user profile.

### 1. Create Models

```dart
// lib/data/models/user/user_profile_response.dart
class UserProfileResponse {
  final bool success;
  final UserModel user;
  
  factory UserProfileResponse.fromJson(Map<String, dynamic> json) {
    return UserProfileResponse(
      success: json['success'],
      user: UserModel.fromJson(json['data']),
    );
  }
}
```

### 2. Add Repository Method

```dart
// lib/data/repositories/user_repository.dart
class UserRepository {
  final ApiClient apiClient;
  
  UserRepository({required this.apiClient});
  
  Future<UserProfileResponse> getProfile() async {
    try {
      final response = await apiClient.get('/api/user/profile');
      return UserProfileResponse.fromJson(response);
    } on ApiException {
      rethrow;
    }
  }
  
  Future<void> updateProfile({
    required String name,
    required String phone,
  }) async {
    await apiClient.put('/api/user/profile', body: {
      'name': name,
      'phone': phone,
    });
  }
}
```

### 3. Register in DI

```dart
// lib/core/di/injection_container.dart
locator.registerSingleton<UserRepository>(
  UserRepository(apiClient: locator<ApiClient>()),
);

locator.registerFactory<ProfileBloc>(
  () => ProfileBloc(userRepository: locator<UserRepository>()),
);
```

### 4. Create BLoC

```dart
// lib/presentation/profile/bloc/profile_bloc.dart
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepository userRepository;
  
  ProfileBloc({required this.userRepository}) : super(ProfileInitial()) {
    on<LoadProfile>(_onLoadProfile);
    on<UpdateProfile>(_onUpdateProfile);
  }
  
  Future<void> _onLoadProfile(
    LoadProfile event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());
    
    try {
      final response = await userRepository.getProfile();
      emit(ProfileLoaded(user: response.user));
    } on NetworkException {
      emit(ProfileError(message: 'No internet connection'));
    } on ApiException catch (e) {
      emit(ProfileError(message: e.message));
    }
  }
  
  Future<void> _onUpdateProfile(
    UpdateProfile event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileUpdating());
    
    try {
      await userRepository.updateProfile(
        name: event.name,
        phone: event.phone,
      );
      // Reload profile
      add(LoadProfile());
    } on ApiException catch (e) {
      emit(ProfileError(message: e.message));
    }
  }
}
```

### 5. Use in UI

```dart
// lib/presentation/profile/profile_screen.dart
static Widget builder(BuildContext context) {
  return BlocProvider<ProfileBloc>(
    create: (context) => locator<ProfileBloc>()..add(LoadProfile()),
    child: ProfileScreen(),
  );
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return Center(child: CircularProgressIndicator());
        }
        
        if (state is ProfileLoaded) {
          return _buildProfile(state.user);
        }
        
        if (state is ProfileError) {
          return Center(child: Text(state.message));
        }
        
        return SizedBox.shrink();
      },
    ),
  );
}
```

## Testing API Calls

### Mock Repository

```dart
import 'package:mockito/mockito.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  late ProfileBloc bloc;
  late MockUserRepository repository;
  
  setUp(() {
    repository = MockUserRepository();
    bloc = ProfileBloc(userRepository: repository);
  });
  
  test('loads profile successfully', () async {
    // Arrange
    final user = UserModel(id: '1', name: 'John');
    when(repository.getProfile())
        .thenAnswer((_) async => UserProfileResponse(
          success: true,
          user: user,
        ));
    
    // Act
    bloc.add(LoadProfile());
    
    // Assert
    await expectLater(
      bloc.stream,
      emitsInOrder([
        ProfileLoading(),
        ProfileLoaded(user: user),
      ]),
    );
  });
}
```

## Best Practices

### ✅ DO

1. **Use models** for request/response data
2. **Handle all error cases** in repository
3. **Check network connectivity** before API calls
4. **Use async/await** for cleaner code
5. **Log API calls** during development
6. **Validate data** before sending

```dart
// Good
Future<LoginResponse> login(LoginRequest request) async {
  if (!await networkInfo.isConnected()) {
    throw NetworkException();
  }
  
  try {
    final response = await apiClient.post('/login', body: request.toJson());
    return LoginResponse.fromJson(response);
  } on ApiException {
    rethrow;
  }
}
```

### ❌ DON'T

1. **Don't make API calls directly in BLoC**
2. **Don't ignore error handling**
3. **Don't use dynamic everywhere**
4. **Don't hardcode URLs in repository**

```dart
// Bad
Future<void> login() async {
  final response = await http.post('https://api.com/login'); // Direct call
  final data = jsonDecode(response.body); // No error handling
}
```

## Dummy API (For Development)

The boilerplate includes a dummy API implementation in `api_client.dart`:

### Test Credentials

```
Email: test@example.com
Password: password123
```

### Mock Response

```json
{
  "success": true,
  "message": "Login successful",
  "data": {
    "user": {
      "id": "user_12345",
      "name": "John Doe",
      "email": "test@example.com"
    },
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
  }
}
```

### Replacing with Real API

1. Update `baseUrl` in `injection_container.dart`
2. Remove dummy response logic from `api_client.dart`
3. Use a real HTTP package like `dio` or `http`

```dart
// Example with dio package
import 'package:dio/dio.dart';

class ApiClient {
  final Dio dio;
  
  ApiClient({required String baseUrl}) 
    : dio = Dio(BaseOptions(baseUrl: baseUrl));
  
  Future<Map<String, dynamic>> post(String endpoint, {Map<String, dynamic>? body}) async {
    final response = await dio.post(endpoint, data: body);
    return response.data;
  }
}
```

## Next Steps

- Add authentication token management
- Implement refresh token logic
- Add request/response interceptors
- Cache API responses
- Add pagination support

---

For more information, see [Dependency Injection Guide](./DEPENDENCY_INJECTION.md)

