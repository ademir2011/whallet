import 'package:whallet/src/auth/models/user_model.dart';

abstract class AuthEvent {}

class AuthSignInEvent extends AuthEvent {
  final UserModel userModel;

  AuthSignInEvent({required this.userModel});
}

class AuthSignUpEvent extends AuthEvent {
  final UserModel userModel;

  AuthSignUpEvent({required this.userModel});
}

class AuthSignOutEvent extends AuthEvent {}
