import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc_boilerplate/core/di/service_locator.dart';
import 'package:flutter_bloc_boilerplate/core/network/network_info.dart';
import 'package:flutter_bloc_boilerplate/core/utils/pref_utils.dart';
import 'package:flutter_bloc_boilerplate/data/apiClient/api_client.dart';
import 'package:flutter_bloc_boilerplate/data/repositories/auth_repository.dart';
import 'package:flutter_bloc_boilerplate/presentation/login_screen/bloc/login_bloc.dart';

/// Dependency Injection Container
/// 
/// This file registers all dependencies using the Service Locator pattern.
/// All services, repositories, and BLoCs should be registered here.
/// 
/// Call `await initializeDependencies()` in main.dart before runApp()

class InjectionContainer {
  /// Initialize all dependencies
  /// 
  /// This method should be called once at app startup
  static Future<void> init() async {
    // ============================================
    // Core Services (Singletons)
    // ============================================
    // These services are created once and reused throughout the app
    
    // Network connectivity checker
    locator.registerSingleton<NetworkInfo>(
      NetworkInfo(),
    );
    
    // SharedPreferences wrapper (already initialized)
    locator.registerSingleton<PrefUtils>(
      PrefUtils(),
    );
    
    // API Client with base configuration
    locator.registerSingleton<ApiClient>(
      ApiClient(
        baseUrl: 'https://api.example.com', // Change to your API URL
        timeout: const Duration(seconds: 30),
      ),
    );
    
    // ============================================
    // Repositories (Singletons)
    // ============================================
    // Repositories handle data operations and business logic
    
    locator.registerSingleton<AuthRepository>(
      AuthRepository(
        apiClient: locator<ApiClient>(),
        networkInfo: locator<NetworkInfo>(),
      ),
    );
    
    // ============================================
    // BLoCs (Factories)
    // ============================================
    // BLoCs are created fresh each time to avoid state issues
    
    locator.registerFactory<LoginBloc>(
      () => LoginBloc(
        authRepository: locator<AuthRepository>(),
      ),
    );
    
    // Add more BLoC registrations here as your app grows
    // Example:
    // locator.registerFactory<DashboardBloc>(
    //   () => DashboardBloc(
    //     repository: locator<SomeRepository>(),
    //   ),
    // );
  }
  
  /// Reset all dependencies (useful for testing)
  static void reset() {
    locator.reset();
  }
}

/// Convenience function to initialize dependencies
Future<void> initializeDependencies() async {
  await InjectionContainer.init();
}

