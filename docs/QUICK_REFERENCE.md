# Quick Reference Card

## 🔑 Test Credentials

```
Email: test@example.com
Password: password123
```

## 🚀 Quick Commands

```bash
# Initial setup
flutter pub get

# Run the app
flutter run

# Configure project
dart tool/setup.dart

# Analyze code
flutter analyze

# Run tests
flutter test
```

## 📦 Dependency Injection Cheat Sheet

### Get a Dependency
```dart
final bloc = locator<LoginBloc>();
final api = locator<ApiClient>();
```

### Register Singleton
```dart
locator.registerSingleton<ApiClient>(ApiClient());
```

### Register Factory
```dart
locator.registerFactory<MyBloc>(() => MyBloc());
```

### Use in BLoC Provider
```dart
BlocProvider<LoginBloc>(
  create: (context) => locator<LoginBloc>(),
  child: LoginScreen(),
)
```

## 🔌 API Integration Patterns

### Repository Method
```dart
Future<User> getUser() async {
  final response = await apiClient.get('/user');
  return User.fromJson(response['data']);
}
```

### Use in BLoC
```dart
Future<void> _onLoadUser(event, emit) async {
  emit(UserLoading());
  try {
    final user = await repository.getUser();
    emit(UserLoaded(user: user));
  } on ApiException catch (e) {
    emit(UserError(message: e.message));
  }
}
```

### Handle in UI
```dart
BlocBuilder<UserBloc, UserState>(
  builder: (context, state) {
    if (state is UserLoading) return LoadingWidget();
    if (state is UserLoaded) return UserWidget(state.user);
    if (state is UserError) return ErrorWidget(state.message);
    return SizedBox.shrink();
  },
)
```

## 📁 Project Structure

```
lib/
├── core/               # Utilities & DI
├── data/               # API & Models
├── presentation/       # Screens & BLoCs
├── routes/            # Navigation
├── theme/             # Styling
└── widgets/           # Reusable Widgets
```

## 📖 Documentation Links

- [Complete DI Guide](./DEPENDENCY_INJECTION.md)
- [API Integration](./API_INTEGRATION.md)
- [Setup Guide](../SETUP_GUIDE.md)
- [Main README](../README.md)

## 🛠️ Common Tasks

### Add New Screen
1. Create folder: `lib/presentation/my_screen/`
2. Create BLoC: `bloc/my_bloc.dart`
3. Create UI: `my_screen.dart`
4. Add route: `lib/routes/app_routes.dart`

### Add New Repository
1. Create: `lib/data/repositories/my_repository.dart`
2. Register in: `lib/core/di/injection_container.dart`
3. Use in BLoC via constructor injection

### Add API Endpoint
1. Add method in: `lib/data/apiClient/api_client.dart`
2. Create models in: `lib/data/models/`
3. Use in repository

## 🎨 Theming

```dart
// Use predefined styles
Text('Hello', style: CustomTextStyles.titleMediumPrimary)

// Use theme colors
Container(color: theme.colorScheme.primary)

// Use size utils
SizedBox(height: 16.v, width: 100.h)
```

## 🌍 Localization

```dart
Text("lbl_welcome".tr)  // Translated text
```

## ⚡ Tips

- Always use DI for repositories and services
- Register BLoCs as factories
- Check network before API calls
- Handle all error types
- Test with dummy credentials first

---

**Need more info?** Check the [documentation](../README.md)

