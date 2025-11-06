# Dependency Injection Guide

## Table of Contents
- [What is Dependency Injection?](#what-is-dependency-injection)
- [Why Use DI?](#why-use-di)
- [Our Implementation](#our-implementation)
- [How to Use](#how-to-use)
- [Registration Patterns](#registration-patterns)
- [Adding New Dependencies](#adding-new-dependencies)
- [Testing with DI](#testing-with-di)
- [Best Practices](#best-practices)

## What is Dependency Injection?

Dependency Injection (DI) is a design pattern where objects receive their dependencies from external sources rather than creating them internally. Instead of a class creating its dependencies, they are "injected" from outside.

### Without DI (Bad):
```dart
class LoginBloc {
  final AuthRepository repository = AuthRepository(); // Tightly coupled
  
  Future<void> login() async {
    await repository.login();
  }
}
```

### With DI (Good):
```dart
class LoginBloc {
  final AuthRepository repository; // Injected dependency
  
  LoginBloc({required this.repository}); // Dependency injected via constructor
  
  Future<void> login() async {
    await repository.login();
  }
}
```

## Why Use DI?

1. **Testability**: Easy to mock dependencies in tests
2. **Flexibility**: Change implementations without modifying code
3. **Maintainability**: Clear dependencies, easier to understand
4. **Reusability**: Components can be used in different contexts
5. **Loose Coupling**: Classes don't depend on concrete implementations

## Our Implementation

This boilerplate uses a **manual Service Locator pattern** without external packages. It provides three registration types:

### Service Locator (`lib/core/di/service_locator.dart`)

A simple dependency container that stores and retrieves dependencies.

```dart
final locator = ServiceLocator.instance;

// Register
locator.registerSingleton<ApiClient>(ApiClient());

// Retrieve
final api = locator<ApiClient>();
```

### Injection Container (`lib/core/di/injection_container.dart`)

Central place where all dependencies are registered.

```dart
await initializeDependencies(); // Call in main.dart
```

## How to Use

### 1. Registering Dependencies

All dependencies are registered in `injection_container.dart`:

```dart
class InjectionContainer {
  static Future<void> init() async {
    // Register your dependencies here
    locator.registerSingleton<ApiClient>(
      ApiClient(baseUrl: 'https://api.example.com'),
    );
    
    locator.registerFactory<LoginBloc>(
      () => LoginBloc(authRepository: locator<AuthRepository>()),
    );
  }
}
```

### 2. Retrieving Dependencies

#### In BLoC Providers:

```dart
BlocProvider<LoginBloc>(
  create: (context) => locator<LoginBloc>(), // Get from service locator
  child: LoginScreen(),
)
```

#### In Regular Classes:

```dart
class MyClass {
  final ApiClient apiClient = locator<ApiClient>();
  
  // Or via constructor injection
  final ApiClient apiClient;
  MyClass({required this.apiClient});
}

// Usage
final myClass = MyClass(apiClient: locator<ApiClient>());
```

## Registration Patterns

### 1. Singleton
Created **once** and reused throughout the app's lifecycle.

**Use for**: Services that maintain state or are expensive to create.

```dart
locator.registerSingleton<ApiClient>(
  ApiClient(baseUrl: 'https://api.example.com'),
);
```

**Examples**:
- ApiClient
- NetworkInfo
- Database services
- Cache managers

### 2. Lazy Singleton
Created **on first access** and then reused.

**Use for**: Heavy objects that might not be needed immediately.

```dart
locator.registerLazySingleton<DatabaseService>(
  () => DatabaseService(),
);
```

**Examples**:
- Database connections
- Large configuration objects
- Analytics services

### 3. Factory
**New instance** created every time it's requested.

**Use for**: BLoCs, ViewModels, Use Cases.

```dart
locator.registerFactory<LoginBloc>(
  () => LoginBloc(authRepository: locator<AuthRepository>()),
);
```

**Examples**:
- BLoCs (to avoid state issues)
- ViewModels
- Use Cases
- Commands

## Adding New Dependencies

### Step 1: Create Your Service/Repository

```dart
// lib/data/repositories/user_repository.dart
class UserRepository {
  final ApiClient apiClient;
  
  UserRepository({required this.apiClient});
  
  Future<User> getProfile() async {
    final response = await apiClient.get('/user/profile');
    return User.fromJson(response['data']);
  }
}
```

### Step 2: Register in Injection Container

```dart
// lib/core/di/injection_container.dart
class InjectionContainer {
  static Future<void> init() async {
    // ... existing registrations
    
    // Add your new repository
    locator.registerSingleton<UserRepository>(
      UserRepository(apiClient: locator<ApiClient>()),
    );
    
    // Add BLoC that uses it
    locator.registerFactory<ProfileBloc>(
      () => ProfileBloc(userRepository: locator<UserRepository>()),
    );
  }
}
```

### Step 3: Use in Your BLoC

```dart
// lib/presentation/profile_screen/bloc/profile_bloc.dart
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepository userRepository; // Injected dependency
  
  ProfileBloc({required this.userRepository}) : super(ProfileInitial()) {
    on<LoadProfile>(_onLoadProfile);
  }
  
  Future<void> _onLoadProfile(
    LoadProfile event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      final user = await userRepository.getProfile();
      emit(ProfileLoaded(user: user));
    } catch (e) {
      emit(ProfileError(message: e.toString()));
    }
  }
}
```

### Step 4: Use in Your Screen

```dart
// lib/presentation/profile_screen/profile_screen.dart
static Widget builder(BuildContext context) {
  return BlocProvider<ProfileBloc>(
    create: (context) => locator<ProfileBloc>() // Get from service locator
      ..add(LoadProfile()),
    child: ProfileScreen(),
  );
}
```

## Testing with DI

### Mocking Dependencies

```dart
// test/login_bloc_test.dart
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

// Create mock
class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late LoginBloc loginBloc;
  late MockAuthRepository mockRepository;
  
  setUp(() {
    mockRepository = MockAuthRepository();
    // Inject mock instead of real dependency
    loginBloc = LoginBloc(authRepository: mockRepository);
  });
  
  test('login success emits success state', () async {
    // Arrange
    when(mockRepository.login(
      email: 'test@example.com',
      password: 'password',
    )).thenAnswer((_) async => LoginResponse(success: true));
    
    // Act
    loginBloc.add(LoginButtonPressed(
      email: 'test@example.com',
      password: 'password',
    ));
    
    // Assert
    await expectLater(
      loginBloc.stream,
      emitsInOrder([
        LoginLoading(),
        LoginSuccess(),
      ]),
    );
  });
}
```

## Best Practices

### ✅ DO

1. **Register early**: Initialize DI in `main()` before `runApp()`
2. **Constructor injection**: Pass dependencies via constructor
3. **Depend on abstractions**: Use interfaces/abstract classes when possible
4. **Single responsibility**: Each service should have one purpose
5. **Factory for stateful**: Use factory registration for BLoCs

```dart
// Good
class LoginBloc {
  final AuthRepository repository;
  LoginBloc({required this.repository});
}
```

### ❌ DON'T

1. **Don't create dependencies inside classes**
2. **Don't use service locator directly in business logic**
3. **Don't register mutable singletons for UI state**
4. **Don't circular dependencies**

```dart
// Bad
class LoginBloc {
  final repository = AuthRepository(); // Creates dependency
  final api = locator<ApiClient>(); // Uses locator directly
}
```

## Common Patterns

### Repository Pattern

```dart
// Abstract interface
abstract class AuthRepository {
  Future<LoginResponse> login({required String email, required String password});
}

// Concrete implementation
class AuthRepositoryImpl implements AuthRepository {
  final ApiClient apiClient;
  
  AuthRepositoryImpl({required this.apiClient});
  
  @override
  Future<LoginResponse> login({
    required String email,
    required String password,
  }) async {
    final response = await apiClient.post('/auth/login', body: {
      'email': email,
      'password': password,
    });
    return LoginResponse.fromJson(response);
  }
}

// Registration
locator.registerSingleton<AuthRepository>(
  AuthRepositoryImpl(apiClient: locator<ApiClient>()),
);
```

### Use Case Pattern (Optional)

```dart
// Use case encapsulates business logic
class LoginUseCase {
  final AuthRepository repository;
  
  LoginUseCase({required this.repository});
  
  Future<Result<LoginData>> execute({
    required String email,
    required String password,
  }) async {
    try {
      final response = await repository.login(email: email, password: password);
      return Success(response.data);
    } on ApiException catch (e) {
      return Failure(e.message);
    }
  }
}

// Registration
locator.registerFactory<LoginUseCase>(
  () => LoginUseCase(repository: locator<AuthRepository>()),
);
```

## Debugging

### Check if dependency is registered:

```dart
if (locator.isRegistered<ApiClient>()) {
  print('ApiClient is registered');
} else {
  print('ApiClient is NOT registered');
}
```

### Reset for testing:

```dart
tearDown(() {
  locator.reset(); // Clear all registrations
});
```

## Example: Complete Flow

Here's how it all works together:

```dart
// 1. main.dart - Initialize DI
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies(); // Initialize all dependencies
  runApp(MyApp());
}

// 2. injection_container.dart - Register dependencies
class InjectionContainer {
  static Future<void> init() async {
    locator.registerSingleton<ApiClient>(ApiClient());
    locator.registerSingleton<AuthRepository>(
      AuthRepository(apiClient: locator<ApiClient>()),
    );
    locator.registerFactory<LoginBloc>(
      () => LoginBloc(authRepository: locator<AuthRepository>()),
    );
  }
}

// 3. login_screen.dart - Use dependency
static Widget builder(BuildContext context) {
  return BlocProvider<LoginBloc>(
    create: (context) => locator<LoginBloc>(), // Get from DI
    child: LoginScreen(),
  );
}

// 4. login_bloc.dart - Injected repository is used
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository; // Injected
  
  LoginBloc({required this.authRepository}) : super(LoginInitial());
  
  Future<void> _onLogin(LoginEvent event, Emitter emit) async {
    final response = await authRepository.login(...);
    // Handle response
  }
}
```

## Further Reading

- [Dependency Injection - Wikipedia](https://en.wikipedia.org/wiki/Dependency_injection)
- [SOLID Principles](https://en.wikipedia.org/wiki/SOLID)
- [Flutter BLoC Testing](https://bloclibrary.dev/#/testing)

---

For questions or issues, please open an issue on GitHub.

