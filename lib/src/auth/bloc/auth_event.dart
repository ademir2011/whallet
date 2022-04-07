import 'package:whallet/src/auth/models/user_model.dart';

abstract class AuthEvent {}

class AuthSignInEvent extends AuthEvent {
  final String email;
  final String password;

  AuthSignInEvent({required this.email, required this.password});
}

class AuthSignUpEvent extends AuthEvent {
  final String email;
  final String password;
  final String confirmPassword;

  AuthSignUpEvent({required this.email, required this.password, required this.confirmPassword});
}

class AuthSignOutEvent extends AuthEvent {}
