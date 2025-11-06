import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '/core/app_export.dart';
import 'package:flutter_bloc_boilerplate/core/errors/api_exceptions.dart' as api_ex;
import 'package:flutter_bloc_boilerplate/data/repositories/auth_repository.dart';
import 'package:flutter_bloc_boilerplate/presentation/login_screen/models/login_model.dart';

part 'login_event.dart';
part 'login_state.dart';

/// A bloc that manages the state of a Login according to the event that is dispatched to it.
/// 
/// This BLoC demonstrates dependency injection pattern.
/// The AuthRepository is injected through the constructor.
/// 
/// Example usage:
/// ```dart
/// BlocProvider<LoginBloc>(
///   create: (context) => locator<LoginBloc>(),
///   child: LoginScreen(),
/// )
/// ```
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;
  
  /// Constructor with dependency injection
  /// 
  /// [authRepository] is injected from the service locator
  LoginBloc({
    required this.authRepository,
  }) : super(LoginState()) {
    on<LoginInitialEvent>(_onInitialize);
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }

  /// Initialize the login screen
  /// 
  /// Sets up text controllers for email and password fields
  _onInitialize(
    LoginInitialEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(
      emailController: TextEditingController(),
      passwordController: TextEditingController(),
      isLoading: false,
      errorMessage: null,
      isSuccess: false,
    ));
  }
  
  /// Handle login button press
  /// 
  /// This is where the API call happens through the repository
  Future<void> _onLoginButtonPressed(
    LoginButtonPressed event,
    Emitter<LoginState> emit,
  ) async {
    // Start loading
    emit(state.copyWith(
      isLoading: true,
      errorMessage: null,
      isSuccess: false,
    ));
    
    try {
      // Call repository to perform login
      final response = await authRepository.login(
        email: event.email,
        password: event.password,
      );
      
      // Check if login was successful
      if (response.success && response.data != null) {
        print('✅ Login successful in BLoC');
        print('👤 User: ${response.data!.user.name}');
        print('📧 Email: ${response.data!.user.email}');
        
        // Emit success state
        emit(state.copyWith(
          isLoading: false,
          isSuccess: true,
          errorMessage: null,
        ));
      } else {
        // Handle unsuccessful response
        emit(state.copyWith(
          isLoading: false,
          isSuccess: false,
          errorMessage: response.message.isNotEmpty 
              ? response.message 
              : 'Login failed. Please try again.',
        ));
      }
    } on api_ex.UnauthorizedException catch (e) {
      // Handle authentication errors (wrong credentials)
      print('❌ Unauthorized: ${e.message}');
      emit(state.copyWith(
        isLoading: false,
        isSuccess: false,
        errorMessage: 'Invalid email or password',
      ));
    } on api_ex.NetworkException catch (e) {
      // Handle network errors
      print('❌ Network error: ${e.message}');
      emit(state.copyWith(
        isLoading: false,
        isSuccess: false,
        errorMessage: 'No internet connection. Please check your network.',
      ));
    } on api_ex.ValidationException catch (e) {
      // Handle validation errors
      print('❌ Validation error: ${e.message}');
      emit(state.copyWith(
        isLoading: false,
        isSuccess: false,
        errorMessage: e.message,
      ));
    } on api_ex.ApiException catch (e) {
      // Handle other API errors
      print('❌ API error: ${e.message}');
      emit(state.copyWith(
        isLoading: false,
        isSuccess: false,
        errorMessage: e.message,
      ));
    } catch (e) {
      // Handle unexpected errors
      print('❌ Unexpected error: $e');
      emit(state.copyWith(
        isLoading: false,
        isSuccess: false,
        errorMessage: 'An unexpected error occurred. Please try again.',
      ));
    }
  }
}
