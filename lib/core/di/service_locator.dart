/// Service Locator Pattern for Dependency Injection
/// 
/// This is a simple, manual implementation of dependency injection
/// without requiring external packages like get_it.
/// 
/// Usage:
/// ```dart
/// // Register a singleton (created once, reused)
/// locator.registerSingleton<ApiClient>(ApiClient());
/// 
/// // Register a lazy singleton (created on first access)
/// locator.registerLazySingleton<NetworkInfo>(() => NetworkInfo());
/// 
/// // Register a factory (new instance each time)
/// locator.registerFactory<LoginBloc>(() => LoginBloc(locator<AuthRepository>()));
/// 
/// // Retrieve a dependency
/// final apiClient = locator<ApiClient>();
/// ```

class ServiceLocator {
  // Private constructor for singleton pattern
  ServiceLocator._internal();
  
  // Single instance of service locator
  static final ServiceLocator _instance = ServiceLocator._internal();
  
  // Public accessor
  static ServiceLocator get instance => _instance;
  
  // Storage for different types of registrations
  final Map<Type, dynamic> _singletons = {};
  final Map<Type, dynamic Function()> _lazySingletons = {};
  final Map<Type, dynamic Function()> _factories = {};
  
  /// Register a singleton instance
  /// 
  /// The instance is created immediately and reused every time.
  /// Best for: Services that need to maintain state, expensive to create objects
  /// Example: ApiClient, NetworkInfo
  void registerSingleton<T extends Object>(T instance) {
    _singletons[T] = instance;
  }
  
  /// Register a lazy singleton
  /// 
  /// The instance is created only when first accessed, then reused.
  /// Best for: Heavy objects that might not be needed immediately
  /// Example: DatabaseService, CacheManager
  void registerLazySingleton<T extends Object>(T Function() factory) {
    _lazySingletons[T] = factory;
  }
  
  /// Register a factory
  /// 
  /// A new instance is created every time it's requested.
  /// Best for: BLoCs, ViewModels, Use Cases
  /// Example: LoginBloc, DashboardBloc
  void registerFactory<T extends Object>(T Function() factory) {
    _factories[T] = factory;
  }
  
  /// Get an instance of type T
  /// 
  /// Throws an exception if the dependency is not registered.
  T call<T extends Object>() {
    return get<T>();
  }
  
  /// Get an instance of type T
  /// 
  /// Lookup order: Singleton → Lazy Singleton → Factory
  T get<T extends Object>() {
    // Check if it's a singleton
    if (_singletons.containsKey(T)) {
      return _singletons[T] as T;
    }
    
    // Check if it's a lazy singleton
    if (_lazySingletons.containsKey(T)) {
      // Create and cache the instance
      final instance = _lazySingletons[T]!() as T;
      _singletons[T] = instance;
      _lazySingletons.remove(T);
      return instance;
    }
    
    // Check if it's a factory
    if (_factories.containsKey(T)) {
      return _factories[T]!() as T;
    }
    
    throw Exception(
      'Dependency of type $T is not registered.\n'
      'Make sure to register it in injection_container.dart',
    );
  }
  
  /// Check if a dependency is registered
  bool isRegistered<T extends Object>() {
    return _singletons.containsKey(T) ||
        _lazySingletons.containsKey(T) ||
        _factories.containsKey(T);
  }
  
  /// Reset all dependencies (useful for testing)
  void reset() {
    _singletons.clear();
    _lazySingletons.clear();
    _factories.clear();
  }
  
  /// Unregister a specific dependency
  void unregister<T extends Object>() {
    _singletons.remove(T);
    _lazySingletons.remove(T);
    _factories.remove(T);
  }
}

// Global instance for easy access
final locator = ServiceLocator.instance;

