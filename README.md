# Flutter BLoC Boilerplate

[![GitHub stars](https://img.shields.io/github/stars/Hassan6197/flutter-boiler-plate?style=social)](https://github.com/Hassan6197/flutter-boiler-plate/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/Hassan6197/flutter-boiler-plate?style=social)](https://github.com/Hassan6197/flutter-boiler-plate/network/members)
[![GitHub issues](https://img.shields.io/github/issues/Hassan6197/flutter-boiler-plate)](https://github.com/Hassan6197/flutter-boiler-plate/issues)
[![GitHub license](https://img.shields.io/github/license/Hassan6197/flutter-boiler-plate)](https://github.com/Hassan6197/flutter-boiler-plate/blob/main/LICENSE)
[![Flutter Version](https://img.shields.io/badge/Flutter-3.0%2B-blue.svg)](https://flutter.dev/)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](https://github.com/Hassan6197/flutter-boiler-plate/pulls)

A production-ready Flutter boilerplate featuring clean architecture with BLoC pattern for state management. This boilerplate includes essential features like navigation, theming, localization, and network handling, making it perfect for kickstarting your next Flutter project.

> 💡 **Use this template**: Click the "Use this template" button at the top of this repository to create your own project based on this boilerplate!

## ✨ Features

- 🏗️ **Clean Architecture** - Organized project structure with clear separation of concerns
- 🔄 **BLoC Pattern** - Robust state management using flutter_bloc
- 💉 **Dependency Injection** - Manual DI pattern without external packages
- 🎨 **Theming System** - Built-in theme management with dark mode support
- 🌍 **Localization** - Multi-language support ready
- 🚀 **Navigation** - Pre-configured routing system
- 📱 **Responsive Design** - Adaptive UI with SizeUtils
- 🔌 **Network Layer** - API client with dummy login implementation
- 📦 **Example Screens** - Complete login with API integration, Dashboard
- ⚙️ **Easy Setup** - Interactive CLI tool for instant project configuration

## 📋 Table of Contents

- [Quick Start](#-quick-start)
- [Project Structure](#-project-structure)
- [Architecture](#-architecture)
- [Dependency Injection](#-dependency-injection)
- [How to Add a New Screen](#-how-to-add-a-new-screen)
- [State Management](#-state-management)
- [API Integration](#-api-integration)
- [Theming](#-theming)
- [Localization](#-localization)
- [Contributing](#-contributing)

## 🚀 Quick Start

### Prerequisites

- Flutter SDK: `>=2.12.0 <3.0.0`
- Dart SDK: `>=2.12.0 <3.0.0`

### Installation

#### Option 1: Use as GitHub Template (Recommended)

1. Click the **"Use this template"** button at the top of the [repository page](https://github.com/Hassan6197/flutter-boiler-plate)
2. Create a new repository from the template
3. Clone your new repository:
   ```bash
   git clone https://github.com/YOUR_USERNAME/YOUR_REPO_NAME.git
   cd YOUR_REPO_NAME
   ```

#### Option 2: Clone Directly

1. **Clone this repository**
   ```bash
   git clone https://github.com/Hassan6197/flutter-boiler-plate.git
   cd flutter-boiler-plate
   ```

2. **Run the setup script** (Most Important Step!)
   ```bash
   dart run tool/setup.dart
   ```
   
   This interactive script will prompt you for:
   - App Display Name (e.g., "My Awesome App")
   - Package Name (e.g., "com.company.myapp")
   - Project Name (e.g., "my_awesome_app")

   It will automatically update all necessary files including:
   - `pubspec.yaml`
   - All Dart import statements
   - Android configuration (build.gradle, AndroidManifest.xml, MainActivity.kt)
   - iOS configuration (Info.plist, project.pbxproj)

   **Dry Run Mode**: Preview changes without applying them
   ```bash
   dart run tool/setup.dart --dry-run
   ```

3. **Install dependencies**
   ```bash
   flutter pub get
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

## 📁 Project Structure

```
lib/
├── core/                      # Core utilities and constants
│   ├── constants/            # App constants
│   ├── errors/               # Error handling
│   ├── network/              # Network info and connectivity
│   └── utils/                # Utility functions and helpers
│       ├── image_constant.dart
│       ├── logger.dart
│       ├── navigator_service.dart
│       ├── pref_utils.dart   # SharedPreferences wrapper
│       └── size_utils.dart   # Responsive design utilities
│
├── data/                      # Data layer
│   ├── apiClient/            # API client setup
│   └── models/               # Data models
│
├── localization/             # Localization files
│   └── app_localization.dart
│
├── presentation/             # UI layer
│   ├── splash_screen/
│   │   ├── bloc/            # BLoC for splash screen
│   │   │   ├── splash_bloc.dart
│   │   │   ├── splash_event.dart
│   │   │   └── splash_state.dart
│   │   ├── models/          # Screen-specific models
│   │   └── splash_screen.dart
│   │
│   ├── login_screen/        # Example: Authentication screen
│   └── dashboard_page/      # Example: List screen with navigation
│
├── routes/                   # Navigation
│   └── app_routes.dart      # Route definitions
│
├── theme/                    # Theming
│   ├── app_decoration.dart  # Decoration styles
│   ├── custom_text_style.dart
│   ├── custom_button_style.dart
│   ├── theme_helper.dart
│   └── bloc/                # Theme management BLoC
│
├── widgets/                  # Reusable widgets
│   ├── custom_elevated_button.dart
│   ├── custom_text_form_field.dart
│   ├── custom_image_view.dart
│   └── app_bar/             # Custom app bar components
│
└── main.dart                 # App entry point
```

## 🏗️ Architecture

This boilerplate follows a **Clean Architecture** approach with clear separation between:

### Layers

1. **Presentation Layer** (`lib/presentation/`)
   - Contains UI components and BLoC for state management
   - Each screen has its own folder with `bloc/`, `models/`, and `widgets/`

2. **Data Layer** (`lib/data/`)
   - Handles data operations, API calls, and data models
   - Contains API client and data repositories

3. **Core Layer** (`lib/core/`)
   - Contains utilities, constants, and services used across the app
   - No dependencies on other layers

### BLoC Pattern

Each screen follows this structure:

```
screen_name/
├── bloc/
│   ├── screen_name_bloc.dart    # Business logic
│   ├── screen_name_event.dart   # Events (user actions)
│   └── screen_name_state.dart   # States (UI states)
├── models/
│   └── screen_name_model.dart   # Screen-specific data models
├── widgets/                      # Screen-specific widgets (optional)
└── screen_name.dart             # UI implementation
```

## 💉 Dependency Injection

This boilerplate uses a **manual Service Locator pattern** for dependency injection without external packages.

### Why DI?

- ✅ **Testability**: Easy to mock dependencies in tests
- ✅ **Flexibility**: Swap implementations without changing code
- ✅ **Maintainability**: Clear and explicit dependencies

### How It Works

```dart
// 1. Register dependencies in main.dart
await initializeDependencies();

// 2. Retrieve dependencies using locator
final loginBloc = locator<LoginBloc>();

// 3. Dependencies are automatically injected
class LoginBloc {
  final AuthRepository repository; // Injected automatically
  
  LoginBloc({required this.repository});
}
```

### Registration Patterns

#### Singleton (Created Once)
```dart
locator.registerSingleton<ApiClient>(
  ApiClient(baseUrl: 'https://api.example.com'),
);
```
**Use for**: API Client, NetworkInfo, Services

#### Lazy Singleton (Created on First Use)
```dart
locator.registerLazySingleton<DatabaseService>(
  () => DatabaseService(),
);
```
**Use for**: Heavy services that might not be needed immediately

#### Factory (New Instance Each Time)
```dart
locator.registerFactory<LoginBloc>(
  () => LoginBloc(authRepository: locator<AuthRepository>()),
);
```
**Use for**: BLoCs, ViewModels (to avoid state issues)

### Complete Example

#### Step 1: Register in `injection_container.dart`

```dart
class InjectionContainer {
  static Future<void> init() async {
    // Register API Client
    locator.registerSingleton<ApiClient>(
      ApiClient(baseUrl: 'https://api.example.com'),
    );
    
    // Register Repository
    locator.registerSingleton<AuthRepository>(
      AuthRepository(apiClient: locator<ApiClient>()),
    );
    
    // Register BLoC
    locator.registerFactory<LoginBloc>(
      () => LoginBloc(authRepository: locator<AuthRepository>()),
    );
  }
}
```

#### Step 2: Use in Screen

```dart
static Widget builder(BuildContext context) {
  return BlocProvider<LoginBloc>(
    create: (context) => locator<LoginBloc>(), // Get from DI
    child: LoginScreen(),
  );
}
```

### Full Login Example with API

This boilerplate includes a complete working example:

**Test Credentials**:
- Email: `test@example.com`
- Password: `password123`

The login flow demonstrates:
1. Form validation
2. API call through repository
3. Loading states
4. Error handling
5. Success navigation

Try it in the app to see DI and API integration in action!

### Learn More

- 📖 [Complete DI Guide](docs/DEPENDENCY_INJECTION.md)
- 🔌 [API Integration Guide](docs/API_INTEGRATION.md)

## 📱 How to Add a New Screen

Follow these steps to add a new screen with BLoC:

### 1. Create Screen Structure

```bash
lib/presentation/profile_screen/
├── bloc/
├── models/
└── profile_screen.dart
```

### 2. Create Model

```dart
// models/profile_model.dart
import 'package:equatable/equatable.dart';

class ProfileModel extends Equatable {
  final String name;
  final String email;

  ProfileModel({this.name = '', this.email = ''});

  ProfileModel copyWith({String? name, String? email}) {
    return ProfileModel(
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }

  @override
  List<Object?> get props => [name, email];
}
```

### 3. Create BLoC Events

```dart
// bloc/profile_event.dart
part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProfileInitialEvent extends ProfileEvent {}

class UpdateProfileEvent extends ProfileEvent {
  final String name;
  final String email;

  UpdateProfileEvent({required this.name, required this.email});

  @override
  List<Object?> get props => [name, email];
}
```

### 4. Create BLoC State

```dart
// bloc/profile_state.dart
part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  final ProfileModel? profileModelObj;

  ProfileState({this.profileModelObj});

  @override
  List<Object?> get props => [profileModelObj];

  ProfileState copyWith({ProfileModel? profileModelObj}) {
    return ProfileState(
      profileModelObj: profileModelObj ?? this.profileModelObj,
    );
  }
}
```

### 5. Create BLoC

```dart
// bloc/profile_bloc.dart
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/profile_model.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(ProfileState initialState) : super(initialState) {
    on<ProfileInitialEvent>(_onInitialize);
    on<UpdateProfileEvent>(_onUpdateProfile);
  }

  _onInitialize(ProfileInitialEvent event, Emitter<ProfileState> emit) async {
    // Initialize data
    emit(state.copyWith(
      profileModelObj: ProfileModel(name: 'John Doe', email: 'john@example.com')
    ));
  }

  _onUpdateProfile(UpdateProfileEvent event, Emitter<ProfileState> emit) async {
    final updatedModel = state.profileModelObj?.copyWith(
      name: event.name,
      email: event.email,
    );
    emit(state.copyWith(profileModelObj: updatedModel));
  }
}
```

### 6. Create UI Screen

```dart
// profile_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/profile_bloc.dart';
import 'models/profile_model.dart';

class ProfileScreen extends StatelessWidget {
  static Widget builder(BuildContext context) {
    return BlocProvider<ProfileBloc>(
      create: (context) => ProfileBloc(ProfileState(profileModelObj: ProfileModel()))
        ..add(ProfileInitialEvent()),
      child: ProfileScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          return Column(
            children: [
              Text('Name: ${state.profileModelObj?.name ?? ''}'),
              Text('Email: ${state.profileModelObj?.email ?? ''}'),
            ],
          );
        },
      ),
    );
  }
}
```

### 7. Add Route

```dart
// routes/app_routes.dart
class AppRoutes {
  static const String profileScreen = '/profile_screen';
  
  static Map<String, WidgetBuilder> get routes => {
    profileScreen: ProfileScreen.builder,
    // ... other routes
  };
}
```

## 🔄 State Management

This boilerplate uses **flutter_bloc** for state management. Key concepts:

### Events
Events represent user actions or system events:
```dart
context.read<ProfileBloc>().add(UpdateProfileEvent(name: 'John', email: 'john@example.com'));
```

### States
States represent the UI state at any given time. Use `BlocBuilder` to rebuild UI:
```dart
BlocBuilder<ProfileBloc, ProfileState>(
  builder: (context, state) {
    return Text(state.profileModelObj?.name ?? '');
  },
)
```

### BlocSelector
For performance, use `BlocSelector` to rebuild only when specific state changes:
```dart
BlocSelector<ProfileBloc, ProfileState, String?>(
  selector: (state) => state.profileModelObj?.name,
  builder: (context, name) {
    return Text(name ?? '');
  },
)
```

## 🎨 Theming

### Using Theme
```dart
// Access theme
Text('Hello', style: theme.textTheme.titleMedium);

// Access custom text styles
Text('Hello', style: CustomTextStyles.labelLargeCyan300);

// Access app theme colors
Container(color: appTheme.cyan300);
```

### Switching Themes
```dart
context.read<ThemeBloc>().add(ChangeThemeEvent(themeType: ThemeType.dark));
```

## 🔌 API Integration

### 1. Setup API Client

```dart
// data/apiClient/api_client.dart
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiClient {
  static const String baseUrl = 'https://api.example.com';

  Future<Map<String, dynamic>> get(String endpoint) async {
    final response = await http.get(Uri.parse('$baseUrl$endpoint'));
    
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<Map<String, dynamic>> post(String endpoint, Map<String, dynamic> body) async {
    final response = await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(body),
    );
    
    if (response.statusCode == 200 || response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to post data');
    }
  }
}
```

### 2. Use in BLoC

```dart
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ApiClient apiClient = ApiClient();

  _onLoadProfile(LoadProfileEvent event, Emitter<ProfileState> emit) async {
    try {
      final data = await apiClient.get('/profile');
      emit(state.copyWith(profileModelObj: ProfileModel.fromJson(data)));
    } catch (e) {
      // Handle error
      print('Error: $e');
    }
  }
}
```

## 🌍 Localization

### Add New Translation

```dart
// localization/app_localization.dart
Map<String, String> enUs() {
  return {
    'lbl_welcome': 'Welcome',
    'msg_hello_user': 'Hello, @name!',
  };
}
```

### Use in UI

```dart
Text("lbl_welcome".tr);  // Output: Welcome
Text("msg_hello_user".tr.replaceAll('@name', 'John'));  // Output: Hello, John!
```

## 🛠️ Additional Configuration

### Environment Variables

Create `.env` file for sensitive data:
```
API_BASE_URL=https://api.example.com
API_KEY=your_api_key_here
```

### Firebase Setup (Optional)

1. Add `google-services.json` for Android
2. Add `GoogleService-Info.plist` for iOS
3. Update dependencies in `pubspec.yaml`

## 📚 Dependencies

Key dependencies included:

- `flutter_bloc` - State management
- `equatable` - Value equality
- `cached_network_image` - Image caching
- `shared_preferences` - Local storage
- `connectivity_plus` - Network connectivity
- `flutter_svg` - SVG support
- `intl` - Internationalization

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

## 💡 Tips

- Always run `flutter pub get` after cloning
- Use the setup script for proper project configuration
- Follow the BLoC pattern for consistency
- Keep widgets small and reusable
- Use const constructors wherever possible for better performance

## 🆘 Support

For issues, questions, or contributions, please visit the [GitHub repository](https://github.com/Hassan6197/flutter-boiler-plate).

- 🐛 [Report Bug](https://github.com/Hassan6197/flutter-boiler-plate/issues/new?labels=bug)
- 💡 [Request Feature](https://github.com/Hassan6197/flutter-boiler-plate/issues/new?labels=enhancement)
- 💬 [Start Discussion](https://github.com/Hassan6197/flutter-boiler-plate/discussions)

---

Happy Coding! 🚀
