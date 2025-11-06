// ignore_for_file: must_be_immutable

part of 'login_bloc.dart';

/// Represents the state of Login in the application.
class LoginState extends Equatable {
  LoginState({
    this.emailController,
    this.passwordController,
    this.loginModelObj,
    this.isLoading = false,
    this.errorMessage,
    this.isSuccess = false,
  });

  TextEditingController? emailController;

  TextEditingController? passwordController;

  LoginModel? loginModelObj;
  
  /// Loading state - true when API call is in progress
  final bool isLoading;
  
  /// Error message if login fails
  final String? errorMessage;
  
  /// Success state - true when login is successful
  final bool isSuccess;

  @override
  List<Object?> get props => [
        emailController,
        passwordController,
        loginModelObj,
        isLoading,
        errorMessage,
        isSuccess,
      ];

  LoginState copyWith({
    TextEditingController? emailController,
    TextEditingController? passwordController,
    LoginModel? loginModelObj,
    bool? isLoading,
    String? errorMessage,
    bool? isSuccess,
  }) {
    return LoginState(
      emailController: emailController ?? this.emailController,
      passwordController: passwordController ?? this.passwordController,
      loginModelObj: loginModelObj ?? this.loginModelObj,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}
