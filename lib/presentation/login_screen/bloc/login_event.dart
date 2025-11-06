// ignore_for_file: must_be_immutable

part of 'login_bloc.dart';

/// Abstract class for all events that can be dispatched from the
/// Login widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class LoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Event that is dispatched when the Login widget is first created.
class LoginInitialEvent extends LoginEvent {
  @override
  List<Object?> get props => [];
}

/// Event that is dispatched when the login button is pressed
/// 
/// This triggers the login API call with email and password
class LoginButtonPressed extends LoginEvent {
  final String email;
  final String password;
  
  LoginButtonPressed({
    required this.email,
    required this.password,
  });
  
  @override
  List<Object?> get props => [email, password];
}
